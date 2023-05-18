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
  @State private var isAuthenticated = UserDefaults.standard.bool(forKey: "isLoggedIn")
  @State private var showAlert = false
  @State private var isLoading = false
  
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
              isLoading = true
              isAuthenticated = await authenticate(username: username, password: password)
              UserDefaults.standard.set(isAuthenticated, forKey: "isLoggedIn")
              if !isAuthenticated {
                showAlert =  true
                isLoading = false
              }
            }
          } label: {
            LoginButton()
          }
          Spacer()
          Spacer()
        }
        .padding()
        if isLoading {
          ProgressView(label: {
            Text("Loading...")
          })
          .padding()
          .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
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
