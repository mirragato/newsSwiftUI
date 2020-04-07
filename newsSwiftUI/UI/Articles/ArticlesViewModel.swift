import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
    
    @Published var articles: [Article] = [] {
        didSet {
            self.state = .loaded
        }
    }
    @Published private(set) var state: State = .loading
    var category: Categories = .all
    private let networkManager = NetworkManager<NewsRequest>()
    private var totalResult = 0
    private var cancellableSet = Set<AnyCancellable>()
    
    func loadArticles() {
        sendRequest()
    }

    func loadMoreArticles() {
        guard totalResult > articles.count else { return }
        if case .loading = state { return }
        state = .loading
        let page = (articles.count / 10) + 1
        sendRequest(for: page)
    }

    private func sendRequest(for page: Int = 1) {
        networkManager.request(requestBuilder: .getArticles(page: page, category: category))
        .decode(type: ArticlesList.self, decoder: JSONDecoder())
        .map { $0.articles }
        .append(articles)
        .replaceError(with: [])
        .receive(on: RunLoop.main)
        .assign(to: \.articles, on: self)
        .store(in: &cancellableSet)
    }
}

extension ArticlesViewModel {
    enum State {
        case loading
        case loaded
        case error(Error)
    }
}
