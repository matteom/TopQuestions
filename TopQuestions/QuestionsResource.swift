//
//  QuestionsResource.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import Foundation

struct QuestionsResource: APIResource {
	typealias ModelType = Question
	var id: Int?

	var methodPath: String {
		guard let id else { return "/questions" }
		return "/questions/\(id)"
	}

	var filter: String? {
		id == nil
		? "L7V2EDvuysm0H*BIB_.(egYSjq"
		: ")3fFI)sF9pUF13d.QOYHh2wF41eBt2dc"
	}
}
