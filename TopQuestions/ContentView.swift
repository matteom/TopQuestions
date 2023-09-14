//
//  ContentView.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import SwiftUI

struct ContentView: View {
	@State var question: Question?

	var body: some View {
		VStack(alignment: .leading) {
			if let question {
				Text(question.title)
					.font(.title)
				Text("Score: " + question.score.formatted())
			} else {
				Text("No data available")
			}
		}
		.padding(20.0)
		.task {
			do {
				question = try await performAPICall()
			} catch {
				question = nil
			}
		}
	}

	func performAPICall() async throws -> Question {
		let url = URL(string: "https://api.stackexchange.com/2.3/questions?pagesize=1&order=desc&sort=votes&site=stackoverflow&filter=)pe0bT2YUo)Qn0m64ED*6Equ")!
		let (data, _) = try await URLSession.shared.data(from: url)
		let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
		return wrapper.items[0]
	}
}

#Preview {
    ContentView()
}
