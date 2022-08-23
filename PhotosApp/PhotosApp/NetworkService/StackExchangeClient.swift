//
//  StackExchangeClient.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import Foundation

protocol StackExchangeClientProtocol: AnyObject {
  func getPhotos(with request: PhotosRequest, page: Int, completion: @escaping (Result<String , DataResponseError>) -> Void)
}

final class StackExchangeClient: StackExchangeClientProtocol {
  private lazy var baseURL: URL = {
    return URL(string: "https://junior.balinasoft.com//")!
  }()
  
  let session: URLSession
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func getPhotos(with request: PhotosRequest, page: Int, completion: @escaping (Result<String, DataResponseError>) -> Void) {
    
    let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
    
    let parameters = ["page" : "\(page)"]
    
    let encodedURLRequest = urlRequest.encode(with: parameters)
    
    session.dataTask(with: encodedURLRequest) { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.hasSuccessStatusCode,
        let data = data
      else {
        completion(Result.failure(DataResponseError.network))
        return
      }
      
      guard let decodedResponse = try? JSONDecoder().decode(String.self, from: data) else {
        completion(Result.failure(DataResponseError.decoding))
        return
      }
      
      completion(Result.success(decodedResponse))
    }.resume()
  }
}
