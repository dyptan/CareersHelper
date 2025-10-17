import SwiftUI

struct GroupView: View {
   
    func distinct(categories: [Category]) -> [Category]
    {
        Array(Set(detailsAll.map(\.category)).intersection(categories))
    }

    // Use effectiveInterest for grouping
    var interests: [Group] { Array(Set(detailsAll.map(\.effectiveInterest))) }

    private func categoriesFor(_ interest: Group) -> [Category]
    {
        detailsAll.filter { $0.effectiveInterest == interest }.map { $0.category }
    }

    private func careerRows(details: [Detail]) -> some View {
        List {
            ForEach(details) { detail in
                NavigationLink {
                    DetailView(detail: detail)
                } label: {
                    DetailRow(detail: detail)
                }
            }
        }
    }

    private func categoryRows(categories: [Category]) -> some View {
        List {
            ForEach(distinct(categories: categories)) { category in
                let filteredDetails = detailsAll.filter { $0.category == category }

                NavigationLink {
                    careerRows(details: filteredDetails)
                } label: {
                    CategoryRow(category: category)
                }
            }
        }
    }

    var body: some View {
        List {
            ForEach(interests) { interest in
                NavigationLink {
                    categoryRows(categories: categoriesFor(interest))
                } label: {
                    GroupRow(interest: interest)
                }
            }
        
        }.navigationTitle("What kind of activities are closest to you?")
    }
}

#Preview {
    NavigationStack {
        GroupView()
    }
}
