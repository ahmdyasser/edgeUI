//
//  AskQuestionViewModel.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 21/05/2023.
//

import SwiftUI
import Alamofire


@MainActor class AskQuestionViewModel: ObservableObject {
  func askQuestion(model: AskQuestionPostModel) async {
    let token = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
    let tokenString = String(bytes: token ?? Data(), encoding: .utf8) ?? ""
    let headers: HTTPHeaders = [
      .accept("application/json"),
      .authorization(bearerToken: tokenString)
    ]
    AF.request("http://127.0.0.1:8000/qna/question/add/", method: .post, parameters: model, encoder: .json, headers: headers)
      .validate()
      .responseDecodable(of: AskQuestionResponseModel.self) { result in
        print(result.value)
      }
  }
}




