import SwiftUI
import Combine
import Foundation

struct URLImage: View {
    @ObservedObject private var remoteImage: RemoteImage
    
    init(stringForURL: String?) {
        remoteImage = RemoteImage(url: URL(string: stringForURL ?? ""))
    }

    private var image: some View {
        GeometryReader { _ in
            Image(uiImage: self.remoteImage.image ?? #imageLiteral(resourceName: "default"))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .blue, radius: 1, x: 0, y: 0)
                .aspectRatio(4/3, contentMode: .fit)
        }
    }

    var body: some View {
        image.onAppear(perform: remoteImage.load)
    }
}

class RemoteImage: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?

    init(url: URL?) {
        self.url = url
    }
    
    deinit {
        cancellable?.cancel()
    }

    func load() {
        guard let url = url else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: #imageLiteral(resourceName: "default"))
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(stringForURL: nil)
    }
}
