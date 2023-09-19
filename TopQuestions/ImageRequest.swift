//
//  ImageRequest.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import Foundation

class ImageRequest {
	let url: URL

	init(url: URL) {
		self.url = url
	}
}

extension ImageRequest: NetworkRequest {
	func decode(_ data: Data) throws -> URL? {
		let dataString = data.base64EncodedString()
		return URL(string: "data:image/png;base64," + dataString)!
	}

	func execute() async throws -> URL? {
		try await load(url)
	}
}
