//
//  UserLogin.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import Foundation

struct UserLogin: Encodable {
  let username: String
  let password: String
}

struct UserLoginResponse: Decodable {
  let token: String
  enum CodingKeys: String, CodingKey {
    case token = "access_token"
  }
}

struct QuestionModel: Codable {
  let id: Int
  let title: String
  let description: String
  let tags: [String]
  let votes: Int
  let answers: Int
  let views: Int
  let date: String
  let comments: [QuestionComment]?
}

struct QuestionComment: Codable {
  let author: String
  let date: String
  let description: String
}
