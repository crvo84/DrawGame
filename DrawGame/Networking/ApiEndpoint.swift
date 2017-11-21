import Foundation
import Alamofire

typealias Json = [AnyHashable: Any]

protocol ApiEndpoint {
    var request: ApiRequest { get }
    func executeRequest(completion: @escaping (Json?) -> ())
}

extension ApiEndpoint {
    
    func executeRequest(completion: @escaping (Json?) -> ()) {
        let request = self.request

        SessionManager.default.request(request)
            .validate(statusCode: 200...226)
            .validate(contentType: ["application/json", "text/plain", "text/json", "application/vnd.api+json"])
            .response(queue: DispatchQueue.main) { defaultDataResponse in

//                let request = defaultDataResponse.request
//                let response = defaultDataResponse.response
                let responseData = defaultDataResponse.data
                let responseError = defaultDataResponse.error
                
                // if the response contains an error (e.g. invalid status code, no network connection, etc)
                // or if responseData cannot be converted to 'Json', return nil
                let options = JSONSerialization.ReadingOptions()
                guard
                    let data = responseData, responseError == nil,
                    let json = (try? JSONSerialization.jsonObject(with: data, options: options)) as? Json
                    else {
                        completion(nil)
                        return
                    }

                print("--JSON RESPONSE-->\(json)")

                completion(json)
        }
    }
}
