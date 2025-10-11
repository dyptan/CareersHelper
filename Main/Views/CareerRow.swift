import SwiftUI

struct CareerRow: View {
    var career: CareerV1

    var body: some View {
        HStack(spacing: 12) {
            Text(career.icon)
                .font(.system(size: 28))
                .frame(width: 40, height: 40)
                .background(Color(.systemGray))
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
                    ChancesView(chances: career.chances)
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
        // 0..5 education stars using emoji
        let filled = max(0, min(5, level))
        let empty = max(0, 5 - filled)
        HStack(spacing: 2) {
            Text(String(repeating: "⭐️", count: filled) + String(repeating: "☆", count: empty))
                .font(.caption)
                .accessibilityLabel("Education level \(filled) out of 5")
        }
    }
}

private struct ChancesView: View {
    let chances: Int
    var body: some View {
        let c = max(1, min(5, chances))
        HStack(spacing: 4) {
            Text(String(repeating: "🍀", count: c))
        }
        .font(.caption)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Chances \(c) clovers. Higher means harder to get paid.")
    }
}

#Preview {
    if let first = careersAll.first {
        CareerRow(career: first)
            .padding()
    }
}
