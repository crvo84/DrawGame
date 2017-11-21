import Foundation
import Alamofire

struct ApiConstants {
    struct Url {
        static let scheme = "http"
        static let host = ""//"-api-api-cojcvwx-1471092146.us-west-2.elb.amazonaws.com"
        static let basePath = ""
    }
}

enum ApiRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case path = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

enum ApiRequestHeaderField: String {
    case contentType = "Content-Type"
    case contentLength = "Content-Length"
}

/// Initialized with the required information from creating a URLRequest.
struct ApiRequest: URLRequestConvertible {
    
    var method: ApiRequestMethod
    var path: String
    var headers: [String: String]
    var URLParams: [String: AnyObject]?
    var bodyParams: [String: AnyObject]?
    var contentType = "application/json"
    
    init(method: ApiRequestMethod,
         path: String,
         headers: [String: String] = [:],
         bodyParams: [String: AnyObject]? = nil,
         fileParams: [String: ApiRequestFileParam]? = nil,
         URLParams: [String: AnyObject]? = nil) {
        self.method = method
        self.path = path
        self.headers = headers
        self.URLParams = URLParams
        self.bodyParams = bodyParams
        self.fileParams = fileParams
    }
    
    func asURLRequest() throws -> URLRequest {
        var URLComponents = Foundation.URLComponents()
        URLComponents.scheme = ApiConstants.Url.scheme
        URLComponents.host = ApiConstants.Url.host
        URLComponents.path = ApiConstants.Url.basePath
        
        /* Endpoint path */
        let url = URLComponents.url!.appendingPathComponent(path)
        
        /* Url params */
        let urlWithParams = Alamofire.request(url.absoluteString, parameters: URLParams).request!.url!
        let r = NSMutableURLRequest(url: urlWithParams)
        
        /* Method */
        r.httpMethod = method.rawValue
        
        #if DEBUG
            print("--REQUEST URL-->\(url), METHOD-->\(r.httpMethod)") // TODO: remove
            print("--REQUEST BODY-->\(String(describing: bodyParams))") // TODO: remove
            print("--REQUEST URL Encoded-->\(r)") // TODO: remove
        #endif
        
        /* Body */
        guard let bodyParams = self.bodyParams, bodyParams.count > 0 else { break }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: bodyParams, options: JSONSerialization.WritingOptions(rawValue: 0))
            r.httpBody = jsonData
            r.setValue(contentType.rawValue,
                       forHTTPHeaderField: ApiRequestHeaderField.contentType.rawValue)
        } catch {
            print(error)
        }
        
        if let bodyCount = r.httpBody?.count {
            r.setValue("\(bodyCount)",
                forHTTPHeaderField: ApiRequestHeaderField.contentLength.rawValue)
        }
        
        /* Headers */
        for (key, value) in self.headers {
            r.setValue(value, forHTTPHeaderField: key)
        }
        
        return r as URLRequest
    }
}
