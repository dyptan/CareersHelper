//
//  Interests.swift
//  CareersApp
//
//  Created by Admin on 10/12/25.
//  Copyright © 2025 Apple. All rights reserved.
//


enum Interest: String, CaseIterable, Identifiable, Codable {
    case people = "People"
    case tools = "Tools"
    case creative = "Creative"
    case outdoors = "Outdoors"
    case sports = "Sports"
    case science = "Science"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .people: return "🤝"
        case .tools: return "🛠️"
        case .creative: return "🎨"
        case .outdoors: return "🌿"
        case .sports: return "🏅"
        case .science: return "🔬"
        }
    }

}
