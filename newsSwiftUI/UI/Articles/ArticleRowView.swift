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
        VStack {
            VStack(alignment: .center) {
                URLImage(stringForURL: self.article.image)
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text(self.article.title)
                        .font(.headline)
                        .padding([.top, .bottom], 10)
                    Text(self.textValue)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxHeight: 400, alignment: .top)
    }
}

#if DEBUG
struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: Article(title: "Test", date: "01.04.2020", url: URL(string: "www.google.com")!, image: nil))
    }
}
#endif
