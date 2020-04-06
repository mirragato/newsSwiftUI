import SwiftUI

struct ArticlesUIView: View {
    @ObservedObject var viewModel = ArticlesViewModel()
    
    init(category: Categories) {
        viewModel.category = category
        UITableView.appearance().tableFooterView = UIView()
        self.viewModel.loadArticles()
    }

    var body: some View {
        VStack {
            list
            content
                .navigationBarTitle(viewModel.category?.rawValue ?? "")
        }
    }

    private var content: some View {
        switch viewModel.state {
        case .loading:
            return Text(String.loading).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded:
            return Text("").eraseToAnyView()
            
        }
    }

    private var list: some View {
        return List(viewModel.articles) { article in
            NavigationLink(destination: WebUIView(url: article.url)) {
                ArticleRowView(article: article)
            }
            
            if self.isLast(article: article) {}
        }
    }

    private func isLast(article: Article) -> Bool {
        let isLast = self.viewModel.articles.last == article
        if isLast {
            self.viewModel.loadMoreArticles()
        }
        return isLast
    }
}

struct ArticlesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesUIView(category: .all)
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
