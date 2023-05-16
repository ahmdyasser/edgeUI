//
//  AskQuestionView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import SwiftUI

struct AskQuestionView: View {
  @State private var questionTitle = ""
  @State private var questionBody = ""

  @Environment(\.dismiss) var dismiss

  var body: some View {
    ZStack {
      Color("gray2")
        .ignoresSafeArea()
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Spacer()
          Button("Post") {
            print("posting question ...")
            dismiss()
          }
          .buttonStyle(.borderedProminent)
        }
        Text("Title")
          .font(.title.bold())
        TextField("Enter question title", text: $questionTitle, axis: .vertical)
          .textFieldStyle(.roundedBorder)
        Text("Body")
          .font(.title.bold())
        TextField("Enter question body", text: $questionBody, axis: .vertical)
          .textFieldStyle(.roundedBorder)
        Spacer()
      }
      .padding()
    }
  }
}

struct AskQuestionView_Previews: PreviewProvider {
  static var previews: some View {
    AskQuestionView()
  }
}
