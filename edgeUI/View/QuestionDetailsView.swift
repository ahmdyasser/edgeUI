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
  @State var isApproved = true
  var body: some View {
    ZStack {
      Color("gray1")
        .ignoresSafeArea()
      ScrollView {
        VStack(alignment: .leading) {
          Text("fail to adding an element into std::map by insert fucntion")
            .font(.title)
          Divider()
          HStack(spacing: 12) {
            VStack(spacing: 8) {
              Button {
                votes += 1
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

            Text("error: no matching function for call to 'std::map<unsigned int, khaos_event>::insert(std::pair<unsigned int, khaos_event>)'\nHow can I fix this? where do I make a misunderstanding? any comments and suggestions are appreciated. thanks in advance.")

          }
          .padding(.top, 20)
          VStack(alignment: .leading) {

            Divider()
            Text("Your Answer")
              .font(.title2.bold())
            TextField("Enter your answer here", text: $answerText, axis: .vertical)
              .textFieldStyle(.roundedBorder)
            Button("Post your answer") {
              print("Posting ", answerText, "...")
            }.buttonStyle(.borderedProminent)
          }
        }
        .padding()

        VStack(alignment: .leading) {
          Divider()
          Text("Answers")
            .font(.title2.bold())
            .padding(.bottom, 15)
          ForEach(viewModel.comments, id: \.myId) { comment in
            VStack(alignment: .leading, spacing: 20) {
              HStack {
                if comment.isAccepted {
                  Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
                }
                Text(comment.content)
                Spacer()
                Menu {
                  Button("Delete") {
//                    viewModel.deleteAns
                  }
                  Button("Approve answer") {
//                    viewModel.approveAnswer
                  }

                } label: {
                  Image(systemName: "ellipsis")
                }

              }
              HStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                Text(comment.author)
                  .foregroundColor(.blue)
                  .font(.caption.bold())
                Text("asked at \(viewModel.getFormattedDate())")
                  .font(.caption)
                  .foregroundColor(Color.secondary)
              }
            }
          }
        }
        .padding()
      }
    }
    .onAppear {
      viewModel.getComments()
    }
  }
}


struct QuestionDetails_Previews: PreviewProvider {
  static var previews: some View {
    QuestionDetailsView()
  }
}
