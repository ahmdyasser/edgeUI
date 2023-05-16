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


