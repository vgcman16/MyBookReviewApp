import SwiftUI

struct BookClub: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var members: [String]
    var currentBook: String
    var meetingSchedule: String
}

class BookClubService: ObservableObject {
    @Published var bookClubs: [BookClub] = []
    
    init() {
        // Load book clubs from UserDefaults or a database
        loadBookClubs()
    }
    
    func loadBookClubs() {
        // In a real app, load from UserDefaults or a database
        bookClubs = [
            BookClub(name: "Sci-Fi Enthusiasts", description: "We love all things science fiction!", members: ["John", "Emma"], currentBook: "Dune", meetingSchedule: "Every other Tuesday"),
            BookClub(name: "Classic Literature", description: "Exploring the great works of literature", members: ["Sarah", "Michael"], currentBook: "Pride and Prejudice", meetingSchedule: "First Monday of the month")
        ]
    }
    
    func createBookClub(_ bookClub: BookClub) {
        bookClubs.append(bookClub)
        // Save to UserDefaults or a database
    }
    
    func joinBookClub(_ bookClub: BookClub, member: String) {
        if let index = bookClubs.firstIndex(where: { $0.id == bookClub.id }) {
            bookClubs[index].members.append(member)
            // Update in UserDefaults or a database
        }
    }
}

struct BookClubsView: View {
    @StateObject private var bookClubService = BookClubService()
    @State private var showingCreateClub = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookClubService.bookClubs) { club in
                    VStack(alignment: .leading) {
                        Text(club.name)
                            .font(.headline)
                        Text(club.description)
                            .font(.subheadline)
                        Text("Current Book: \(club.currentBook)")
                            .font(.caption)
                        Text("Members: \(club.members.joined(separator: ", "))")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Book Clubs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateClub = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateClub) {
                CreateBookClubView(bookClubService: bookClubService)
            }
        }
    }
}

struct CreateBookClubView: View {
    @ObservedObject var bookClubService: BookClubService
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var description = ""
    @State private var currentBook = ""
    @State private var meetingSchedule = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Club Name", text: $name)
                TextField("Description", text: $description)
                TextField("Current Book", text: $currentBook)
                TextField("Meeting Schedule", text: $meetingSchedule)
            }
            .navigationTitle("Create Book Club")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        let newClub = BookClub(name: name, description: description, members: [], currentBook: currentBook, meetingSchedule: meetingSchedule)
                        bookClubService.createBookClub(newClub)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}