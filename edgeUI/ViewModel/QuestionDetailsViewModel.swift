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
  @Published var comments: [QuestionResponseComment] = []
  @Published var id = ""
  
  let model = QuestionResponseComment(author: "ahmd yasser", date: "2023-1-1", content: "this is the comment on the quesiotn", isAccepted: true)

  func vote(target: TargetType, id: String, voteType: VoteType) -> Int {
    var votes = 0
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .authorization(bearerToken: tokenString)
    ]
    var endpoint = ""
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

  func downvoteQuestion() -> Int {
    return 2
  }

  func getComments() {
    comments.append(model)
  }

  func getQuestionDetails() {

  }

  func postComment(model: QuestionPostComment) async {
    let headers: HTTPHeaders = [
      .accept("application/json")
    ]
    AF.request("https://reqres.in/api/users", method: .post, parameters: model, encoder: .json, headers: headers)
      .validate()
      .responseDecodable(of: QuestionResponseComment.self) { result in
        print(result.value)
      }
  }

}
