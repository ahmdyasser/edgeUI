//
//  QuestionDetailsViewModel.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 21/05/2023.
//

import SwiftUI
import Alamofire

enum VoteType: String {
  case upvote
  case downvote
}

enum TargetType: String {
  case question
  case answer
}
@MainActor class QuestionDetailsViewModel: ObservableObject {
  @Published var answers: [QuestionResponseAnswer] = []
  @Published var tags: [String] = []
  @Published var title: String = ""
  @Published var content: String = ""
  @Published var id = ""
  @Published var username: String = ""
  @Published var votes: Int = 0
  var endpoint = ""

  func getFormattedDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    let date = Date()
    let shortDateString = dateFormatter.string(from: date)
    return shortDateString
  }

  func getQuestionDetails(questionID: String) {
    AF.request("http://127.0.0.1:8000/qna/question/\(questionID)")
      .validate()
      .responseDecodable(of: QuestionDetailsResponse.self) { result in
        self.title = result.value?.title ?? "[TITLE]"
        self.content = result.value?.content ?? "[CONTENT]"
        self.answers = result.value?.answers ?? []
        self.tags = result.value?.tags ?? []
        self.username = result.value?.author.username ?? "[USERNAME]"
        self.id = result.value?.id ?? "[ID]"
        self.votes = (result.value?.upvotes ?? 0) - (result.value?.downvotes ?? 0)
      }
  }

  func acceptAnswer(answerId: String) {
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .authorization(bearerToken: tokenString)
    ]

    AF.request("http://127.0.0.1:8000/qna/answer/\(answerId)/accept/", method: .post, headers: headers)
      .validate()
      .responseDecodable(of: AskQuestionResponseModel.self) { response in
        print(response.result)
      }
  }

  func deleteAnswer(answerId: String) {
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .authorization(bearerToken: tokenString)
    ]

    AF.request("http://127.0.0.1:8000/qna/answer/\(answerId)/delete/", method: .post, headers: headers)
      .validate()
      .responseDecodable(of: AskQuestionResponseModel.self) { response in
        print(response.result)
      }

  }



  func postAnswer(model: QuestionPostAnswer, questionId: String) {
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .accept("application/json"),
      .authorization(bearerToken: tokenString)
    ]
    AF.request("http://127.0.0.1:8000/qna/question/\(questionId)/answer/add/", method: .post, parameters: model, encoder: .json, headers: headers)
      .validate()
      .responseDecodable(of: AskQuestionResponseModel.self) { result in
        print(result)
      }
  }

  func vote(target: TargetType, id: String, voteType: VoteType) -> Int {
    var votes = 0

    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .authorization(bearerToken: tokenString)
    ]
    switch target {
    case .question:
      endpoint = "http://127.0.0.1:8000/qna/question/\(id)/\(voteType.rawValue)/"
    case .answer:
      endpoint = "http://127.0.0.1:8000/qna/answer/\(id)/\(voteType.rawValue)/"
    }

    AF.request(endpoint, method: .post, headers: headers)
      .validate()
      .responseDecodable(of: VoteResponseModel.self) { result in
        print(result)
        votes = (result.value?.downvotes ?? 0) + (result.value?.upvotes ?? 0)
      }
    return votes
  }

}
