//
//  Services.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import Foundation

func login(username: String, password: String) {
  let loginURL = URL(string: "https://dummyjson.com/auth/login")!
  var request = URLRequest(url: loginURL)
  let body = ["username": username, "password": password]
  let bodyData = try? JSONSerialization.data(withJSONObject: body)
  request.httpMethod = "POST"
  request.httpBody = bodyData
  request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
  URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else { return }

    let responseJSON = try? JSONSerialization.jsonObject(with: data)
    if let responseJSON = responseJSON as? [String: Any] {
      guard let token = responseJSON["token"] as? String else { return }
      KeychainHelper.shared.save( token.data(using: .utf8)!, service: "access-token", account: "edgeUI")
      let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
      print(String(data: tokenData!, encoding: .utf8))
    }
  }.resume()
}

func postQuestion() {

}
