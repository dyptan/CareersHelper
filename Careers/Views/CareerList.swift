import SwiftUI

struct CareerList: View {
    @State private var selectedPersona: InterestPersona? = InterestPersona
        .creative
    @State private var selectedCategory: CareerCategory? = nil
    @State private var selectedCareer: Career? = nil
    var groupedCareersByPersona: [InterestPersona: [Career]] {
        careersAll.reduce(into: [:]) { result, career in
            result[career.persona, default: []].append(career)
        }
    }

    var allPersonas: [InterestPersona] { Array(groupedCareersByPersona.keys) }

    private func categoriesFor(_ persona: InterestPersona)
        -> [CareerCategory]
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
            ForEach(categories) { category in
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
    CareerList()
}
