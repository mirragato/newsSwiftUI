import Foundation

// MARK: - RequestBuilder

protocol RequestBuilder {
    var path: String { get }
    var baseURL: URL { get }
    var headers: [String: String]? { get }
    var queryParameters: [URLQueryItem]? { get }
    var request: URLRequest? { get }
}

// MARK: - extension BackendRequestBuilder

extension RequestBuilder {
    var baseURL: URL { return URL(string: "https://newsapi.org")! }
    var headers: [String: String]? { return nil }
    var queryParameters: [URLQueryItem]? { return nil }
    var path: String { return "" }
    var request: URLRequest? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { return nil }
        components.path = path
        components.queryItems = queryParameters
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30)
        headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }
}
