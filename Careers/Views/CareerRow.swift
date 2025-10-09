//
//  CareerRow.swift
//  Landmarks
//
//  Created by Ivan Dyptan on 03.10.25.
//

import SwiftUI

struct CareerRow: View {
    var career: Career

    var body: some View {
        HStack(spacing: 12) {
            Text(career.icon)
                .font(.system(size: 28))
                .frame(width: 40, height: 40)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(career.id)
                        .font(.headline)
                    Spacer()
                    // Show reward money emojis directly
                    Text(career.reward)
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.15))
                        .foregroundStyle(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .accessibilityLabel("Reward \(career.reward.count / 2) money symbols")
                }

                HStack(spacing: 8) {
                    DifficultyView(level: career.difficulty)
                    LuckView(probability: career.luckFactor)
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

private struct DifficultyView: View {
    let level: Int
    var body: some View {
        // 1..5 stars using emoji
        let filled = max(0, min(5, level))
        let empty = max(0, 5 - filled)
        HStack(spacing: 2) {
            Text(String(repeating: "⭐️", count: filled) + String(repeating: "☆", count: empty))
                .font(.caption)
                .accessibilityLabel("Difficulty \(filled) out of 5")
        }
    }
}

private struct LuckView: View {
    let probability: Double
    var body: some View {
        let clovers = max(0, min(5, Int((probability * 5).rounded())))
        let percent = Int((probability * 100).rounded())
        HStack(spacing: 4) {
            Text(String(repeating: "🍀", count: clovers))
            Text("\(percent)%")
                .foregroundStyle(.secondary)
        }
        .font(.caption)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Luck \(percent) percent")
    }
}

#Preview {
    // Ensure you have at least one career loaded to preview
    if let first = careersAll.first {
        CareerRow(career: first)
            .padding()
    }
}
