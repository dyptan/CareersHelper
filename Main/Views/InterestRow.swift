import SwiftUI

struct InterestRow: View {
    var persona: ByInterest
    var body: some View {
        HStack(spacing: 12) {
            Text(persona.icon)
                .font(.system(size: 28))
            VStack(alignment: .leading) {
                Text(persona.rawValue)
                    .font(.headline)
                Text(CareerCategory.subtitle(for: persona))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
            .accessibilityIdentifier("PersonaRow_\(persona.shortTitle)")
        }
    }
}

#Preview {
    InterestRow(persona: ByInterest.people)
}
