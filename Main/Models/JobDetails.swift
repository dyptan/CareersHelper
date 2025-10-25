import Foundation

struct JobDetails: Identifiable, Codable, Hashable {
    // luck: 0 = Low-paid, poor working conditions, "desperation jobs"
    // luck: 1 = Mainstream, steady jobs (nurse, teacher, technician, etc)
    // luck: 2 = Highly competitive/fast-growing, but broadly accessible (tech, design, entry data, etc)
    // luck: 3 = Rare, niche, or out-of-date professions
    // luck: 4 = Elite, prestigious, extremely selective (investment banker, astronaut, etc)
    // luck: 5 = High risk/high reward (influencer, celebrity, eSports, etc)
    //
    // education: 0 = EQF 1 (No formal education / basic skills)
    // education: 1 = EQF 2 (Primary school)
    // education: 2 = EQF 3 (Lower secondary)
    // education: 3 = EQF 4 (Upper secondary, high school, apprenticeship)
    // education: 4 = EQF 5 (Short-cycle tertiary or advanced vocational)
    // education: 5 = EQF 6 (Bachelor's degree or equivalent)
    // education: 6 = EQF 7 (Master's degree or equivalent)
    // education: 7 = EQF 8 (Doctorate or equivalent)
    //
    // cognitive/physical requirement levels (0–5):
    //   0 = Not needed
    //   1 = Minimal/basic
    //   2 = Somewhat helpful
    //   3 = Clearly useful/moderate
    //   4 = Important/high
    //   5 = Essential/critical for success
    let id: String
    let category: Category
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
        let luck: Int

        let cognitive: Cognitive
        let physical: Physical

        struct Cognitive: Codable, Hashable {
            let analyticalReasoning: Int?
            let creativeExpression: Int?
            let socialCommunication: Int?
            let teamLeadership: Int?
            let influenceAndNetworking: Int?
            let riskTolerance: Int?
            let spatialThinking: Int?
            let attentionToDetail: Int?
            let resilienceCognitive: Int?
        }

        struct Physical: Codable, Hashable {
            let mechanicalOperation: Int?
            let physicalAbility: Int?
            let outdoorOrientation: Int?
            let resiliencePhysical: Int?
        }

        var analyticalReasoning: Int { cognitive.analyticalReasoning ?? 0 }
        var creativeExpression: Int { cognitive.creativeExpression ?? 0 }
        var socialCommunication: Int { cognitive.socialCommunication ?? 0 }
        var teamLeadership: Int { cognitive.teamLeadership ?? 0 }
        var influenceAndNetworking: Int { cognitive.influenceAndNetworking ?? 0 }
        var riskTolerance: Int { cognitive.riskTolerance ?? 0 }
        var spatialThinking: Int { cognitive.spatialThinking ?? 0 }
        var attentionToDetail: Int { cognitive.attentionToDetail ?? 0 }
        var resilienceCognitive: Int { cognitive.resilienceCognitive ?? 0 }

        var mechanicalOperation: Int { physical.mechanicalOperation ?? 0 }
        var physicalAbility: Int { physical.physicalAbility ?? 0 }
        var outdoorOrientation: Int { physical.outdoorOrientation ?? 0 }
        var resiliencePhysical: Int { physical.resiliencePhysical ?? 0 }

        func educationLabel() -> String {
            switch education {
            case ..<1: return "EQF 1"
            case 1: return "EQF 1"
            case 2: return "EQF 2"
            case 3: return "EQF 3"
            case 4: return "EQF 4"
            case 5: return "EQF 5"
            case 6: return "EQF 6"
            case 7: return "EQF 7"
            default: return "EQF 8+"
            }
        }
    }

//    private func personaScores() -> [Group: Double] {
//        let r = requirements
//
//        // Base scores from digitized traits
//        var scores: [Group: Double] = [
//            .people:      1.0 * Double(r.socialCommunication) + 0.7 * Double(r.teamLeadership) + 0.5 * Double(r.influenceAndNetworking) + 0.3 * Double(r.attentionToDetail) + 0.2 * Double(r.resilienceCognitive),
//            .tools:       1.0 * Double(r.analyticalReasoning) + 0.7 * Double(r.attentionToDetail) + 0.5 * Double(r.spatialThinking) + 0.2 * Double(r.resilienceCognitive),
//            .creative:    1.0 * Double(r.creativeExpression) + 0.4 * Double(r.socialCommunication),
//            .outdoors:    1.0 * Double(r.outdoorOrientation) + 0.4 * Double(r.mechanicalOperation) + 0.3 * Double(r.physicalAbility) + 0.3 * Double(r.resiliencePhysical),
//            .sports:      1.0 * Double(r.physicalAbility) + 0.6 * Double(r.resiliencePhysical) + 0.3 * Double(r.socialCommunication) + 0.2 * Double(r.riskTolerance),
//            .science:     1.0 * Double(r.analyticalReasoning) + 0.7 * Double(r.attentionToDetail) + 0.4 * Double(r.spatialThinking) + 0.3 * Double(r.riskTolerance) + 0.2 * Double(r.resilienceCognitive),
//            .mechanical:  1.0 * Double(r.mechanicalOperation) + 0.6 * Double(r.spatialThinking) + 0.4 * Double(r.riskTolerance) + 0.3 * Double(r.attentionToDetail) + 0.2 * Double(r.resiliencePhysical)
//        ]
//
//        // Light nudges
//        if r.socialCommunication >= 4 && r.teamLeadership <= 2 {
//            scores[.people, default: 0] += 0.4
//        }
//        if r.teamLeadership >= 4 && r.socialCommunication >= 3 {
//            scores[.people, default: 0] += 0.5
//        }
//        if r.influenceAndNetworking >= 4 && r.socialCommunication >= 3 {
//            scores[.people, default: 0] += 0.4
//        }
//        if r.riskTolerance >= 4 && r.mechanicalOperation >= 3 {
//            scores[.mechanical, default: 0] += 0.5
//        }
//        if r.outdoorOrientation >= 3 && r.analyticalReasoning >= 3 {
//            scores[.science, default: 0] += 0.3
//            scores[.outdoors, default: 0] += 0.3
//        }
//        if r.education >= 5 { // Higher EQF tends to reinforce Tools/Science paths
//            scores[.tools, default: 0] += 0.3
//            scores[.science, default: 0] += 0.3
//        }
//
//        return scores
//    }

//    var effectiveInterest: Group {
//        // If any digitized trait is present (>0), use scoring
//        let r = requirements
//        let hasTraits =
//            r.analyticalReasoning > 0 ||
//            r.creativeExpression > 0 ||
//            r.socialCommunication > 0 ||
//            r.teamLeadership > 0 ||
//            r.influenceAndNetworking > 0 ||
//            r.riskTolerance > 0 ||
//            r.spatialThinking > 0 ||
//            r.attentionToDetail > 0 ||
//            r.resilienceCognitive > 0 ||
//            r.mechanicalOperation > 0 ||
//            r.physicalAbility > 0 ||
//            r.outdoorOrientation > 0 ||
//            r.resiliencePhysical > 0
//
//        if hasTraits {
//            let scores = personaScores()
//            if let best = scores.max(by: { $0.value < $1.value })?.key {
//                return best
//            }
//        }
//
//        // No legacy fallback; default to the category’s persona
//        return category.persona
//    }
}
