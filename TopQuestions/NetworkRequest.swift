//
//  NetworkRequest.swift
//  TopQuestion
//
//  Created by Matteo Manferdini on 12/09/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NetworkRequest
protocol NetworkRequest: AnyObject {
	associatedtype ModelType
	func decode(_ data: Data) -> ModelType?
	func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
	fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
		let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
			guard let data = data, let value = self?.decode(data) else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			DispatchQueue.main.async { completion(value) }
		}
		task.resume()
	}
}

// MARK: - ImageRequest
class ImageRequest {
	let url: URL
	
	init(url: URL) {
		self.url = url
	}
}

extension ImageRequest: NetworkRequest {
	func decode(_ data: Data) -> UIImage? {
		return UIImage(data: data)
	}
	
	func execute(withCompletion completion: @escaping (UIImage?) -> Void) {
		load(url, withCompletion: completion)
	}
}

// MARK: - APIRequest
class APIRequest<Resource: APIResource> {
	let resource: Resource
	
	init(resource: Resource) {
		self.resource = resource
	}
}

extension APIRequest: NetworkRequest {
	func decode(_ data: Data) -> [Resource.ModelType]? {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
		return wrapper?.items
	}
	
	func execute(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
		load(resource.url, withCompletion: completion)
	}
}

// MARK: - APIResource
protocol APIResource {
	associatedtype ModelType: Decodable
	var methodPath: String { get }
	var filter: String? { get }
}

extension APIResource {
	var url: URL {
		var components = URLComponents(string: "https://api.stackexchange.com/2.2")!
		components.path = methodPath
		components.queryItems = [
			URLQueryItem(name: "site", value: "stackoverflow"),
			URLQueryItem(name: "order", value: "desc"),
			URLQueryItem(name: "sort", value: "votes"),
			URLQueryItem(name: "tagged", value: "swiftui"),
			URLQueryItem(name: "pagesize", value: "10")
		]
		if let filter = filter {
			components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
		}
		return components.url!
	}
}

// MARK: - QuestionsResource
struct QuestionsResource: APIResource {
	typealias ModelType = Question
	var id: Int?
	
	var methodPath: String {
		guard let id = id else {
			return "/questions"
		}
		return "/questions/\(id)"
	}
	
	var filter: String? {
		id != nil ? "!9_bDDxJY5" : nil
	}
}
