//
//  UIImage+extension.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 24/08/2022.
//

import UIKit

extension UIImage {
  func toPngString() -> String? {
    let data = self.pngData()
    return data?.base64EncodedString(options: .lineLength64Characters)
  }
}
