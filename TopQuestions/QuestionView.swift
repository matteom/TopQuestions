//
//  QuestionView.swift
//  
//
//  Created by asdfasd on 04/02/21.
//  Copyright © 2021 asdfasdsdf. All rights reserved.
//

import SwiftUI

// MARK: - QuestionView
struct QuestionView: View {
	@StateObject private var dataModel: QuestionDataModel
	
	init(question: Question) {
		let dataModel = QuestionDataModel(question: question)
		_dataModel = StateObject(wrappedValue: dataModel)
	}
	
	var body: some View {
		ScrollView(.vertical) {
			LazyVStack(alignment: .leading) {
				Details(question: dataModel.question)
				if dataModel.isLoading {
					ProgressView()
						.frame(maxWidth: .infinity, alignment: .center)
				} else {
					if let body = dataModel.question.body {
						Text(body)
					}
					if let owner = dataModel.question.owner {
						Owner(user: owner)
							.frame(maxWidth: .infinity, alignment: .trailing)
					}
				}
			}
			.padding(.horizontal, 20.0)
		}
		.navigationTitle("Detail")
		.onAppear {
			dataModel.loadQuestion()
		}
	}
}

// MARK: - Owner
struct Owner: View {
	let user: User
	
	private var image: Image {
		guard let profileImage = user.profileImage else {
			return Image(systemName: "questionmark.circle")
		}
		return Image(uiImage: profileImage)
	}
	
	var body: some View {
		HStack(spacing: 16.0) {
			image
				.resizable()
				.frame(width: 48.0, height: 48.0)
				.cornerRadius(8.0)
				.foregroundColor(.secondary)
			VStack(alignment: .leading, spacing: 4.0) {
				Text(user.name ?? "")
					.font(.headline)
				Text(user.reputation?.thousandsFormatting ?? "")
					.font(.caption)
					.foregroundColor(.secondary)
			}
		}
		.padding(.vertical, 8.0)
	}
}

struct QuestionView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			QuestionView(question: TestData.Questions[0])
		}
		Owner(user: TestData.user)
			.previewLayout(.sizeThatFits)
	}
}
