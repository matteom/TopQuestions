//
//  TopQuestionsView.Model.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import Foundation

extension TopQuestionsView {
	@Observable class Model {
		private(set) var questions: [Question] = []
		private(set) var isLoading = false

		@MainActor func fetchTopQuestions() async throws {
			guard !isLoading else { return }
			defer { isLoading = false }
			isLoading = true
			let resource = QuestionsResource()
			let request = APIRequest(resource: resource)
			questions = try await request.execute()
		}
	}
}
