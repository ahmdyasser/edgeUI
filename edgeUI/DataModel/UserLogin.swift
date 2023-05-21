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

struct QuestionResponseModel: Decodable {
  let id: String
  let content: String
  let author: QuestionAuthor
  let title: String
  let upvotes: Int
  let downvotes: Int
  let tags: [String]?
//  let answers: Int
//  let views: Int
}

struct QuestionDetailsResponse: Decodable {

  let comments: [QuestionResponseComment]
}

struct QuestionAuthor: Decodable {
  let id: String
  let username: String
}

struct QuestionResponseComment: Decodable {
  let myId = UUID()
  let author: String
  let date: String
  let content: String
  let isAccepted: Bool
  enum CodingKeys: String, CodingKey {
    case myId
    case author
    case date
    case content
    case isAccepted = "is_accepted"
  }
}

struct QuestionPostComment: Encodable {
  let description: String
}



struct AskQuestionPostModel: Encodable {
  let content: String
  let title: String
  let tags: [String]
}

struct AskQuestionResponseModel: Decodable {
  let id: String
}

struct VoteResponseModel: Decodable {
  let id: String
  let upvotes: Int
  let downvotes: Int
}
