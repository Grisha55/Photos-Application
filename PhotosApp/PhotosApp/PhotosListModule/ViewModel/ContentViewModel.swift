//
//  ContentViewModel.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import Foundation
import UIKit

protocol ContentViewModelDelegate: AnyObject {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
}

final class ContentViewModel {
  private weak var delegate: ContentViewModelDelegate?
  
  private var contents: [PhotoModel] = []
  private var currentPage = 1
  private var total = 0
  private let name = "Виняр Григорий Антонович"
  
  let client = StackExchangeClient()
  let request: PhotosRequest
  
  init(request: PhotosRequest, delegate: ContentViewModelDelegate) {
    self.request = request
    self.delegate = delegate
  }
  
  var totalCount: Int {
    return total
  }
  
  var currentCount: Int {
    return contents.count
  }
  
  func content(at index: Int) -> PhotoModel {
    return contents[index]
  }
  
  func postContents(content: PhotoModel) {
    client.postPhotos(with: request, content: content)
  }
  
  func fetchContents() {
    client.getPhotos(with: request, page: currentPage) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
        
      case .failure(let error):
        DispatchQueue.main.async {
          self.delegate?.onFetchFailed(with: error.reason)
        }
        
      case .success(let response):
        DispatchQueue.main.async {
          self.currentPage += 1
          self.total = response.totalElements
          self.contents.append(contentsOf: response.content)
          
          if response.page > 1 && response.page <= 7 {
            let indexPathsToReload = self.calculateIndexPathsToReload(from: response.content)
            self.delegate?.onFetchCompleted(with: indexPathsToReload)
          } else {
            self.delegate?.onFetchCompleted(with: .none)
          }
        }
      }
    }
  }
  
  private func calculateIndexPathsToReload(from newContents: [PhotoModel]) -> [IndexPath] {
    let startIndex = contents.count - newContents.count
    let endIndex = startIndex + newContents.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }
  
}
