import SwiftUI
import WebKit

struct WebUIView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel

    init(url: URL) {
        self.viewModel = WebViewModel(url: url)
    }

    func makeUIView(context: UIViewRepresentableContext<WebUIView>) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: viewModel.url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebUIView>) {
        return
    }
}

struct WebUIView_Previews: PreviewProvider {
    static var previews: some View {
        WebUIView(url: URL(string: "www.google.com")!)
    }
}
