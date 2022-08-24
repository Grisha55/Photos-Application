//
//  StackExchangeClient.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import UIKit

protocol StackExchangeClientProtocol: AnyObject {
  func getPhotos(with request: PhotosRequest, page: Int, completion: @escaping (Result<ContentsModel , DataResponseError>) -> Void)
  func postPhotos(with request: PhotosRequest, name: String, id: Int, image: UIImage)
}

final class StackExchangeClient: StackExchangeClientProtocol {
  private lazy var baseURL: URL = {
    return URL(string: "https://junior.balinasoft.com//")!
  }()
  
  let session: URLSession
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func postPhotos(with request: PhotosRequest, name: String, id: Int, image: UIImage) {
    
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.pathForPost))
    
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: AnyHashable] = [
      "name"   : name,
      "photo"  : image,
      "typeId" : id
    ]
    
    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = session.dataTask(with: urlRequest) { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.hasSuccessStatusCode,
        let data = data
      else {
        return
      }
      
      do {
        let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        print("SUCCESS: \(response)")
      }
      catch {
        print(error.localizedDescription)
      }
    }
    task.resume()
  }
  
  func getPhotos(with request: PhotosRequest, page: Int, completion: @escaping (Result<ContentsModel, DataResponseError>) -> Void) {
    
    let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.pathForGet))
    
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
      
      guard let decodedResponse = try? JSONDecoder().decode(ContentsModel.self, from: data) else {
        completion(Result.failure(DataResponseError.decoding))
        return
      }
      
      completion(Result.success(decodedResponse))
    }.resume()
  }
}
