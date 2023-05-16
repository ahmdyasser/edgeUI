//
//  LoginView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import SwiftUI

struct LoginView: View {
  @State private var username =  "user@example.com"
  @State private var password = "string"
  @State private var isAuthenticated = false

  var body: some View {
    NavigationView {
      ZStack {
        Color("gray1")
          .ignoresSafeArea()
        VStack {
          Text("Q&A app")
            .foregroundColor(.white)
            .font(.largeTitle.bold())
          Spacer()
          VStack(spacing: 40) {
            TextField("Enter your username", text: $username)
            SecureField("Enter your password", text: $password)
          }
          .textFieldStyle(.roundedBorder)
          Spacer()
          NavigationLink(
            destination: QuestionsListView(),
            isActive: $isAuthenticated) {
              EmptyView()
            }
          Button {
            login(username: username, password: password)
            isAuthenticated = true
          } label: {
            LoginButton()
          }
          Spacer()
          Spacer()
        }
        .padding()
      }
    }

  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}

struct LoginButton: View {
  var body: some View {
    Text("Login")
      .foregroundColor(.white)
      .font(.title3.bold())
      .padding()
      .background {
        Rectangle()
          .foregroundColor(Color("blue1"))
          .frame(width: 300)
          .cornerRadius(8)
      }
  }
}
