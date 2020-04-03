import Foundation

// MARK: - Article

struct Article: Codable, Identifiable {
    var id = UUID()
    let title: String
    let date: String
    let url: URL
    let image: String?

    enum CodingKeys: String, CodingKey {
        case title
        case date = "publishedAt"
        case url
        case image = "urlToImage"
    }
}

extension Article: Equatable {}

extension Article {
    var dateText: String {
        let isoFormatter = ISO8601DateFormatter()

        if let date = isoFormatter.date(from: date) {
            let formatter = DateComponentsFormatter()
            return formatter.difference(from: date, to: Date())
        }

        return ""
    }
}

private extension DateComponentsFormatter {
    func difference(from fromDate: Date, to toDate: Date) -> String {
        allowedUnits = [.year,.month,.weekOfMonth,.day, .hour, .minute, .second]
        maximumUnitCount = 1
        unitsStyle = .full
        if let string = string(from: fromDate, to: toDate) {
            return string + " ago"
        } else {
            return ""
        }
    }
}
