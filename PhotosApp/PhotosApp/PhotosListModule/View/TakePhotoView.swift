//
//  TakePhotoView.swift
//  PhotosApp
//
//  Created by Григорий Виняр on 24/08/2022.
//

import UIKit

class TakePhotoView: UIView {
  
  // MARK: - Properties
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .secondarySystemBackground
    return imageView
  }()
  
  private let sendButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .blue
    button.layer.cornerRadius = 15
    button.setTitle("Отправить", for: .normal)
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    setupSendButton()
    setupPhotoImageView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  private func setupSendButton() {
    addSubview(sendButton)
    sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
    
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    sendButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
    sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
  }
  
  @objc
  func sendButtonAction() {
    print("Tapped!")
  }
  
  private func setupPhotoImageView() {
    addSubview(photoImageView)
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    photoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
    photoImageView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20).isActive = true
  }
  
}

