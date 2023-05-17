//
//  QuestionsListView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 14/05/2023.
//

import SwiftUI

struct QuestionsListView: View {
  @State private var showSheet = false
  @State private var searchText = ""
  @State private var questionTags = ["python", "Swift", "Docker"]
  @State private var questionsArray = [
    QuestionModel(id: 0, author: "ahmdyasser", title: "SwiftUI does require that we pass some sort of view to NavigationLink even when doing programmatic navigation. You’ll probably want to use EmptyView to show nothing at all,", description: "", tags: ["python", "Swift", "Docker"], votes: 2, answers: 1, views: 38, date: "1 month ago", comments: nil),
    QuestionModel(id: 1, author: "ahmdyasser", title: "SwiftUI does require that we pass some sort of view to NavigationLink even when doing programmatic navigation. You’ll probably want to use EmptyView to show nothing at all,", description: "", tags: ["python", "Swift", "Docker"], votes: 2, answers: 1, views: 38, date: "1 month ago", comments: nil),
    QuestionModel(id: 2, author: "ahmdyasser", title: "SwiftUI does require that we pass some sort of view to NavigationLink even when doing programmatic navigation. You’ll probably want to use EmptyView to show nothing at all,", description: "", tags: ["python", "Swift", "Docker"], votes: 2, answers: 1, views: 38, date: "1 month ago", comments: nil),
    QuestionModel(id: 3, author: "ahmdyasser", title: "SwiftUI does require that we pass some sort of view to NavigationLink even when doing programmatic navigation. You’ll probably want to use EmptyView to show nothing at all,", description: "", tags: ["python", "Swift", "Docker"], votes: 2, answers: 1, views: 38, date: "1 month ago", comments: nil),
    QuestionModel(id: 4, author: "ahmdyasser", title: "SwiftUI does require that we pass some sort of view to NavigationLink even when doing programmatic navigation. You’ll probably want to use EmptyView to show nothing at all,", description: "", tags: ["python", "Swift", "Docker"], votes: 2, answers: 1, views: 38, date: "1 month ago", comments: nil)

  ]

  var searchResults: [String] {
    if searchText.isEmpty {
      return questionTags
    } else {
      return questionTags.filter { $0.contains(searchText) }
    }
  }
  var body: some View {
    NavigationView {
      ZStack {
        Color("gray1")
          .ignoresSafeArea()
        VStack(spacing: 4) {
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
            ForEach($questionsArray, id: \.id) { $question in
              NavigationLink {
                QuestionDetailsView()
                  .navigationBarTitleDisplayMode(.inline)
              } label: {
                VStack(alignment: .leading) {
                  HStack {
                    Text("\(question.votes) votes")
                    Text("\(question.answers) answer")
                    Text("\(question.views) views")
                  }
                  Text(question.title)
                    .lineLimit(3)
                    .foregroundColor(.blue)
                  HStack {
                    ForEach(searchResults, id: \.self) { result in
                      Text(result)
                        .searchCompletion(result)
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(6)
                        .background(Color("gray0"), in: RoundedRectangle(cornerRadius: 8))
                    }
                  }
                  HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                    Text(question.author)
                      .foregroundColor(.blue)
                      .font(.caption.bold())
                    Text("asked \(question.date)")
                      .font(.caption)
                      .foregroundColor(Color.secondary)
                  }
                }
                .padding(.top)
              }
              .listRowBackground(Color.clear)
            }
          }
          .searchable(text: $searchText)
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
