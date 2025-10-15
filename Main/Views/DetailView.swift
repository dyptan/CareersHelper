import SwiftUI

struct DetailView: View {
    var detail: Detail

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(detail.icon)
                    .font(.system(size: 96))
                    .padding(.top, 16)

                Text(detail.id)
                    .font(.largeTitle.bold())

                Text(detail.category.rawValue)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 16) {
                    labelBox(title: "Education", content: stars(level: detail.requirements.education))
                    labelBox(title: "Chances", content: Text(String(repeating: "🍀", count: detail.requirements.luck)))
                    labelBox(title: "Income", content: Text("\(detail.income)"))
                    labelBox(title: "Reward", content: Text(detail.reward()))
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("What is this job?")
                        .font(.title2.bold())
                    Text(detail.summary)
                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .navigationTitle("")

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
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        if let first = detailsAll.first {
            DetailView(detail: first)
        } else {
            Text("No careers loaded")
        }
    }
}
