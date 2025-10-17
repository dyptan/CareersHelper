import SwiftUI

struct DetailRow: View {
    var detail: JobDetails

    var body: some View {
        HStack(spacing: 12) {
            Text(detail.icon)
                .font(.system(size: 28))
                .frame(width: 40, height: 40)
                .background(Color(.systemGray))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(detail.id)
                        .font(.headline)
                    Spacer()
                    Text(detail.reward())
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.15))
                        .foregroundStyle(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                HStack(spacing: 8) {
                    DifficultyView(level: detail.requirements.education)
                    ChancesView(chances: detail.requirements.luck)
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
        let filled = max(0, min(5, level))
        let empty = max(0, 5 - filled)
        HStack(spacing: 2) {
            Text(String(repeating: "⭐️", count: filled) + String(repeating: "☆", count: empty))
                .font(.caption)
        }
    }
}

private struct ChancesView: View {
    let chances: Int
    var body: some View {
        HStack(spacing: 4) {
            Text(String(repeating: "🍀", count: chances))
        }
        .font(.caption)
    }
}

#Preview {
    if let first = detailsAll.first {
        DetailRow(detail: first)
            .padding()
    }
}
