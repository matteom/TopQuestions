//
//  NetworkRequest.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import Foundation

protocol NetworkRequest: AnyObject {
	associatedtype ModelType
	func decode(_ data: Data) throws -> ModelType
	func execute() async throws -> ModelType
}

extension NetworkRequest {
	func load(_ url: URL) async throws -> ModelType {
		let (data, _) = try await URLSession.shared.data(from: url)
		return try decode(data)
	}
}
