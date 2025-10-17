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

    func applyBoost(to player: Player) {
        switch self {
        case .stem:
            player.cognitive.analyticalReasoning += 2
            player.cognitive.attentionToDetail += 1
            player.cognitive.spatialThinking += 1
        case .arts:
            player.cognitive.creativeExpression += 2
            player.cognitive.socialCommunication += 1
            player.cognitive.teamLeadership += 1
        case .business:
            player.cognitive.influenceAndNetworking += 2
            player.cognitive.teamLeadership += 1
            player.cognitive.riskTolerance += 1
        case .sports:
            player.physical.physicalAbility += 2
            player.cognitive.teamLeadership += 1
            player.physical.resiliencePhysical += 1
        case .health:
            player.cognitive.attentionToDetail += 1
            player.cognitive.socialCommunication += 1
            player.cognitive.resilienceCognitive += 1
            player.physical.physicalAbility += 1
        case .humanities:
            player.cognitive.socialCommunication += 2
            player.cognitive.analyticalReasoning += 1
            player.cognitive.creativeExpression += 1
        case .trades:
            player.physical.mechanicalOperation += 2
            player.physical.outdoorOrientation += 1
            player.cognitive.attentionToDetail += 1
        }
    }
}

enum PlayerPathway: Equatable {
    case none
    case tertiary(profile: TertiaryProfile, degree: Level, years: Int)
    case job

    var label: String {
        switch self {
        case .none: return "None"
        case .tertiary(let profile, let degree, _): return "Tertiary: \(profile.rawValue) (\(degree.rawValue))"
        case .job: return "Job"
        }
    }
}
