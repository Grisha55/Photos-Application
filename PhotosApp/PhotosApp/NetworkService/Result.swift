//
//  Result.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import Foundation

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
