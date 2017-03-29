//
//  MTAPIClient.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

typealias JSON = [String : Any]
fileprivate let imageCache = NSCache<NSString, UIImage>()

class MTAPIClient {
    
    //MARK: - Public
    
    static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            MTAPIClient.downloadData(url: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, NSError.generalParsingError(domain: url.absoluteString))
                }
            }
        }
    }
    
    static func search(for query: String, page: Int, completion: @escaping (_ responseObject: JSON?, _ error: Error?) -> Void) {
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string:"http://www.omdbapi.com/?s=\(encodedQuery)&page=\(page)") {
            MTAPIClient.downloadData(url: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    if let data = data, let responseObject = self.convertToJSON(with: data) {
                        completion(responseObject, nil)
                    } else {
                        completion(nil, NSError.generalParsingError(domain: url.absoluteString))
                    }
                }
            }
        }
    }
    
    //MARK: - Private

    fileprivate static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    fileprivate static func convertToJSON(with data: Data) -> JSON? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            return nil
        }
    }
}
