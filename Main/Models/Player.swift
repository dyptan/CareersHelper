import Foundation

enum Language: String, Codable, Hashable, CaseIterable, Identifiable {
    case swift, C, python, java, english, german, ukraininan
    var id: String { rawValue }
}
enum PortfolioItem: String, Codable, Hashable, CaseIterable, Identifiable {
    case app, website, game, library, paper, presentation
    var id: String { rawValue }
}
enum Certification: String, Codable, Hashable, CaseIterable, Identifiable{
    case aws, azure, google, scrum, security
    var id: String { rawValue }
}
enum Software: String, Codable, Hashable, CaseIterable, Identifiable {
    case xcode, linux, unity, photoshop, blender, excel
    var id: String { rawValue }
}
enum License: String, Codable, Hashable, CaseIterable, Identifiable {
    case drivers, pilot, nurse
    var id: String { rawValue }
}

struct HardSkills: Codable, Hashable {
    var languages: Set<Language> = Set(Language.allCases)
    var portfolioItems: Set<PortfolioItem> = []
    var certifications: Set<Certification> = []
    var software: Set<Software> = []
    var licenses: Set<License> = []
}

struct SoftSkills: Codable, Hashable {
    var analyticalReasoning: Int
    var creativeExpression: Int
    var socialCommunication: Int
    var teamLeadership: Int
    var influenceAndNetworking: Int
    var riskTolerance: Int
    var spatialThinking: Int
    var attentionToDetail: Int
    var resilienceCognitive: Int
    var mechanicalOperation: Int
    var physicalAbility: Int
    var resiliencePhysical: Int

    static let skillNames: [(keyPath: WritableKeyPath<SoftSkills, Int>, label: String)] = [
        (\.analyticalReasoning, "Analytical Reasoning"),
        (\.creativeExpression, "Creative Expression"),
        (\.socialCommunication, "Social Communication"),
        (\.teamLeadership, "Team Leadership"),
        (\.influenceAndNetworking, "Influence & Networking"),
        (\.riskTolerance, "Risk Tolerance"),
        (\.spatialThinking, "Spatial Thinking"),
        (\.attentionToDetail, "Attention to Detail"),
        (\.mechanicalOperation, "Mechanical Operation"),
        (\.physicalAbility, "Physical Ability"),
        (\.resilienceCognitive, "Cognitive Resilience"),
        (\.resiliencePhysical, "Physical Resilience")
    ]
}

final class Player: ObservableObject {
    @Published var age: Int
    @Published var education: [(TertiaryProfile?, Level)]
    @Published var jobExperiance: Int
    @Published var softSkills: SoftSkills
    @Published var hardSkills: HardSkills
    @Published var currentOccupation: JobDetails?

    init(
        age: Int = 7,
        abilities: SoftSkills = SoftSkills(
            analyticalReasoning: Int.random(in: 0..<3),
            creativeExpression: Int.random(in: 0..<3),
            socialCommunication: Int.random(in: 0..<3),
            teamLeadership: Int.random(in: 0..<3),
            influenceAndNetworking: Int.random(in: 0..<3),
            riskTolerance: Int.random(in: 0..<3),
            spatialThinking: Int.random(in: 0..<3),
            attentionToDetail: Int.random(in: 0..<3),
            resilienceCognitive: Int.random(in: 0..<3),
            mechanicalOperation: Int.random(in: 0..<3),
            physicalAbility: 0,
            resiliencePhysical: 0
        ),
        hardSkills: HardSkills = HardSkills(
            languages: [.ukraininan, .english, .german, .C, .java, .python],
            portfolioItems: [.app],
            certifications: [.aws],
            software: [.linux],
            licenses: [.drivers]
        ),
        education: [(TertiaryProfile?, Level)] = [(nil, .PrimarySchool)],
        jobExperiance: Int = 0,
        currentOccupation: JobDetails? = nil
    ) {
        self.age = age
        self.softSkills = abilities
        self.hardSkills = hardSkills
        self.education = education
        self.jobExperiance = jobExperiance
        self.currentOccupation = currentOccupation
    }

    func boostAbility(_ keyPath: WritableKeyPath<SoftSkills, Int>) {
        softSkills[keyPath: keyPath] += 1
    }
   
}

