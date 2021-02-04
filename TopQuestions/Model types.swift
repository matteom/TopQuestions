//
//  Model types.swift
//  TopQuestion
//
//  Created by Matteo Manferdini on 10/09/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation
import UIKit

// MARK: - User
struct User {
	let name: String?
	let reputation: Int?
	let profileImageURL: URL?
	var profileImage: UIImage?
}

extension User: Decodable {
	enum CodingKeys: String, CodingKey {
		case reputation
		case name = "display_name"
		case profileImageURL = "profile_image"
	}
}

// MARK: - Question
struct Question: Identifiable {
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

extension Question: Decodable {
	enum CodingKeys: String, CodingKey {
		case score, title, body, tags, owner
		case id = "question_id"
		case date = "creation_date"
		case answerCount = "answer_count"
		case viewCount = "view_count"
	}
}

// MARK: - Wrapper
struct Wrapper<T: Decodable>: Decodable {
	let items: [T]
}
