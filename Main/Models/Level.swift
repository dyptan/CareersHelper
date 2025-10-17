// Degree progression
enum Level: String, CaseIterable, Identifiable {
    case PrimarySchool
    case MiddleSchool
    case HighSchool
    case Vocational
    case Certified
    case Bachelor
    case Master
    case Doctorate
    case Job
    var id: String { rawValue }

    var eqf: Int {
        switch self {
        case .PrimarySchool : return 2
        case .MiddleSchool : return 3
        case .HighSchool : return 4
        case .Vocational, .Certified : return 5
        case .Bachelor: return 6
        case .Master: return 7
        case .Doctorate: return 8
        case .Job: return 4 //stub
        }
    }
    
    func yearsRequired(_ isUS: Bool) -> Int {
        switch (self, isUS) {
        case (.PrimarySchool, _): return 4
        case (.MiddleSchool, true): return 4
        case (.MiddleSchool, false): return 5
        case (.HighSchool, true): return 4
        case (.HighSchool, false): return 3
        case (.Certified, _): return 1
        case (.Vocational, _): return 2
        case (.Bachelor, true): return 4
        case (.Bachelor, false): return 3
        case (.Master, _): return 2
        case (.Doctorate, _): return 3
        case (.Job, _): return 1
        }
    }

    var next: [Level] {
        switch self {
        case .PrimarySchool: return [.MiddleSchool]
        case .MiddleSchool: return [.HighSchool]
        case .HighSchool: return [.Vocational, .Certified, .Bachelor]
        case .Certified: return [.Vocational, .Bachelor]
        case .Vocational: return [.Bachelor]
        case .Bachelor: return [.Master]
        case .Master: return [.Doctorate]
        case .Doctorate: return [.Job]
        case .Job: return [.Job, .Certified, .Vocational, .Bachelor, .Master, .Doctorate]
        }
    }

    var description: String {
        switch self {
        case .PrimarySchool: return "Primary School Diploma"
        case .MiddleSchool: return "Middle School Diploma"
        case .HighSchool: return "High School Diploma"
        case .Certified: return "IT Certificate, Bootcamp, License"
        case .Vocational: return "Associate Degree"
        case .Bachelor: return "Bachelor’s Degree"
        case .Master: return "Master’s Degree"
        case .Doctorate: return "Doctorate (PhD)"
        case .Job: return "Currently Employed"
        }
    }
}

enum TertiaryProfile: String, CaseIterable, Identifiable {
    case stem = "STEM"
    case arts = "Arts"
    case business = "Business"
    case sports = "Sports"
    case health = "Health"
    case humanities = "Humanities"
    case trades = "Trades & Tech"
    var id: String { rawValue }

    var description: String {
        switch self {
        case .stem: return "Science, Technology, Engineering, Mathematics"
        case .arts: return "Visual/Performing Arts, Design, Language"
        case .business: return "Business, Management, Economics"
        case .sports: return "Sports, Physical Education"
        case .health: return "Medicine, Nursing, Care"
        case .humanities: return "History, Philosophy, Literature"
        case .trades: return "Construction, Mechanics, Skilled Trades"
        }
    }

    func applyBoost(to abilities: Abilities) -> Abilities {
        var updatedAbilities = abilities
        switch self {
        case .stem:
            updatedAbilities.analyticalReasoning += 2
            updatedAbilities.attentionToDetail += 1
            updatedAbilities.spatialThinking += 1
        case .arts:
            updatedAbilities.creativeExpression += 2
            updatedAbilities.socialCommunication += 1
            updatedAbilities.teamLeadership += 1
        case .business:
            updatedAbilities.influenceAndNetworking += 2
            updatedAbilities.teamLeadership += 1
            updatedAbilities.riskTolerance += 1
        case .sports:
            updatedAbilities.physicalAbility += 2
            updatedAbilities.teamLeadership += 1
            updatedAbilities.resiliencePhysical += 1
        case .health:
            updatedAbilities.attentionToDetail += 1
            updatedAbilities.socialCommunication += 1
            updatedAbilities.resilienceCognitive += 1
            updatedAbilities.physicalAbility += 1
        case .humanities:
            updatedAbilities.socialCommunication += 2
            updatedAbilities.analyticalReasoning += 1
            updatedAbilities.creativeExpression += 1
        case .trades:
            updatedAbilities.mechanicalOperation += 2
            updatedAbilities.attentionToDetail += 1
        }
        return updatedAbilities
    }
}
