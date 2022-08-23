//
//  PhotosRequest.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import Foundation

struct PhotosRequest {
  var path: String {
    return "api/v2/photo/type"
  }
  
  let parameters: Parameters
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}

extension PhotosRequest {
  static func from() -> PhotosRequest {
    let parameters: [String : String] = [:]
    return PhotosRequest(parameters: parameters)
  }
}
