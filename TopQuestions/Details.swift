//
//  Details.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import SwiftUI

struct Details: View {
	let question: Question

	var body: some View {
		VStack(alignment: .leading, spacing: 8.0) {
			Text(try! AttributedString(markdown: question.title))
				.font(.headline)
			Text(question.tagString)
				.font(.footnote)
				.bold()
				.foregroundColor(.accentColor)
			Text("Asked on " + question.date.formatted(date: .long, time: .shortened))
				.font(.caption)
				.foregroundColor(.secondary)
			ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
				Label("\(question.score)", systemImage: "arrowtriangle.up.circle")
				Label("\(question.answerCount)", systemImage: "ellipses.bubble")
					.padding(.leading, 108.0)
				Label("\(question.viewCount)", systemImage: "eye")
					.padding(.leading, 204.0)
			}
			.font(.caption)
			.foregroundColor(.orange)
		}
	}
}

extension Question {
	var tagString: String {
		tags[0] + tags.dropFirst().reduce("") { $0 + ", " + $1 }
	}
}

#Preview {
	Details(question: .preview)
}
