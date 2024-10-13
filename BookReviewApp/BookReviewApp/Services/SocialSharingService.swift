import UIKit

class SocialSharingService {
    static func shareBook(_ book: Book) {
        let text = "I just read '\(book.title)' by \(book.author). My rating: \(book.rating)/5"
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}