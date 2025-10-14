import Foundation

struct Detail: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let category: Category
    let interest: Interest
    let income: Int
    func reward() -> String {
        switch income {
        case 0...60: return "💵"
        case 61..<120: return "💵💵"
        default: return "💵💵💵"
        }
    }
    let summary: String
    let icon: String
    let requirements: Requirements
    let version: Int

    struct Requirements: Codable, Hashable {
        let education: Int
        func educationLabel() -> String {
            switch education {
            case 0: "Basic language only"
            case 1: "High school"
            case 2: "Vocational training"
            case 3: "College"
            case 4: "University, academic degree"
            default: "Distinguished achievements"
            }
        }
        let luck: Int
    }
}
