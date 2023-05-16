//
//  QuestionDetailsView.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 15/05/2023.
//

import SwiftUI

struct QuestionDetailsView: View {
  @State private var answerText = ""
  @State private var upvotes = 0

  var body: some View {
    ZStack {
      Color("gray1")
        .ignoresSafeArea()
      ScrollView {
        VStack(alignment: .leading) {
          Text("How to use bla bla bla bla to make some bla bla bla ")
            .font(.title)
          Divider()
          HStack(spacing: 12) {
            VStack(spacing: 8) {
              Button {
                upvotes += 1
              } label: {
                Image(systemName: "arrowtriangle.up.square.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 25)
                  .symbolRenderingMode(.hierarchical)
              }
              Text("\(upvotes)")
              Button {
                upvotes -= 1
              } label: {
                Image(systemName: "arrowtriangle.down.square.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 25)
                  .symbolRenderingMode(.hierarchical)
              }
              Spacer()
            }

            Text("I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below:I have a 2D array from a geotiff file. see the example below:I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below: I have a 2D array from a geotiff file. see the example below:")

          }
          .padding(.top, 20)
          VStack(alignment: .leading) {
            Divider()
            Text("Your Answer")
              .font(.title3)
            TextField("Enter your answer here", text: $answerText, axis: .vertical)
              .textFieldStyle(.roundedBorder)
            Button("Post your answer") {
              print("Posting ", answerText, "...")
            }.buttonStyle(.borderedProminent)
          }

        }
        .padding()
      }
    }
  }
}


struct QuestionDetails_Previews: PreviewProvider {
  static var previews: some View {
    QuestionDetailsView()
  }
}
