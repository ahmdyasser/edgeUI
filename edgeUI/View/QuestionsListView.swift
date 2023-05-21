//
//  QuestionsListView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 14/05/2023.
//

import SwiftUI

struct QuestionsListView: View {
  @ObservedObject var viewModel = QuestionsListViewModel()
  @State private var showSheet = false
  @State private var searchText = ""
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
          }
          .padding()
          Divider()
          List {
            ForEach(viewModel.questionsList, id: \.id) { question in
              NavigationLink {

                QuestionDetailsView(questionId: question.id)
                  .navigationBarTitleDisplayMode(.inline)
              } label: {
                VStack(alignment: .leading) {
                  HStack {
                    Text("\(question.upvotes+question.downvotes) votes")
                    Text("\(0) answer")
                    Text("\(question.views) views")
                  }
                  Text(question.title)
                    .lineLimit(3)
                    .foregroundColor(.blue)
                  HStack {
                    ForEach(question.tags ?? [], id: \.self) { tag in
                      Text(tag)
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(6)
                        .background(Color("gray0"), in: RoundedRectangle(cornerRadius: 8))
                    }
                  }
                  HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                    Text(question.author.username)
                      .foregroundColor(.blue)
                      .font(.caption.bold())
                    Text("asked at \(viewModel.getFormattedDate())")
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
      .refreshable {
        await viewModel.fetchQuestions()
    }
    }

    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .task {
      await viewModel.fetchQuestions()
    }
  }
}
