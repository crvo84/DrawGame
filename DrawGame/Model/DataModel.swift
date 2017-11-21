import Foundation

protocol DataModel: Codable {
    
}

extension DataModel {

    // Returns a 'Result' with a success case with a single DataModel
    static func decodeSingle(fromJson json: Json) -> Self? {
        let decoder = JSONDecoder()

        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            let resultValue = try decoder.decode(Self.self, from: data)
            return resultValue
        } catch {
            print(error)
            return nil
        }
    }
    
    // Returns a 'Result' with a success case with an array of DataModel
    static func decodeMultiple(fromJson json: Json) -> [Self]? {
        let decoder = JSONDecoder()

        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            let resultValues = try decoder.decode([Self].self, from: data)
            return resultValues
        } catch {
            print(error)
            return nil
        }
    }
}

extension ApiEndpoint {
    func getSingle<U: DataModel>(type: U.Type, completion: @escaping (Result<U>) -> ()) {
        executeRequest { result in
            switch result {
            case .success(let json):
                let result = U.decodeSingle(fromJson: json)
                completion(result)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMultiple<U: DataModel>(type: U.Type, completion: @escaping (Result<[U]>) -> ()) {
        executeRequest { result in
            switch result {
            case .success(let json):
                let result = U.decodeMultiple(fromJson: json)
                completion(result)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
