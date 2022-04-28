//
//  ImageProcessor.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 4/27/22.
//

import UIKit

protocol ImageProcessable {
    func downloadImages(_ completion: @escaping (([UIImage]) -> Void))
}

final class ImageProcessor: ImageProcessable {
    
    private let urlSession: URLSessionable
    private let urls: [String]
    private let imageCache = NSCache<NSString, UIImage>()

    init(
        urlSession: any URLSessionable = URLSession.shared,
        urls: [String]
    ) {
        self.urlSession = urlSession
        self.urls = urls
    }
        
    func downloadImages(_ completion: @escaping (([UIImage]) -> Void)) {
        
        let group = DispatchGroup()
        var images: [UIImage] = []
        
        for imageURL in self.urls {
            if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
                images.append(cachedImage)
            } else {
                guard let url = URL(string: imageURL) else { continue }
                
                group.enter()
                let task = urlSession.dataTaskWithURL(url) { [weak self] (data, response, error) in
                    defer {
                        group.leave()
                    }
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }
                    
                    self?.imageCache.setObject(image, forKey: imageURL as NSString)
                    images.append(image)
                }
    
                task.resume()
            }
        }
    
        group.notify(queue: .global(qos: .utility)) {
             completion(images)
        }
    }
}
