import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
    
   @Published var articles: [Article] = []
    var category: Categories?
    let networkManager = NewsManager()
    
    func loadArticles() {
        networkManager.getArticles(category: category ?? .all, onSuccess: { [weak self] list in
            self?.articles.append(contentsOf: list.articles)
        }) { [weak self] (error) in
        }
    }

    func loadMoreArticles() {
        let page = (articles.count / 10) + 1
        networkManager.getMoreArticles(page: page, category: category ?? .all, onSuccess: { [weak self] list in
            self?.articles.append(contentsOf: list.articles)
        }) { [weak self] (error) in
        }
    }
}
