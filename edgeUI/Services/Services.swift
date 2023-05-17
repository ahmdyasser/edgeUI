//
//  Services.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import Foundation

func authenticate(username: String, password: String) async -> Bool {
  let loginURL = URL(string: "https://dummyjson.com/auth/login")!
  var request = URLRequest(url: loginURL)
  let body = ["username": username, "password": password]
  let bodyData = try? JSONSerialization.data(withJSONObject: body)
  request.httpMethod = "POST"
  request.httpBody = bodyData
  //  application/x-www-form-urlencoded
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  guard
    let result = try? await URLSession.shared.data(for: request),
    let responseJSON = try? JSONSerialization.jsonObject(with: result.0),
    let responseJSON = responseJSON as? [String: Any],
    let token = responseJSON["token"] as? String
  else { return false }
  KeychainHelper.shared.save( token.data(using: .utf8)!, service: "access-token", account: "edgeUI")
//    let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
  print(token)
  return true
}

func postQuestion() {

}
