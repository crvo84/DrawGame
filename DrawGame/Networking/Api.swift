import UIKit

struct Api {
    
    static let udid = UIDevice.current.identifierForVendor!.uuidString
    
    // MARK: - GAME
    enum Games: ApiEndpoint {
        case create(word: String, drawing: Drawing)
        case getAll
        case getAvailable

        var request: ApiRequest {
            switch self {
                
            case .create(let word, let drawing):
                var bodyParams = [String : AnyObject]()
                bodyParams["userId"] = udid as AnyObject
                bodyParams["word"] = word as AnyObject
                if let drawing = drawing.encodeSingle() {
                    bodyParams["drawing"] = drawing as AnyObject
                }
                return ApiRequest(method: .post, path: "/games",
                                  bodyParams: bodyParams)
                
            case .getAll:
                return ApiRequest(method: .get, path: "/games",
                                  URLParams: ["userId": udid as AnyObject])
                
            case .getAvailable:
                var bodyParams = [String : AnyObject]()
                bodyParams["userId"] = udid as AnyObject
                
                return ApiRequest(method: .get, path: "/games")
            }
        }
    }
    
    
}
