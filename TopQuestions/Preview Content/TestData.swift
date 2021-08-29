//
//  TestData.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 04/02/21.
//

import Foundation

struct TestData {
	static var Questions: [Question] = {
		let url = Bundle.main.url(forResource: "Questions", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		let wrapper = try! decoder.decode(Wrapper<Question>.self, from: data)
		return wrapper.items
	}()
	
	static let user = User(name: "Lumir Sacharov", reputation: 2345, profileImageURL: nil)
}
