//
//  ProfileView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 23/05/2023.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    VStack {
      Image(systemName: "person.crop.circle")
        .resizable()
        .scaledToFit()
        .frame(width: 100)
      List {
        HStack {
          Text("username: ")
          Text("ahmdyasser")
            .font(.body.bold())
            .fontDesign(.monospaced)
        }
        Text("name: Ahmad Yasser")

        HStack {
          Image(systemName: "circle.fill")
            .foregroundColor(.green)

          Text("is active: True")
        }
        Text("age: 22")
        Section {
          NavigationLink {


            LoginView()
          } label: {
            Button {
              DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
              }

            } label: {
              HStack {
                Text("Logout")
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.forward")
              }

            }

          }

        }

      }
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
