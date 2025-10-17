import SwiftUI

struct ExtraActivity {
    let label: String
    let abilityKeyPath: WritableKeyPath<Abilities, Int>
}

let schoolActivities: [ExtraActivity] = [
    ExtraActivity(label: "Sports", abilityKeyPath: \.physicalAbility),
    ExtraActivity(label: "Music", abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Painting", abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Chess", abilityKeyPath: \.attentionToDetail),
    ExtraActivity(label: "Math Tutor", abilityKeyPath: \.analyticalReasoning),
]

let collegeActivities: [ExtraActivity] = [
    ExtraActivity(label: "Internship", abilityKeyPath: \.attentionToDetail),
    ExtraActivity(label: "Student Government", abilityKeyPath: \.teamLeadership),
    ExtraActivity(label: "Research Assistant", abilityKeyPath: \.analyticalReasoning),
    ExtraActivity(label: "Hackathons", abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Volunteer Work", abilityKeyPath: \.socialCommunication),
    ExtraActivity(label: "Public speaking / debate clubs", abilityKeyPath: \.influenceAndNetworking),
    ExtraActivity(label: "Study Abroad", abilityKeyPath: \.riskTolerance)
]

struct PlayerView: View {
    @StateObject private var player = Player()
    @State private var showDecisionSheet = false
    @State private var showTertiarySheet = false
    @State private var showNextStepSheet = false
    @State private var showCareersSheet = false

    @State private var highestDegree: Level? = nil
    @State private var nextDegreeCandidate: (TertiaryProfile, Level)? = nil

    var availableCareers: [Detail] {
        detailsAll.filter { $0.requirements.education <= player.education.last!.1.eqf }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack {
                    Text("Age: \(player.age)")
                        .font(.title2)

                        
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Education Level: EQF \(player.education.last!.1.eqf)")
                            .font(.headline)
                        Text(player.education.last!.1.description)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 10)


                VStack(alignment: .leading) {
                    Text("Abilities")
                        .font(.headline)
                    ForEach(Array(Abilities.skillNames.enumerated()), id: \.offset) { (idx, skill) in
                        HStack {
                            Text(skill.label)
                            Spacer()
                            Text("\(player.abilities[keyPath: skill.keyPath])")
                        }
                    }
                }
                .padding()

                Divider()

                if player.education.last!.1.eqf < 5 {
                    Text("Choose an activity to boost a skill:")
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(schoolActivities, id: \.label) { activity in
                                    Button {
                                        player.abilities[keyPath: activity.abilityKeyPath] += 1
                                        player.age += 1
                                    } label: {
                                        Text(activity.label)
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                }
                            }
                        }
                        .padding(.bottom, 8)
                        Button {
                            player.age += 1
                            player.education.append((TertiaryProfile.trades, Level.Certified))
                        } label: {
                            Text("Certification")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 5)
                    
                } else {
                   Button {
                        player.age += 1
                    } label: {
                        Text("Next Year")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                if player.education.last!.1.eqf >= 5 {
                    Divider()
                    Text("College Activities")
                        .font(.headline)
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(collegeActivities, id: \.label) { activity in
                                Button {
                                    player.abilities[keyPath: activity.abilityKeyPath] += 1
                                    player.age += 1
                                } label: {
                                    Text(activity.label)
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
            .navigationTitle("Player Growth")
            .padding()
            .onChange(of: player.age) { oldValue, newValue in
                if newValue == 18 {
                    showDecisionSheet = true
                }
            }
            .sheet(isPresented: $showDecisionSheet) {
                NavigationStack {
                    VStack(spacing: 18) {
                        Text("You're 18! What's your next step?")
                            .font(.title2)
                            .padding()
                        Button {
                            showDecisionSheet = false
                            showTertiarySheet = true
                        } label: {
                            Text("Enter College / University")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)

                        Button {
                            showDecisionSheet = false
                            showCareersSheet = true
                        } label: {
                            Text("Find a Job")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)

                        Button("Cancel") {
                            showDecisionSheet = false
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding()
                }
                .presentationDetents([.medium])
            }
            .sheet(isPresented: $showTertiarySheet) {
                NavigationStack {
                    VStack(spacing: 16) {
                        Text("Pick your education direction")
                            .font(.title2)
                            .padding(.vertical)
                        ForEach(TertiaryProfile.allCases) { profile in
                            Button {
                                
                                showTertiarySheet = false
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(profile.rawValue)
                                        .font(.headline)
                                    Text(profile.description)
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        Button("Cancel") {
                            showTertiarySheet = false
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding()
                }
                .presentationDetents([.medium, .large])
            }

            .sheet(isPresented: $showCareersSheet) {
                NavigationStack {
                    VStack {
                        Text("Careers for you (EQF \(player.education.last!.1.eqf)+)")
                            .font(.title2)
                            .padding(.vertical)
                        if availableCareers.isEmpty {
                            Text("No careers found for your education level.")
                                .foregroundStyle(.secondary)
                        } else {
                            List(availableCareers, id: \.id) { detail in
                                NavigationLink {
                                    DetailView(detail: detail)
                                } label: {
                                    DetailRow(detail: detail)
                                }
                            }
                            .listStyle(.plain)
                        }
                        Button("Close") {
                            showCareersSheet = false
                        }
                        .padding(.top)
                    }
                    .padding()
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

#Preview {
    PlayerView()
}
