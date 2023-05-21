//
//  QuestionsListViewModel.swift
//  edgeUI
//
//  Created by Ahmad Yasser on 21/05/2023.
//

import SwiftUI
import Alamofire

@MainActor class QuestionsListViewModel: ObservableObject {
  @Published var questionsList: [QuestionResponseModel] = []

  func getFormattedDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    let date = Date()
    let shortDateString = dateFormatter.string(from: date)
    return shortDateString
  }

  func fetchQuestions() async {
    AF.request("http://127.0.0.1:8000/qna/question/", method: .get)
      .validate()
      .responseDecodable(of: [QuestionResponseModel].self) { result in
        self.questionsList = result.value?.reversed() ?? []
      }
  }
  
}
