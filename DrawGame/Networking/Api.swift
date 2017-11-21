import UIKit

struct Api {
    
    static let udid = UIDevice.current.identifierForVendor!.uuidString
    
    // MARK: - GAME
    enum Games: ApiEndpoint {
        case getAll

        var request: ApiRequest {
            switch self {
            case .getAll:
//                return ApiRequest.i
            }
        }
    }
}
