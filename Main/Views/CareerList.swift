import SwiftUI

struct CareerList: View {
   
    func groupedCategories(_ categories: [Category]) -> [Category]
    {
        Array(Set(careersAll.map(\.category)).intersection(categories))
    }

    var allPersonas: [Interests] { Array(Set(careersAll.map(\.persona))) }

    private func categoriesFor(_ persona: Interests) -> [Category]
    {
        careersAll.filter { $0.persona == persona }.map { $0.category }
    }

    private func careerRows(careers: [CareerV1]) -> some View {
        List {
            ForEach(careers) { career in
                NavigationLink {
                    CareerDetail(career: career)
                } label: {
                    CareerRow(career: career)
                }
            }
        }
    }

    private func categoryRows(categories: [Category]) -> some View {
        List {
            ForEach(groupedCategories(categories)) { category in
                let filtered = careersAll.filter {
                    $0.category == category
                }

                NavigationLink {
                    careerRows(careers: filtered)
                } label: {
                    CategoryRow(category: category)
                }
            }
        }
    }

    var body: some View {
        List {
            ForEach(allPersonas) { persona in
                NavigationLink {
                    categoryRows(categories: categoriesFor(persona))
                } label: {
                    InterestRow(persona: persona)
                }
            }
        
        }
    }
}

#Preview {
    NavigationStack {
        CareerList()
    }
}
