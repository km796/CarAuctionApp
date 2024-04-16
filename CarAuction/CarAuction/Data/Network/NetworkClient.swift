//
//  Network.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/12/24.
//

import Foundation

class NetworkClient {
    static let shared = NetworkClient()
    private init() { }
    
    func request<T: Decodable>(urlString: String, modelType: T.Type) async -> T? {
        print(urlString)
        return await withCheckedContinuation { continuation in
            guard let url = URL(string: convertToHTTPS(urlString: urlString)) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error {
                    print(error)
                }
                if let data {
                    do {
                        let dto = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: dto)
                    } catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func request<T: Decodable>(url: URL, modelType: T.Type) async -> T? {
        print(url.absoluteString)
        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error {
                    print(error)
                }
                if let data {
                    do {
                        let dto = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: dto)
                    } catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func convertToHTTPS(urlString: String) -> String {
        if var urlComponents = URLComponents(string: urlString) {
            if urlComponents.scheme == "http" {
                urlComponents.scheme = "https"
                if let httpsURL = urlComponents.url?.absoluteString {
                    return httpsURL
                }
            }
        }
        return urlString
    }
}
