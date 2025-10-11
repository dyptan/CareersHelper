import SwiftUI

struct PersonaRow: View {
    var persona: InterestPersona
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
    PersonaRow(persona: InterestPersona.people)
}
