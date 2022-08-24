//
//  ListOfContent.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import UIKit

class ListOfContentVC: UIViewController {

  // MARK: - Properties
  var contentViewModel: ContentViewModel!
  
  private let contentTableView: UITableView = {
    let table = UITableView()
    table.showsVerticalScrollIndicator = false
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .yellow
    let request = PhotosRequest.from()
    contentViewModel = ContentViewModel(request: request, delegate: self)
    
    setupNavigationBar()
    setupContentTableView()
    
    contentViewModel.fetchContents()
  }

  // MARK: - Methods
  private func setupContentTableView() {
    view.addSubview(contentTableView)
    contentTableView.dataSource = self
    contentTableView.prefetchDataSource = self
    contentTableView.delegate = self
    
    contentTableView.translatesAutoresizingMaskIntoConstraints = false
    contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    contentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Фото контент"
  }

}

// MARK: - UITableViewDataSourcePrefetching
extension ListOfContentVC: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      contentViewModel.fetchContents()
    }
  }
}


extension ListOfContentVC: ContentViewModelDelegate {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    guard let newIndexPathsToReload = newIndexPathsToReload else {
      contentTableView.reloadData()
      return
    }
    
    let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
    contentTableView.reloadRows(at: indexPathsToReload, with: .automatic)
  }
  
  func onFetchFailed(with reason: String) {
    // TODO: - Сделать UIAlertController
  }
}

// MARK: - UITableViewDelegate
extension ListOfContentVC: UITableViewDelegate {
  
}

// MARK: - UITableViewDataSource
extension ListOfContentVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentViewModel.totalCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    if isLoadingCell(for: indexPath) {
      
    } else {
      cell.textLabel?.text = contentViewModel.content(at: indexPath.row).name
    }
    return cell
  }
}

private extension ListOfContentVC {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= contentViewModel.currentCount
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = contentTableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
