//
//  QuestionsListView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 14/05/2023.
//

import SwiftUI

struct QuestionsListView: View {
  @State private var showSheet = false
  private let questionTags = ["python", "Swift", "Docker"]
  
  var body: some View {
    NavigationView {
      ZStack {
        Color("gray1")
          .ignoresSafeArea()
        VStack {
          HStack {
            Button("Ask Question") {
              showSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showSheet) {
              AskQuestionView()
            }
            Spacer()
          }.padding()
          Divider()
          List {
            ForEach((1...10).reversed(), id: \.self) { _ in
              NavigationLink {
                QuestionDetailsView()
                  .navigationBarTitleDisplayMode(.inline)
              } label: {
                VStack(alignment: .leading) {
                  HStack {
                    Text("2 votes")
                    Text("1 answer")
                    Text("38 views")
                  }
                  Text("SwiftUI does require that we pass some sort of view to NavigationLink even when doing programmatic navigation. You’ll probably want to use EmptyView to show nothing at all, ")
                    .lineLimit(3)
                    .foregroundColor(.blue)
                  HStack {
                    ForEach(questionTags, id: \.self) {

                      Text($0)
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(6)
                        .background {
                          Color("gray0")
                            .cornerRadius(8)
                        }
                    }
                  }
                }
              }
              .listRowBackground(Color.clear)
            }

          }
          
          .listStyle(.plain)
          
        }
        .navigationTitle("All questions")
      }
    }
    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    
  }
}

struct QuestionsListView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionsListView()
  }
}
