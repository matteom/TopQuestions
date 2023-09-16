//
//  User.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import Foundation

struct User: Hashable {
	let name: String
	let reputation: Int
	var profileImageURL: URL?
}

extension User: Codable {
	enum CodingKeys: String, CodingKey {
		case name = "display_name"
		case profileImageURL = "profile_image"
		case reputation
	}
}
