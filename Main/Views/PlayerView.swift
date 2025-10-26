import SwiftUI

struct ExtraActivity {
    let label: String
    let prerequisite: [SoftSkills]
    let abilityKeyPath: WritableKeyPath<SoftSkills, Int>
}

let schoolActivities: [ExtraActivity] = [
    ExtraActivity(label: "Sports", prerequisite: [], abilityKeyPath: \.physicalAbility),
    ExtraActivity(label: "Music", prerequisite: [], abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Painting", prerequisite: [] ,abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Chess", prerequisite: [], abilityKeyPath: \.attentionToDetail),
    ExtraActivity(label: "Reading", prerequisite: [], abilityKeyPath: \.creativeExpression),
    ExtraActivity(label: "Gaming", prerequisite: [], abilityKeyPath: \.spatialThinking),
    ExtraActivity(
        label: "Hanging out with friends",
        prerequisite: [],
        abilityKeyPath: \.socialCommunication
    ),
]

struct PlayerView: View {
    @StateObject private var player = Player()
    @State private var showDecisionSheet = false
    @State private var showTertiarySheet = false
    @State private var showCareersSheet = false
    @State private var selectedActivities: Set<String> = []
    @State private var selectedLanguages: Set<Language> = []
    @State private var selectedSoftware: Set<Software> = []
    @State private var selectedLicences: Set<License> = []
    @State private var selectedPortfolio: Set<PortfolioItem> = []
    @State private var selectedCertifications: Set<Certification> = []
    @State private var yearsLeftToGraduation: Int? = nil
    
    var availableCareers: [JobDetails] {
        detailsAll.filter {
            $0.requirements.education <= player.degrees.last!.1.eqf
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Age: \(player.age)")
                        .font(.title2)
                    Spacer()
                    VStack {
                        Button("+1 Year") {
                            player.age += 1
                            player.hardSkills.certifications.formUnion(selectedCertifications)
                            player.hardSkills.languages.formUnion(selectedLanguages)
                            player.hardSkills.licenses.formUnion(selectedLicences)
                            player.hardSkills.portfolioItems.formUnion(selectedPortfolio)
                            player.hardSkills.software.formUnion(selectedSoftware)
                            selectedActivities = []
                            selectedLicences = []
                            selectedLanguages = []
                            selectedPortfolio = []
                            selectedSoftware = []
                            selectedCertifications = []
                            yearsLeftToGraduation? -= 1
                            if yearsLeftToGraduation == 0 {
                                showDecisionSheet.toggle()
                                player.degrees.append((player.currentEducation, Level.Bachelor))
                                yearsLeftToGraduation = nil
                                player.currentEducation = nil
                            }
                        }
                        
                        if player.currentOccupation != nil {
                            Button("Quit Job") {
                                showDecisionSheet.toggle()
                                player.currentOccupation = nil
                            }
                        }
                    }
                }
                Text("Education Level: EQF \(player.degrees.last!.1.eqf)")
                Text("Degree: \(player.degrees.last!.1.description)")
                VStack {
                    Text("Current occupation: \(player.currentOccupation?.id ?? "None")")
                    if player.currentEducation != nil {
                        Text(
                            "Current education: \(player.currentEducation!.id)"
                        )
                    }
                }
            
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
                            Text(skill.pictogram)
                            Text(skill.label)
                            Spacer()
                            Text("\(player.softSkills[keyPath: skill.keyPath])")
                        }
                    }
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Hard skills:").font(.headline)
                    HStack {
                        Text("🗣️ Languages: ")
                        Spacer()
                        ForEach(Array(player.hardSkills.languages)) { skill in
                            Text("\(skill.rawValue)")
                        }
                    }
                    
                    HStack {
                        Text("🧩 Portfolio: ")
                        Spacer()
                        ForEach(Array(player.hardSkills.portfolioItems)) {
                            skill in
                            Text("\(skill.rawValue)")
                        }
                    }
                    
                    HStack {
                        Text("📜 Certification: ")
                        Spacer()
                        ForEach(Array(player.hardSkills.certifications)) {
                            skill in
                            Text("\(skill.rawValue)")
                        }
                    }
                    
                    HStack {
                        Text("💻 Software: ")
                        Spacer()
                        ForEach(Array(player.hardSkills.software)) { skill in
                            Text("\(skill.rawValue)")
                        }
                    }
                    
                    HStack {
                        Text("🪪 Licenses:  ")
                        Spacer()
                        ForEach(Array(player.hardSkills.licenses)) { skill in
                            Text("\(skill.rawValue)")
                        }
                    }
                }.padding()
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
                                                keyPath: activity.abilityKeyPath
                                            ] += 1

                                        } else {
                                            selectedActivities.remove(
                                                activity.label
                                            )
                                            player.softSkills[
                                                keyPath: activity.abilityKeyPath
                                            ] -= 1

                                        }
                                    }
                                )
                            )
                            .toggleStyle(.automatic)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    VStack(spacing: 10) {
                        Text("Languages:")
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
                                        selectedLanguages.contains(
                                            skill
                                        )
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedLanguages.insert(
                                                skill
                                            )
                                            
                                        } else {
                                            selectedLanguages.remove(
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
                    VStack(spacing: 10) {
                        Text("Certifications:")
                        ForEach(
                            Array(
                                HardSkills().certifications.sorted {
                                    $0.rawValue > $1.rawValue
                                }
                            )
                        ) { skill in
                            Toggle(
                                skill.rawValue,
                                isOn: Binding(
                                    get: {
                                        selectedCertifications.contains(
                                            skill
                                        )
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedCertifications.insert(
                                                skill
                                            )
                                            
                                        } else {
                                            selectedCertifications.remove(
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
                    VStack(spacing: 10) {
                        Text("Licenses:")
                        ForEach(
                            Array(
                                HardSkills().licenses.sorted {
                                    $0.rawValue > $1.rawValue
                                }
                            )
                        ) { skill in
                            Toggle(
                                skill.rawValue,
                                isOn: Binding(
                                    get: {
                                        selectedLicences.contains(
                                            skill
                                        )
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedLicences.insert(
                                                skill
                                            )
                                            
                                        } else {
                                            selectedLicences.remove(
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
                    VStack(spacing: 10) {
                        Text("Software:")
                        ForEach(
                            Array(
                                HardSkills().software.sorted {
                                    $0.rawValue > $1.rawValue
                                }
                            )
                        ) { skill in
                            Toggle(
                                skill.rawValue,
                                isOn: Binding(
                                    get: {
                                        selectedSoftware.contains(
                                            skill
                                        )
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedSoftware.insert(
                                                skill
                                            )
                                            
                                        } else {
                                            selectedSoftware.remove(
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
                    VStack(spacing: 10) {
                        Text("Portfolio Items:")
                        ForEach(
                            Array(
                                HardSkills().portfolioItems.sorted {
                                    $0.rawValue > $1.rawValue
                                }
                            )
                        ) { skill in
                            Toggle(
                                skill.rawValue,
                                isOn: Binding(
                                    get: {
                                        selectedPortfolio.contains(
                                            skill
                                        )
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedPortfolio.insert(
                                                skill
                                            )
                                            
                                        } else {
                                            selectedPortfolio.remove(
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
                .padding(.bottom, 8)
                
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
                                player.currentEducation = profile
                                yearsLeftToGraduation = 4
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
                case 10: player.degrees.append((nil, .MiddleSchool))
                case 14: player.degrees.append((nil, .HighSchool))
                case 18: showDecisionSheet = true
                default: break
                }
            }
            .padding()
        }.padding()
    }
}
