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
      Text("Home Tab")
        .font(.system(size: 30, weight: .bold, design: .rounded))
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
      
    }
  }
}

  struct MainView_Previews: PreviewProvider {
    static var previews: some View {
      MainView()

    }
  }

