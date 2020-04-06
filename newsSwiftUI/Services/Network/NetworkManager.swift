import Foundation
import Alamofire

extension RequestBuilder {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: baseURL.appendingPathComponent(path),
                                        method: method,
                                        headers: headers)
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers
        urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParameters)
        urlRequest.timeoutInterval = 30

        return urlRequest
    }

}

// MARK: - NetworkManager

final class NetworkManager {

    // MARK: - Internal properties

    let sessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(configuration: configuration)

        return manager
    }()

    // MARK: - Static properties

    static let shared = NetworkManager()

    // MARK: - Internal methods

    func request<T: Decodable>(requestBuilder: RequestBuilder,
                               onSuccess: @escaping (T) -> Void,
                               onError: @escaping (Error) -> Void) {
        sessionManager.request(requestBuilder).responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    onSuccess(result)
                } catch let error {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        })
    }

    func cancelRequests() {
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
}
