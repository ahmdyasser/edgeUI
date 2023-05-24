//
//  MainView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      QuestionsListView()
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }

      ProfileView()
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
      
    }
  }
}

  struct MainView_Previews: PreviewProvider {
    static var previews: some View {
      MainView()

    }
  }

