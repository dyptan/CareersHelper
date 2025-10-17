import Foundation

struct Abilities: Codable, Hashable {
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

    static let skillNames: [(keyPath: WritableKeyPath<Abilities, Int>, label: String)] = [
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
    @Published var abilities: Abilities
    @Published var currentOccupation: JobDetails?

    init(
        age: Int = 7,
        abilities: Abilities = Abilities(
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
        education: [(TertiaryProfile?, Level)] = [(nil, .PrimarySchool)],
        jobExperiance: Int = 0,
        currentOccupation: JobDetails? = nil
    ) {
        self.age = age
        self.abilities = abilities
        self.education = education
        self.jobExperiance = jobExperiance
    }

    func boostAbility(_ keyPath: WritableKeyPath<Abilities, Int>) {
        abilities[keyPath: keyPath] += 1
    }
   
}
