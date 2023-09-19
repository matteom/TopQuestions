//
//  QuestionView.Model.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import Foundation

extension QuestionView {
	@Observable class Model {
		private(set) var question: Question
		private(set) var isLoading = false

		init(question: Question) {
			self.question = question
		}

		func loadQuestion() async throws {
			guard !isLoading else { return }
			defer { isLoading = false }
			isLoading = true
			let resource = QuestionsResource(id: question.id)
			let request = APIRequest(resource: resource)
			let questions = try await request.execute()
			guard let question = questions.first else { return }
			self.question = question
			guard let url = question.owner?.profileImageURL else { return }
			let imageRequest = ImageRequest(url: url)
			self.question.owner?.profileImageURL = try await imageRequest.execute()
		}
	}
}
