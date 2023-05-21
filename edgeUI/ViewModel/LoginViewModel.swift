//
//  LoginViewModel.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 21/05/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
  func authenticate(username: String, password: String) async -> Bool {
    let loginURL = URL(string: "http://127.0.0.1:8000/auth/jwt/login")!
    var request = URLRequest(url: loginURL)
    let bodyData = "username=\(username)&password=\(password)".data(using: .utf8)
    request.httpMethod = "POST"
    request.httpBody = bodyData
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    guard
      let result = try? await URLSession.shared.data(for: request),
      let responseJSON = try? JSONSerialization.jsonObject(with: result.0),
      let responseJSON = responseJSON as? [String: Any],
      let token = responseJSON["access_token"] as? String
    else {
      return false
    }
    KeychainHelper.shared.save( token.data(using: .utf8)!, service: "access-token", account: "edgeUI")
    print(token)
    return true
  }
  
}
