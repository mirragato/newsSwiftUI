import Foundation

// MARK: - NewsRequest

extension API {
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
                return "top-headlines/"
            }
        }

        var queryParameters: [String : Any]? {
            switch self {
            case .getArticles(let page, let category):
                return [
                    Constants.apiKey: Constants.apiKeyID,
                    Constants.country: Constants.countryID,
                    Constants.pageSize : Constants.pageSizeValue,
                    Constants.page : page,
                    Constants.category : category == .all ? "" : category.rawValue]
            }
        }
    }
}
