//
//  MTAPIClient.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

typealias JSON = [String : Any]
let imageCache = NSCache<NSString, UIImage>()

class MTAPIClient {
    
    static func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        print(url)
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        }
        MTAPIClient.downloadData(url: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Unable to get specific error")
                completion(nil)
            }
            if let imageData = data {
                DispatchQueue.main.async {
                    let downloadedImage = UIImage(data: imageData)
                    if let downloadedImage = downloadedImage {
                        imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                    }
                    completion(UIImage(data: imageData))
                }
            }
        }
    }
    
    static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { data, response, error in
            print("Data: \(data)")
            print("Response: \(response)")
            print("Error: \(error?.localizedDescription)")
            print("URL: \(url.absoluteString)")
            completion(data, response, error)
            }.resume()
    }
    
    static func search(for query: String?, page: String, completion: @escaping (_ responseObject: [String : Any]?, _ error: Error?) -> Void) {
        if let encodedQuery = query?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string:"http://www.omdbapi.com/?s=\(encodedQuery)&page=\(page)") {
            MTAPIClient.downloadData(url: url) { data, response, error in
                if error != nil {
                    completion(nil, error)
                }
                let json = convertDataToJSON(data)
                if let returnJSON = json {
                    completion(returnJSON, nil)
                }
            }
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

