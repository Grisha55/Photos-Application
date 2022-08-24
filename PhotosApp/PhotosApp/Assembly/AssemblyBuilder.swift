//
//  AssemblyBuilder.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 24/08/2022.
//

import UIKit

final class AssemblyBuilder {
  
  static func createPhotosListModule() -> UIViewController {
    let view = ListOfContentVC()
    let photoRequest = PhotosRequest.from()
    let contentViewModel = ContentViewModel(request: photoRequest, delegate: view)
    let stackExchangeClient = StackExchangeClient()
    
    view.contentViewModel = contentViewModel
    contentViewModel.client = stackExchangeClient
    return view
  }
  
}
