import SwiftUI



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

                if player.age < 18 {
                    Text("Choose an activity to boost a skill:")
                        .font(.headline)
                        .padding(.top, 8)

                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(Abilities.skillNames, id: \.label) { skill in
                                Button {
                                    player.boostAbility(skill.keyPath)
                                } label: {
                                    Text("+1 \(skill.label)")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    .padding(.bottom, 8)
                } else {
                   Button {
                        player.age += 1
                    } label: {
                        Text("Next Year")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Player Growth")
            .padding()
            .onAppear {
//                checkForDecision()
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
