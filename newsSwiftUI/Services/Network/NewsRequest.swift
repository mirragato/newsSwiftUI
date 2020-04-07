import Foundation

// MARK: - NewsRequest

enum NewsRequest: RequestBuilder {
    case getArticles(page: Int, category: Categories)

    fileprivate struct Constants {
        static let countryID = "de"
        static let country = "country"
        static let apiKeyID = "4eeccc807df94915be5433173fdb3565"
        static let apiKey = "apiKey"
        static let pageSize = "pageSize"
        static let pageSizeValue = 10
        static let page = "page"
        static let category = "category"
    }

    var path: String {
        switch self {
        case .getArticles:
            return "/v2/top-headlines/"
        }
    }

    var queryParameters: [URLQueryItem]? {
        switch self {
        case .getArticles(let page, let category):
            return [
                URLQueryItem(name: Constants.apiKey, value: Constants.apiKeyID),
                URLQueryItem(name: Constants.country, value: Constants.countryID),
                URLQueryItem(name: Constants.pageSize, value: String(Constants.pageSizeValue)),
                URLQueryItem(name: Constants.page, value: String(page)),
                URLQueryItem(name: Constants.category, value: category == .all ? "" : category.rawValue)]
        }
    }
}
