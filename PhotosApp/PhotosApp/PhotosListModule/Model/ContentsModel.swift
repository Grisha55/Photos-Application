//
//  ContentsModel.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import Foundation

struct ContentsModel: Decodable {
  let page: Int
  let pageSize: Int
  let totalPages: Int
  let totalElements: Int
  let content: [PhotoModel]
}

struct PhotoModel: Decodable {
  let id: Int
  let name: String
  let image: String?
}
