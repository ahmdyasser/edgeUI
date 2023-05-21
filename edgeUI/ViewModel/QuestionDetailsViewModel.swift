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
  @Published var title: String = ""
  @Published var content: String = ""
  @Published var id = ""

  func vote(target: TargetType, id: String, voteType: VoteType) -> Int {
    var votes = 0
    var endpoint = ""
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .authorization(bearerToken: tokenString)
    ]
    switch target {
    case .question:
      endpoint = "http://127.0.0.1:8000/qna/question/\(id)/\(voteType.rawValue)"
    case .answer:
      endpoint = "http://127.0.0.1:8000/qna/answer/\(id)/\(voteType.rawValue)"
    }
    AF.request(endpoint, headers: headers)
      .validate()
      .responseDecodable(of: VoteResponseModel.self) { result in
        result.value
        votes = (result.value?.downvotes ?? 0) + (result.value?.upvotes ?? 0)
      }
    return votes
  }


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

  func postAnswer(model: QuestionPostAnswer, questionId: String) {
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .accept("application/json"),
      .authorization(bearerToken: tokenString)
    ]
    AF.request("http://127.0.0.1:8000/qna/question/\(questionId)/answer/add/", method: .post, parameters: model, encoder: .json, headers: headers)
      .validate()
      .responseDecodable(of: QuestionResponseAnswer.self) { result in
        print(result)
      }
  }

}
