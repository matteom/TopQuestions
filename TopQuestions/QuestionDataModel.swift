//
//  QuestionDataModel.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 04/02/21.
//

import Foundation

class QuestionDataModel: ObservableObject {
	@Published var question: Question
	@Published var isLoading = false
	
	private var questionRequest: APIRequest<QuestionsResource>?
	private var imageRequest: ImageRequest?
	
	init(question: Question) {
		self.question = question
	}
	
	func loadQuestion() {
		guard !isLoading else { return }
		isLoading = true
		let resource = QuestionsResource(id: question.id)
		let request = APIRequest(resource: resource)
		self.questionRequest = request
		request.execute { [weak self] questions in
			guard let question = questions?.first else { return }
			self?.question = question
			self?.loadOwnerAvatar()
		}
	}
}

private extension QuestionDataModel {
	func loadOwnerAvatar() {
		guard let url = question.owner?.profileImageURL else { return }
		let imageRequest = ImageRequest(url: url)
		self.imageRequest = imageRequest
		imageRequest.execute { [weak self] image in
			self?.question.owner?.profileImage = image
			self?.isLoading = false
		}
	}
}
