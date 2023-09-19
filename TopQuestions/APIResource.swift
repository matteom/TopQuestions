//
//  APIResource.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 18/09/23.
//

import Foundation


protocol APIResource {
	associatedtype ModelType: Codable
	var methodPath: String { get }
	var filter: String? { get }
}

extension APIResource {
	var url: URL {
		let url = URL(string: "https://api.stackexchange.com/2.3")!
			.appendingPathComponent(methodPath)
			.appending(queryItems: [
				URLQueryItem(name: "site", value: "stackoverflow"),
				URLQueryItem(name: "order", value: "desc"),
				URLQueryItem(name: "sort", value: "votes"),
				URLQueryItem(name: "tagged", value: "swiftui"),
				URLQueryItem(name: "pagesize", value: "10")
			])
		guard let filter else { return url }
		return url.appending(queryItems: [URLQueryItem(name: "filter", value: filter)])
	}
}
