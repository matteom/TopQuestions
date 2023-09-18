//
//  Wrapper.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 14/09/23.
//

import Foundation

struct Wrapper<T: Codable>: Codable {
	let items: [T]
}
