//
//  Question.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 14/09/23.
//

import Foundation

struct Question: Identifiable, Hashable {
	let id: Int
	let score: Int
	let answerCount: Int
	let viewCount: Int
	let title: String
	let body: String?
	let date: Date
	let tags: [String]
	var owner: User?
}

extension Question: Codable {
	enum CodingKeys: String, CodingKey {
		case id = "question_id"
		case date = "creation_date"
		case answerCount = "answer_count"
		case viewCount = "view_count"
		case body = "body_markdown"
		case score, title, tags, owner
	}
}
