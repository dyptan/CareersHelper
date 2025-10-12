import Foundation

struct ModelV2: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let category: String
    let interest: String
    let income: Int
    func reward() -> String {
        switch income {
        case 0...60: return "Low"
        case 61..<120: return "Medium"
        default: return "High"
        }
    }
    let summary: String
    let icon: String
    let requirements: Requirements
    let version: Int

    struct Requirements: Codable, Hashable {
        let education: EducationLevel
        let luck: Int
    }

    enum EducationLevel: String, Codable, CaseIterable {
        case basicLanguageOnly = "Basic language only"
        case highSchool = "High school"
        case vocationalTraining = "Vocational training"
        case college = "College"
        case universityAcademicDegree = "University, academic degree"
        case distinguishedAchievements = "Distinguished achievements"
    }

    init(from career: CareerV1) {
        self.id = career.id
        self.title = career.id
        self.category = career.category.rawValue
        self.interest = career.persona.shortTitle
        self.income = career.income
        self.summary = career.summary
        self.icon = career.icon

        let clampedChances = max(1, min(5, career.chances))
        self.requirements = Requirements(
            education: ModelV2.mapEducation(fromDifficulty: career.difficulty),
            luck: clampedChances
        )

        self.version = 2
    }

    static func mapEducation(fromDifficulty difficulty: Int) -> EducationLevel {
        let d = max(0, min(5, difficulty))
        switch d {
        case 0: return .basicLanguageOnly
        case 1: return .highSchool
        case 2: return .vocationalTraining
        case 3: return .college
        case 4: return .universityAcademicDegree
        default: return .distinguishedAchievements
        }
    }
}
