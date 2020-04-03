import Foundation
import Alamofire

// MARK: - RequestBuilder

protocol RequestBuilder: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseURL: URL { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryParameters: [String: Any]? { get }
}

// MARK: - extension BackendRequestBuilder

extension RequestBuilder {
    var method: HTTPMethod {
        return .get
    }

    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }

    var headers: [String: String]? {
        return nil
    }

    var body: Data? {
        return nil
    }

    var queryParameters: [String: Any]? {
        return nil
    }

    var path: String {
        return ""
    }
}
