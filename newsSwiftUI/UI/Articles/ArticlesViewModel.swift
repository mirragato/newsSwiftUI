import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published private(set) var state: State = .loading
    var category: Categories = .all
    private let networkManager = NetworkManager<NewsRequest>()
    private var totalResult = 0
    private var cancellableSet = Set<AnyCancellable>()
    
    func loadArticles(searchText: String? = nil) {
        articles = []
        sendRequest(searchText: searchText ?? "")
    }

    func loadMoreArticles() {
        guard totalResult > articles.count else { return }
        if case .loading = state { return }
        state = .loading
        let page = (articles.count / 10) + 1
        sendRequest(for: page)
    }

    private func sendRequest(for page: Int = 1, searchText: String = "") {
        networkManager.request(requestBuilder: .getArticles(page: page, searchText: searchText, category: category))
        .decode(type: ArticlesList.self, decoder: JSONDecoder())
        .map { list in
            DispatchQueue.main.async {
                self.articles.append(contentsOf: list.articles)
            }
            self.totalResult = list.totalResults
            return .loaded
        }
        .replaceError(with: .loaded)
        .receive(on: RunLoop.main)
        .assign(to: \.state, on: self)
        .store(in: &cancellableSet)
    }
}

extension ArticlesViewModel {
    enum State {
        case loading
        case loaded
    }
}
