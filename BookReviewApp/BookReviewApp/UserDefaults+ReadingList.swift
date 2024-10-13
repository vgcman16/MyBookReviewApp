import Foundation

extension UserDefaults {
    var readingList: [Book] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "readingList") else { return [] }
            return (try? JSONDecoder().decode([Book].self, from: data)) ?? []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "readingList")
            }
        }
    }
}