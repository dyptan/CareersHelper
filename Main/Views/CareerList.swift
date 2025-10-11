import SwiftUI

struct CareerList: View {
   
    func groupedCategories(_ categories: [CareerCategory]) -> [CareerCategory]
    {
        Array(Set(careersAll.map(\.category)).intersection(categories))
    }

    var allPersonas: [ByInterest] { Array(Set(careersAll.map(\.persona))) }

    private func categoriesFor(_ persona: ByInterest) -> [CareerCategory]
    {
        careersAll.filter { $0.persona == persona }.map { $0.category }
    }

    private func careerRows(careers: [Career]) -> some View {
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

    private func categoryRows(categories: [CareerCategory]) -> some View {
        List {
            ForEach(groupedCategories(categories)) { category in
                let filtered: [Career] = careersAll.filter {
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
                    PersonaRow(persona: persona)
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
