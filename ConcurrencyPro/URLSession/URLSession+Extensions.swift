//
//  URLSessionable.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 4/27/22.
//

import Foundation

protocol URLSessionable {
    func dataTaskWithURL(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskable
}

protocol URLSessionDataTaskable {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskable {}

extension URLSession: URLSessionable {
    func dataTaskWithURL(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskable {
        dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTaskable
    }
}
