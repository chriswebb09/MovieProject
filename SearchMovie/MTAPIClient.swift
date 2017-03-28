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
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        MTAPIClient.downloadData(url: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Unable to get specific error")
                completion(nil)
                return
            }
            if let imageData = data {
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: imageData) {
                        imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                        completion(downloadedImage)
                        return
                    }
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
                    print("error \(error)")
                    completion(nil, error)
                    return
                }
                let data = convertDataToJSON(data)
                guard data != nil else {
                    completion(nil, nil)
                    return
                }
                if let json = data {
                    completion(json, nil)
                    return
                }
            }
        }
    }
    
    static func convertDataToJSON(_ data: Data?) -> JSON? {
        guard let data = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            print("JSON Error \(error.localizedDescription)")
            return nil
        }
    }
}

