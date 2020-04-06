import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published private(set) var state: State = .loading
    var category: Categories?
    let networkManager = NewsManager()
    
    func loadArticles() {
        networkManager.getArticles(category: category ?? .all, onSuccess: { [weak self] list in
            self?.articles = list.articles
            self?.state = .loaded
        }) { [weak self] error in
            self?.state = .error(error)
        }
    }

    func loadMoreArticles() {
        if case .loading = state { return }
        state = .loading
        let page = (articles.count / 10) + 1
        networkManager.getMoreArticles(page: page, category: category ?? .all, onSuccess: { [weak self] list in
            self?.articles.append(contentsOf: list.articles)
            self?.state = .loaded
        }) { [weak self] error in
            self?.state = .error(error)
        }
    }
}

extension ArticlesViewModel {
    enum State {
        case loading
        case loaded
        case error(Error)
    }
}
