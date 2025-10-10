//
//  CareerDetail.swift
//  Landmarks
//
//  Created by Ivan Dyptan on 03.10.25.
//

import SwiftUI

struct CareerDetail: View {
    var career: Career

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(career.icon)
                    .font(.system(size: 96))
                    .padding(.top, 16)

                Text(career.id)
                    .font(.largeTitle.bold())

                Text(career.category.rawValue)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 16) {
                    labelBox(title: "Education", content: stars(level: career.difficulty))
                    labelBox(title: "Chances", content: Text(String(repeating: "🍀", count: career.chances)))
                    labelBox(title: "Income", content: Text("\(career.income)"))
                    labelBox(title: "Reward", content: Text(career.reward))
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("What is this job?")
                        .font(.title2.bold())
                    Text(career.summary)
                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .accessibilityIdentifier("CareerDetailRoot")
        .navigationTitle(career.id)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func stars(level: Int) -> some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: i <= level ? "star.fill" : "star")
                    .foregroundStyle(i <= level ? .yellow : .gray)
            }
        }
    }

    private func labelBox<T: View>(title: String, content: T) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            content
                .font(.body)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        if let first = careersAll.first {
            CareerDetail(career: first)
        } else {
            Text("No careers loaded")
        }
    }
}
