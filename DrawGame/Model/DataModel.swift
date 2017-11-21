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
    
    // Returns a 'Result' with a success case with a Json from DataModel
    func encodeSingle() -> Json? {
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(self)
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? Json
                else { return nil }
            return json
            
        } catch {
            print(error)
            return nil
        }
    }
}

extension ApiEndpoint {
    func getSingle<U: DataModel>(type: U.Type, completion: @escaping (U?) -> ()) {
        executeRequest { json in
            guard let json = json else {
                completion(nil)
                return
            }
            
            completion(U.decodeSingle(fromJson: json))
        }
    }
    
    func getMultiple<U: DataModel>(type: U.Type, completion: @escaping ([U]?) -> ()) {
        executeRequest { json in
            guard let json = json else {
                completion(nil)
                return
            }

            completion(U.decodeMultiple(fromJson: json))
        }
    }
}
