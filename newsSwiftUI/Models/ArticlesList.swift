import Foundation

// MARK: - ArticlesList

struct ArticlesList: Codable {
    let articles: [Article]
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case articles
        case totalResults
    }
}
