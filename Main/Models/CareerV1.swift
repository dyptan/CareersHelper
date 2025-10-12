import Foundation



struct CareerV1: Identifiable, Hashable, Decodable {
    let id: String
    var category: Category
    // 0..5 education requirement scale
    var difficulty: Int
    // 1..5 clovers: higher = harder to get paid work
    var chances: Int
    // Annual income in currency units
    var income: Int
    var summary: String
    // Emoji icon for kid-friendly visuals
    var icon: String
    // Money emoji string derived from income, stored in JSON
    var reward: String
    
    init(id: String,
         category: Category,
         difficulty: Int,
         chances: Int,
         income: Int,
         summary: String,
         icon: String,
         reward: String)
    {
        self.id = id
        self.category = category
        self.difficulty = max(0, min(5, difficulty))
        self.chances = max(1, min(5, chances))
        self.income = income
        self.summary = summary
        self.icon = icon
        self.reward = reward
    }
    
    var persona: Interests { category.persona }
    
    private enum CodingKeys: String, CodingKey {
        case id, category, difficulty, chances, income, summary, icon, reward
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.category = try container.decode(Category.self, forKey: .category)

        let decodedDifficulty = try container.decodeIfPresent(Int.self, forKey: .difficulty) ?? 3
        self.difficulty = max(0, min(5, decodedDifficulty))

        let decodedChances = try container.decodeIfPresent(Int.self, forKey: .chances) ?? 3
        self.chances = max(1, min(5, decodedChances))

        self.income = try container.decodeIfPresent(Int.self, forKey: .income) ?? 0
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary) ?? ""
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? "💼"

        if let reward = try container.decodeIfPresent(String.self, forKey: .reward) {
            self.reward = reward
        } else {
            self.reward = CareerV1.deriveReward(from: self.income)
        }
    }

    static func deriveReward(from income: Int) -> String {
        switch income {
            case ...60000: return "💵"
            case 60001...80000: return "💵💵"
            case 80001...100000: return "💵💵💵"
            default: return "💵💵💵💵"
        }
    }
}
