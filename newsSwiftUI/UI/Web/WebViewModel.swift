import WebKit
import Combine

class WebViewModel: ObservableObject {
    @Published var url: URL

    init(url: URL) {
        self.url = url
    }
}
