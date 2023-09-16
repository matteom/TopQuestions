//
//  JSONDecoder+API.swift
//  Lifehacks
//
//  Created by Matteo Manferdini on 16/08/23.
//

import Foundation

extension JSONDecoder {
	static var apiDecoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		return decoder
	}
}
