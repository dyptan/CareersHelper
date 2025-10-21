import SwiftUI

struct ExtraActivity {
    let label: String
    let abilityKeyPath: WritableKeyPath<SoftSkills, Int>
}

let schoolActivities: [ExtraActivity] = [
    ExtraActivity(label: "Sports", abilityKeyPath: \.physicalAbility),
    ExtraActivity(label: "Music", abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Painting", abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Chess", abilityKeyPath: \.attentionToDetail),
    ExtraActivity(label: "Reading", abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Gaming", abilityKeyPath: \.spatialThinking),
    ExtraActivity(
        label: "Hanging out with friends",
        abilityKeyPath: \.socialCommunication
    ),
]

struct PlayerView: View {
    @StateObject private var player = Player()
    @State private var showDecisionSheet = false
    @State private var showTertiarySheet = false
    @State private var showCareersSheet = true
    @State private var selectedActivities: Set<String> = []

    var availableCareers: [JobDetails] {
        detailsAll.filter {
            $0.requirements.education <= player.education.last!.1.eqf
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                HStack {
                    Text("Age: \(player.age)")
                        .font(.title2)
                    Spacer()
                    Button("+1 Year") {
                        player.age += 1
                        selectedActivities = []
                    }
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Education Level: EQF \(player.education.last!.1.eqf)")
                        .font(.headline)
                    Text(player.education.last!.1.description)
                    HStack {
                        Text("Current occupation:").font(.headline)
                        Text(player.currentOccupation?.id ?? "Unempoeyed")
                        Text(player.currentOccupation?.icon ?? "")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 10)

            HStack {
                VStack(alignment: .leading) {
                    Text("Soft skills:")
                        .font(.headline)
                    ForEach(
                        Array(SoftSkills.skillNames.enumerated()),
                        id: \.offset
                    ) { (idx, skill) in
                        HStack {
                            Text(skill.label)
                            Spacer()
                            Text("\(player.softSkills[keyPath: skill.keyPath])")
                        }
                    }
                }.padding()

                VStack {
                    Text("Hard skills:")
                    HStack {
                        Text("Languages:")
                        Spacer()
                        ForEach(Array(player.hardSkills.languages)) { skill in
                            Text("\(skill.rawValue)")
                        }
                    }

                    HStack {
                        Text("Portfolio Items:")
                        Spacer()
                        ForEach(Array(player.hardSkills.portfolioItems)) {
                            skill in
                            Text("\(skill.rawValue)")
                        }
                    }

                    HStack {
                        Text("Certification:")
                        Spacer()
                        ForEach(Array(player.hardSkills.certifications)) {
                            skill in
                            Text("\(skill.rawValue)")
                        }
                    }

                    HStack {
                        Text("Software:")
                        Spacer()
                        ForEach(Array(player.hardSkills.software)) { skill in
                            Text("\(skill.rawValue)")
                        }
                    }

                    HStack {
                        Text("Licenses:")
                        Spacer()
                        ForEach(Array(player.hardSkills.licenses)) { skill in
                            Text("\(skill.rawValue)")
                        }
                    }
                }
            }

            Divider()

            Text("Choose an activity to boost a skill:")
            HStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(schoolActivities, id: \.label) { activity in
                            Toggle(
                                activity.label,
                                isOn: Binding(
                                    get: {
                                        selectedActivities.contains(
                                            activity.label
                                        )
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedActivities.insert(
                                                activity.label
                                            )
                                            player.softSkills[
                                                keyPath: activity
                                                    .abilityKeyPath
                                            ] += 1
                                            player.age += 1
                                        } else {
                                            selectedActivities.remove(
                                                activity.label
                                            )
                                            player.softSkills[
                                                keyPath: activity
                                                    .abilityKeyPath
                                            ] -= 1
                                            player.age -= 1
                                        }
                                    }
                                )
                            )
                            .toggleStyle(.automatic)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.bottom, 8)

                if player.age >= 18 {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(
                                Array(
                                    HardSkills().languages.sorted {
                                        $0.rawValue > $1.rawValue
                                    }
                                )
                            ) { skill in
                                Toggle(
                                    skill.rawValue,
                                    isOn: Binding(
                                        get: {
                                            player.hardSkills.languages.contains(
                                                skill
                                            )
                                        },
                                        set: { isSelected in
                                            if isSelected {
                                                player.hardSkills.languages.insert(
                                                    skill
                                                )

                                            } else {
                                                player.hardSkills.languages.remove(
                                                    skill
                                                )
                                            }
                                        }
                                    )
                                )
                                .toggleStyle(.checkbox)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }

        }
        .sheet(isPresented: $showDecisionSheet) {
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
                    Button("Find a job") {
                        showTertiarySheet = false
                        showCareersSheet = true
                    }
                    .foregroundStyle(.secondary)
                }
                .padding()
            }
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showCareersSheet) {
            NavigationStack {

                ScrollView {
                    VStack {
                        Text("Jobs for you")
                            .font(.title2)
                            .padding(.vertical)

                        ForEach(availableCareers) { detail in
                            NavigationLink {
                                VStack {
                                    DetailView(detail: detail)

                                    Button("Choose this job") {
                                        player.currentOccupation = detail
                                        showCareersSheet = false
                                    }.padding()
                                }
                            } label: {
                                DetailRow(detail: detail)
                            }
                        }
                        .listStyle(.plain)

                        Button("Close") {
                            showCareersSheet = false
                        }
                        .padding(.top)
                    }
                    .padding()
                }
            }
            .presentationDetents([.medium, .large])
        }
        .onChange(of: player.age) { oldValue, newValue in
            switch newValue {
            case 10: player.education.append((nil, .MiddleSchool))
            case 14: player.education.append((nil, .HighSchool))
            case 18: showDecisionSheet = true
            default: break
            }
        }
        .padding()
    }
}
