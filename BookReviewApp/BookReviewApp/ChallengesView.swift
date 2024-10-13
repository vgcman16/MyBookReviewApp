import SwiftUI

struct Challenge: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var goal: Int
    var currentProgress: Int
    let startDate: Date
    let endDate: Date
    var isCompleted: Bool {
        currentProgress >= goal
    }
}

class ChallengeService: ObservableObject {
    @Published var challenges: [Challenge] = []
    
    init() {
        // Load challenges from UserDefaults or a database
        loadChallenges()
    }
    
    func loadChallenges() {
        // In a real app, load from UserDefaults or a database
        challenges = [
            Challenge(title: "Summer Reading", description: "Read 10 books this summer", goal: 10, currentProgress: 3, startDate: Date(), endDate: Date().addingTimeInterval(7776000)),
            Challenge(title: "Classics Challenge", description: "Read 5 classic novels", goal: 5, currentProgress: 1, startDate: Date(), endDate: Date().addingTimeInterval(15552000))
        ]
    }
    
    func addChallenge(_ challenge: Challenge) {
        challenges.append(challenge)
        // Save to UserDefaults or a database
    }
    
    func updateProgress(for challenge: Challenge, progress: Int) {
        if let index = challenges.firstIndex(where: { $0.id == challenge.id }) {
            challenges[index].currentProgress = progress
            // Update in UserDefaults or a database
        }
    }
}

struct ChallengesView: View {
    @StateObject private var challengeService = ChallengeService()
    @State private var showingAddChallenge = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(challengeService.challenges) { challenge in
                    VStack(alignment: .leading) {
                        Text(challenge.title)
                            .font(.headline)
                        Text(challenge.description)
                            .font(.subheadline)
                        ProgressView(value: Float(challenge.currentProgress), total: Float(challenge.goal))
                        Text("\(challenge.currentProgress)/\(challenge.goal)")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Reading Challenges")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddChallenge = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddChallenge) {
                AddChallengeView(challengeService: challengeService)
            }
        }
    }
}

struct AddChallengeView: View {
    @ObservedObject var challengeService: ChallengeService
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var description = ""
    @State private var goal = 1
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(2592000) // 30 days from now
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Stepper("Goal: \(goal)", value: $goal, in: 1...100)
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            }
            .navigationTitle("Add Challenge")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newChallenge = Challenge(title: title, description: description, goal: goal, currentProgress: 0, startDate: startDate, endDate: endDate)
                        challengeService.addChallenge(newChallenge)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}