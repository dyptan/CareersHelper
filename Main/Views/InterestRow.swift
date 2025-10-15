import SwiftUI

struct InterestRow: View {
    var interest: Interest
    var body: some View {
        HStack(spacing: 12) {
            Text(interest.icon)
                .font(.system(size: 28))
            VStack(alignment: .leading) {
                Text(interest.rawValue)
                    .font(.headline)
                Text(interest.examples)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
        }
    }
}

#Preview {
    InterestRow(interest: Interest.people)
}
