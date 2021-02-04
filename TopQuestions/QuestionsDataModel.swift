//
//  QuestionsModel.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 04/02/21.
//

import Foundation

class QuestionsDataModel: ObservableObject {
	@Published private(set) var questions: [Question] = []
	@Published private(set) var isLoading = false
	
	private var request: APIRequest<QuestionsResource>?
	
	func fetchTopQuestions() {
		guard !isLoading else { return }
		isLoading = true
		let resource = QuestionsResource()
		let request = APIRequest(resource: resource)
		self.request = request
		request.execute { [weak self] questions in
			self?.questions = questions ?? []
			self?.isLoading = false
		}
	}
}
