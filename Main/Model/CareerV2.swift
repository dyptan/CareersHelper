import Foundation

struct CareerV2: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let category: String
    let persona: String
    let income: Int
    let reward: String
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

    init(from career: Career) {
        self.id = career.id
        self.title = career.id
        self.category = career.category.rawValue
        self.persona = career.persona.shortTitle
        self.income = career.income
        self.reward = career.reward
        self.summary = career.summary
        self.icon = career.icon

        let clampedChances = max(1, min(5, career.chances))
        self.requirements = Requirements(
            education: CareerV2.mapEducation(fromDifficulty: career.difficulty),
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
