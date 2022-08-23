//
//  ListOfContent.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 23/08/2022.
//

import UIKit

class ListOfContentVC: UIViewController {

  // MARK: - Properties
  private let contentTableView: UITableView = {
    let table = UITableView()
    table.showsVerticalScrollIndicator = false
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .yellow
    
    setupNavigationBar()
    setupContentTableView()
  }

  // MARK: - Methods
  private func setupContentTableView() {
    view.addSubview(contentTableView)
    contentTableView.dataSource = self
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

// MARK: - UITableViewDelegate
extension ListOfContentVC: UITableViewDelegate {
  
}

// MARK: - UITableViewDataSource
extension ListOfContentVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}
