//
//  TopQuestionsView.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 12/09/23.
//

import SwiftUI

struct TopQuestionsView: View {
	@State private var model = Model()

	var body: some View {
		List(model.questions) { question in
			NavigationLink(value: question) {
				Details(question: question)
					.alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
			}
		}
		.listStyle(.plain)
		.listRowInsets(.none)
		.listRowSpacing(8.0)
		.navigationTitle("Top Questions")
		.task { try? await model.fetchTopQuestions() }
		.refreshable { try? await model.fetchTopQuestions() }
		.navigationDestination(for: Question.self) { question in
			QuestionView(question: question)
		}
	}
}

#Preview {
	NavigationStack {
		TopQuestionsView()
	}
}
