//
//  MTAPIClient.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

typealias JSON = [String : Any]

enum Response {
    case success(JSON), badURL(Error), badData(Error), badJSON(Error)
    
    var description: String {
        switch self {
        case .success(let json):
            print(json)
            return "Success"
        default:
            return "ERROR"
        }
    }
}

enum ResponseError: Error {
    case badURL, badData, badJSON
    
    var localizedDescription: String {
        switch self {
        case .badData:
            return "Bad data"
        default:
            return "ERROR"
        }
    }
}

class MTAPIClient {
    
    static func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        MTAPIClient.downloadData(url: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Unable to get specific error")
                completion(nil)
            }
            if let imageData = data {
                completion(UIImage(data: imageData))
            }
        }
    }
    
    static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    static func search(for query: String?, forPage page: String, completion: @escaping (_ response: Response) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        if let encodedQuery = query?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string:"http://www.omdbapi.com/?s=\(encodedQuery)&page=\(page)") {
            let request = URLRequest(url: url)
            session.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.badData(ResponseError.badData))
                }
                let json = convertDataToJSON(data)
                if let returnJSON = json {
                    completion(.success(returnJSON))
                } else {
                    completion(.badJSON(ResponseError.badData))
                }
                }.resume()
        }
    }
    
    static func convertDataToJSON(_ data: Data?) -> JSON? {
        guard let data = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

