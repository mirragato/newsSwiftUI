import Foundation
import Combine

// MARK: - NetworkManager

final class NetworkManager<Request: RequestBuilder> {

    // MARK: - Internal methods

    func request(requestBuilder: Request) -> AnyPublisher<Data, Error> {
        guard let request = requestBuilder.request else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : String.errorWrong])
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError{ $0 }
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
