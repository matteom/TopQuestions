//
//  APIManager.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 14/09/23.
//

import Foundation

enum Endpoint {
	case questions
	case question(id: Int)
	case image(url: URL)

	var url: URL {
		if case let .image(url: url) = self {
			return url
		}
		let rootEndpoint = URL(string: "https://api.stackexchange.com/2.3")!
		var path = ""
		var filter = ""
		switch self {
			case .questions:
				path = "questions"
				filter = "L7V2EDvuysm0H*BIB_.(egYSjq"
			case .question(id: let id):
				path = "questions/\(id)"
				filter = ")3fFI)sF9pUF13d.QOYHh2wF41eBt2dc"
			default: break
		}
		return rootEndpoint
			.appending(path: path)
			.appending(queryItems: [
				URLQueryItem(name: "site", value: "stackoverflow"),
				URLQueryItem(name: "order", value: "desc"),
				URLQueryItem(name: "sort", value: "votes"),
				URLQueryItem(name: "tagged", value: "swiftui"),
				URLQueryItem(name: "pagesize", value: "10"),
				URLQueryItem(name: "filter", value: filter)
			])
	}
}

class APIManager {
	func fetchTopQuestions() async throws -> [Question] {
		let url = URL(string: "https://api.stackexchange.com/2.3/questions?pagesize=10&order=desc&sort=votes&tagged=swiftui&site=stackoverflow&filter=L7V2EDvuysm0H*BIB_.(egYSjq")!
		let (data, _) = try await URLSession.shared.data(from: url)
		let wrapper = try JSONDecoder().decode(Wrapper<Question>.self, from: data)
		return wrapper.items
	}

	func fetchQuestion(withID id: Int) async throws -> Question {
		let url = URL(string: "https://api.stackexchange.com/2.3/questions/\(id)?&filter=)3fFI)sF9pUF13d.QOYHh2wF41eBt2dc")!
		let (data, _) = try await URLSession.shared.data(from: url)
		let wrapper = try JSONDecoder().decode(Wrapper<Question>.self, from: data)
		return wrapper.items[0]
	}

	func fetchImage(withURL url: URL) async throws -> Data {
		let (data, _) = try await URLSession.shared.data(from: url)
		return data
	}

	func load<T>(endpoint: Endpoint) async throws -> T {
		let (data, _) = try await URLSession.shared.data(from: endpoint.url)
		switch endpoint {
			case .image(url: _): return data as! T
			case .questions:
				let wrapper = try JSONDecoder().decode(Wrapper<Question>.self, from: data)
				return wrapper.items.first as! T
			case .question(id: _):
				let wrapper = try JSONDecoder().decode(Wrapper<Question>.self, from: data)
				return wrapper.items as! T
		}
	}

	func perform<T: Codable>(request: Request<T>) async throws -> [T] {
		let (data, _) = try await URLSession.shared.data(from: request.url)
		let wrapper = try JSONDecoder().decode(Wrapper<T>.self, from: data)
		return wrapper.items
	}
}

public struct Request<T> {
	let id: Int?
	let path: String
	let filter: String

	var url: URL {
		let rootEndpoint = URL(string: "https://api.stackexchange.com/2.3")!
		return rootEndpoint
			.appending(path: path + (id == nil ? "" : "\(id!)"))
			.appending(queryItems: [
				URLQueryItem(name: "site", value: "stackoverflow"),
				URLQueryItem(name: "order", value: "desc"),
				URLQueryItem(name: "sort", value: "votes"),
				URLQueryItem(name: "tagged", value: "swiftui"),
				URLQueryItem(name: "pagesize", value: "10"),
				URLQueryItem(name: "filter", value: filter)
			])
	}
}

extension Request {
	static func questions() -> Request<Question> {
		Request<Question>(id: nil, path: "/questions", filter: "L7V2EDvuysm0H*BIB_.(egYSjq")
	}

	static func question(id: Int) -> Request<Question> {
		Request<Question>(id: id, path: "/questions", filter: ")3fFI)sF9pUF13d.QOYHh2wF41eBt2dc")
	}
}
