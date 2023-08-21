//
//  Request.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 6/8/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class Request {
    
    static func makeRequest(endPoint: String, method: HTTPMethod, model: Decodable.Type, onSuccess: @escaping (Decodable) -> Void) {
        guard let url = URL(string: endPoint) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        debugPrint("EndPoint: \(endPoint)")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil, let data = data, !data.isEmpty else {
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    return
                }
                debugPrint("JSON: \(json)")
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let results: Decodable = try decoder.decode(model.self, from: data)
                onSuccess(results)
            } catch let error {
                debugPrint("Error trying to parse: \(error.localizedDescription)")
            }
        }).resume()
    }
}

