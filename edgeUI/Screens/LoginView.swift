//
//  LoginView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import SwiftUI

struct LoginView: View {
  @State private var username =  "kminchelle"
  @State private var password = "0lelplR"
  @State private var isAuthenticated = false
  @State private var showAlert = false


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
            VStack(alignment: .leading, spacing: 5) {
              Text("Username")
                .font(.title2.bold())
              TextField("Enter your username", text: $username)
            }
            VStack(alignment: .leading, spacing: 5) {
              Text("Password")
                .font(.title2.bold())
              SecureField("Enter your password", text: $password)
            }
          }
          .textFieldStyle(.roundedBorder)
          Spacer()
          NavigationLink(
            destination: QuestionsListView(),
            isActive: $isAuthenticated) {
              EmptyView()
            }
          Button {

            Task {
              isAuthenticated = await authenticate(username: username, password: password)
              if !isAuthenticated {
                showAlert =  true
              }

            }
          } label: {
            LoginButton()
          }
          Spacer()
          Spacer()
        }
        .padding()
      }
      ProgressView {
        Text("loading...")
      }
    }
    .alert(Text("Password or username is not valid"), isPresented: $showAlert) {
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
