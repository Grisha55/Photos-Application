//
//  URLRequest.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import Foundation

typealias Parameters = [String : String]

extension URLRequest {
  func encode(with parameters: Parameters?) -> URLRequest {
    guard let parameters = parameters else {
      return self
    }

    var encodedURLRequest = self
    
    if let url = self.url,
       let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
       !parameters.isEmpty {
      var newURLComponents = urlComponents
      let queryItems = parameters.map { key, value in
        URLQueryItem(name: key, value: value)
      }
      newURLComponents.queryItems  = queryItems
      encodedURLRequest.url = newURLComponents.url
      return encodedURLRequest
    } else {
      return self
    }
  }
}
