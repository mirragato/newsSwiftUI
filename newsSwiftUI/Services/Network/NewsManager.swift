import Foundation

// MARK: - NewsManager

final class NewsManager {

    // MARK: - Private properties

    private let networkManager: NetworkManager = .shared

    // MARK: - Public methods

    func getArticles(category: Categories = .all, onSuccess: @escaping (ArticlesList) -> Void, onError: @escaping (Error) -> Void) {
        getMoreArticles(category: category, onSuccess: onSuccess, onError: onError)
    }

    func getMoreArticles(page: Int = 0,
                         category: Categories = .all,
                         onSuccess: @escaping (ArticlesList) -> Void,
                         onError: @escaping (Error) -> Void) {
        let request = API.NewsRequest.getArticles(page: page, category: category)
        networkManager.request(requestBuilder: request, onSuccess: onSuccess, onError: onError)
    }

    func cancelPrevRequests() {
        networkManager.cancelRequests()
    }
}
