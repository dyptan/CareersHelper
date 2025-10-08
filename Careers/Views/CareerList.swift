//
//  CareerList.swift
//  Landmarks
//
//  Created by Ivan Dyptan on 03.10.25.
//

import SwiftUI

struct CareerList: View {
    // Selection state across the three levels
    @State private var selectedPersona: InterestPersona? = nil
    @State private var selectedCategory: CareerCategory? = nil
    @State private var selectedCareer: Career? = nil

    private var personasInData: [InterestPersona] {
        let personas = Set(careers.map { $0.persona })
        return InterestPersona.allCases.filter { personas.contains($0) }
    }

    private var categoriesForSelectedPersona: [CareerCategory] {
        guard let persona = selectedPersona else { return [] }
        let categories = Set(careers.filter { $0.persona == persona }.map { $0.category })
        return CareerCategory.allCases.filter { categories.contains($0) }
    }

    private var careersForSelectedCategory: [Career] {
        guard let category = selectedCategory else { return [] }
        let filtered = careers.filter { $0.category == category }
        return filtered
    }

    var body: some View {
        NavigationSplitView {
            // Level 1: Personas
            List(personasInData, id: \.self, selection: $selectedPersona) { persona in
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
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("What do you like?")
            .onChange(of: selectedPersona) { _, _ in
                let cats = categoriesForSelectedPersona
                selectedCategory = cats.first
                selectedCareer = nil
            }
        } content: {
            // Level 2: Categories within selected persona
            if let _ = selectedPersona {
                List(selection: $selectedCategory) {
                    ForEach(categoriesForSelectedPersona, id: \.self) { category in
                        HStack(spacing: 12) {
                            Text(CareerCategory.icon(for: category))
                                .font(.system(size: 22))
                                .frame(width: 28)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(category.rawValue)
                                Text(category.examples)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                        .tag(Optional(category))
                    }
                }
                .navigationTitle("Types")
                .onChange(of: selectedCategory) { _, _ in
                    selectedCareer = nil
                }
            }
        } detail: {
            // Level 3: Compact header + Careers list
            if let category = selectedCategory {
                List {
                    // Compact header section (minimal footprint)
                    Section {
                        HStack(alignment: .top, spacing: 10) {
                            Text(CareerCategory.icon(for: category))
                                .font(.title2)
                                .padding(.top, 2)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.headline)
                                Text(category.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }

                    // Careers
                    ForEach(careersForSelectedCategory) { career in
                        NavigationLink(value: career) {
                            CareerRow(career: career)
                        }
                    }
                }
                // Register destination for value-based navigation
                .navigationDestination(for: Career.self) { career in
                    CareerDetail(career: career)
                }
            }
        }
    }
}

#Preview {
    CareerList()
}
