import Foundation
struct HardSkills: Codable, Hashable {
    var programmingLanguages: [String]
    var portfolioItems: [String]
    var certifications: [String]
    var softwareTools: [String]
    var licenses: [String]

    static let skillNames: [(keyPath: WritableKeyPath<HardSkills, [String]>, label: String)] = [
        (\HardSkills.programmingLanguages, "Programming Languages"),
        (\HardSkills.portfolioItems, "Portfolio Items"),
        (\HardSkills.certifications, "Certifications"),
        (\HardSkills.softwareTools, "Software Tools"),
        (\HardSkills.licenses, "Licenses")
    ]
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
            programmingLanguages: [],
            portfolioItems: [],
            certifications: [],
            softwareTools: [],
            licenses: []
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
