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
  let views: Int
}

struct QuestionDetailsResponse: Decodable {
  let id: String
  let content: String
  let upvotes: Int
  let downvotes: Int
  let author: QuestionAuthor
  let title: String
  let tags: [String]?
  let answers: [QuestionResponseAnswer]?
}

struct QuestionAuthor: Decodable {
  let id: String
  let username: String
}

struct QuestionResponseAnswer: Decodable {
  let id: String
  let content: String
  let upvotes: Int
  let downvotes: Int
  let author: QuestionAuthor
  let isAccepted: Bool
  enum CodingKeys: String, CodingKey {
    case id, content, upvotes, downvotes, author
    case isAccepted = "is_accepted"
  }
}

struct AnswerPostResponse: Decodable {
let id: String
}

struct QuestionPostAnswer: Encodable {
  let content: String
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
