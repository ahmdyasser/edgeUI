//
//  QuestionDetailsView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import SwiftUI

struct QuestionDetailsView: View {
  @State private var answerText = ""
  @State private var votes = 0
  @ObservedObject var viewModel = QuestionDetailsViewModel()
  private var postAnswerIsDisabled: Bool {
    answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
  var questionId: String
  @State var isApproved = true
  var body: some View {
    ZStack {
      Color("gray1")
        .ignoresSafeArea()
      ScrollView {
        VStack(alignment: .leading) {
          Text(viewModel.title)
            .font(.title)
          Divider()
          HStack(alignment: .top, spacing: 12) {
            VStack(spacing: 8) {
              Button {
                votes = viewModel.vote(target: .question, id: viewModel.id, voteType: .upvote)
                
              } label: {
                Image(systemName: "arrowtriangle.up.square.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 25)
                  .symbolRenderingMode(.hierarchical)
              }
              Text("\(viewModel.votes)")
                .font(.body.bold())
              Button {
                votes = viewModel.vote(target: .question, id: viewModel.id, voteType: .downvote)
                
              } label: {
                Image(systemName: "arrowtriangle.down.square.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 25)
                  .symbolRenderingMode(.hierarchical)
              }
              Spacer()
            }
            
            Text(viewModel.content)
            
          }
          .padding(.top, 20)
          HStack {
            ForEach(viewModel.tags, id: \.self) {
              Text($0)
                .foregroundColor(.white)
                .font(.caption)
                .padding(6)
                .background(Color("gray0"), in: RoundedRectangle(cornerRadius: 8))
            }
          }
          HStack {
            Spacer()
            Image(systemName: "person.circle.fill")
            Text(viewModel.username)
              .foregroundColor(.blue)
              .font(.caption.bold())
            Text("asked at \(viewModel.getFormattedDate())")
              .font(.caption)
              .foregroundColor(Color.secondary)
          }
          
          
        }
        .padding()
        
        VStack(alignment: viewModel.answers.count == 0 ? .center : .leading) {
          Divider()
          Text("Answers")
            .font(.title2.bold())
            .padding(.bottom, 15)
          if viewModel.answers.count == 0 {
            VStack {
              Text("There are no answers to your question yet")
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
              Image(systemName: "trash.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 70)
            }
            
          } else {
            ForEach(viewModel.answers, id: \.id) { answer in
              VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top) {
                  VStack(spacing: 8) {
                    Button {
                      votes = viewModel.vote(target: .answer, id: viewModel.id, voteType: .upvote)
                      
                    } label: {
                      Image(systemName: "arrowtriangle.up.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .symbolRenderingMode(.hierarchical)
                    }
                    Text("\(votes)")
                      .font(.body.bold())
                    Button {
                      votes = viewModel.vote(target: .answer, id: viewModel.id, voteType: .downvote)
                      
                    } label: {
                      Image(systemName: "arrowtriangle.down.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .symbolRenderingMode(.hierarchical)
                    }
                    Spacer()
                  }
                  if answer.isAccepted {
                    Image(systemName: "checkmark.seal.fill")
                      .foregroundColor(.green)
                    
                  }
                  Text(answer.content)
                    .font(.body.bold())
                  Spacer()
                  Menu {
                    Button("Delete") {
                      viewModel.deleteAnswer(answerId: answer.id)
                    }
                    Button("Approve answer") {
                      viewModel.acceptAnswer(answerId: answer.id)
                    }
                    
                  } label: {
                    Image(systemName: "ellipsis")
                  }
                  
                }
                HStack {
                  Spacer()
                  Image(systemName: "person.circle.fill")
                  Text(answer.author.username)
                    .foregroundColor(.blue)
                    .font(.caption.bold())
                  Text("asked at \(viewModel.getFormattedDate())")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                }
              }
            }
          }
          
        }
        .padding()
        
        VStack(alignment: .leading) {
          
          Divider()
          Text("Your Answer")
            .font(.title2.bold())
          TextField("Enter your answer here", text: $answerText, axis: .vertical)
            .textFieldStyle(.roundedBorder)
          Button("Post your answer") {
            viewModel.postAnswer(model: QuestionPostAnswer(content: answerText), questionId: questionId)
            answerText = ""
          }
          .buttonStyle(.borderedProminent)
          .disabled(postAnswerIsDisabled)
        }
        .padding()
      }
    }
    .refreshable {
      viewModel.getQuestionDetails(questionID: questionId)
    }
    .onAppear {
      viewModel.getQuestionDetails(questionID: questionId)
    }
  }
}
