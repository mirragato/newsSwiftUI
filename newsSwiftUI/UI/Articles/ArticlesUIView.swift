import SwiftUI

struct ArticlesUIView: View {
    @ObservedObject var viewModel = ArticlesViewModel()
    
    init(category: Categories) {
        viewModel.category = category
        UITableView.appearance().tableFooterView = UIView()
    }

    var body: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: WebUIView(url: article.url)) {
                ArticleRowView(article: article)
            }
            
            if self.isLast(article: article) {
               Text("Loading ...")
                   .padding(.vertical)
            }
        }
            .onAppear {
                self.viewModel.loadArticles()
            }
        .navigationBarTitle(viewModel.category?.rawValue ?? "")
    }

    private func isLast(article: Article) -> Bool {
        let isLast =  self.viewModel.articles.last == article
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
