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
  @State private var tagsText = ""
  @State private var tagsArray: [String: Int] = [:]
  @State private var showAlert = false
  @Environment(\.dismiss) var dismiss

  var body: some View {
    ZStack {
      Color("gray2")
        .ignoresSafeArea()
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text("Ask Question")
            .font(.largeTitle.bold())
          Spacer()
          Button("Post") {
            print("posting question ...")
            postQuestion()
            dismiss()
          }
          .buttonStyle(.borderedProminent)
        }
        VStack(alignment: .leading, spacing: 4) {
          Text("Title")
            .font(.title2.bold())
          TextField("Enter question title", text: $questionTitle, axis: .vertical)
            .textFieldStyle(.roundedBorder)
        }

        VStack(alignment: .leading, spacing: 4) {
          Text("Body")
            .font(.title2.bold())
          TextField("Enter question body", text: $questionBody, axis: .vertical)
            .textFieldStyle(.roundedBorder)
        }
        VStack(alignment: .leading, spacing: 4) {
          Text("Tags")
            .font(.title2.bold())
          HStack {

            TextField("Add tags to your question", text: $tagsText, axis: .vertical)
              .textFieldStyle(.roundedBorder)
              .textCase(.lowercase)
            Button("Add") {
              if tagsArray.count <= 4 {
                tagsArray[tagsText] = tagsArray.count+1
                tagsText = ""
              } else {
                showAlert = true
              }
            }
            .disabled(tagsText.isEmpty)
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .alert("5 is the max number of tags", isPresented: $showAlert) {
              Button("Ok", role: .cancel) { }
            }
          }
        }
        HStack {
          ForEach(tagsArray.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
            HStack {
              Text(key)
              Image(systemName: "xmark")
                .tag(key)
                .onTapGesture {
                  tagsArray.removeValue(forKey: key)
                }
            }
            .foregroundColor(.white)
            .font(.caption)
            .padding(6)
            .background {
              Color("gray0")
                .cornerRadius(8)
            }
          }
        }
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
