//
//  TopQuestionsView.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import SwiftUI

struct TopQuestionsView: View {
	let questions: [Question]

	var body: some View {
		List(questions) { question in
			NavigationLink(value: question) {
				Details(question: question)
					.alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
			}
		}
		.listStyle(.plain)
		.listRowInsets(.none)
		.listRowSpacing(8.0)
		.navigationTitle("Top Questions")
		.navigationDestination(for: Question.self) { question in
			QuestionView(question: question)
		}
	}
}

#Preview {
	NavigationStack {
		TopQuestionsView(questions: .preview)
	}
}
