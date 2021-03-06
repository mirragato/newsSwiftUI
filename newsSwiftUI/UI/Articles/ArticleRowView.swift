import SwiftUI
import UIKit

struct ArticleRowView: View {
    var article: Article
    var textValue: String

    init(article: Article) {
        self.textValue = article.dateText
        self.article = article
    }

    var body: some View {
        NavigationLink(destination: WebUIView(url: self.article.url)) {
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    URLImage(stringForURL: self.article.image)
                        .scaledToFill()
                    VStack(alignment: .leading) {
                        Text(self.article.title)
                            .font(.headline)
                            .padding(.bottom, 10)
                        Text(self.textValue)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.bottom, 10)
                    }
                    Spacer()
                }
            }
        }
        .padding(.all, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                .shadow(radius: 1)
        )
    }
}


#if DEBUG
struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: Article(title: "Test", date: "01.04.2020", url: URL(string: "www.google.com")!, image: nil))
    }
}
#endif
