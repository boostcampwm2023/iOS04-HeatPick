//
//  ImageSelector.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import PhotosUI

protocol ImageSelectorDelegate: AnyObject {
    func imageDidAdd()
    func imageDidRemove(from selector: ImageSelector)
}

protocol ImageSelectorPickerPresenterDelegate: AnyObject {
    func addImageDidTap(with picker: PHPickerViewController)
}

final class ImageSelector: UIView {

    enum Constant {
        static let transparentBlack: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    weak var delegate: ImageSelectorDelegate?
    weak var presenterDelegate: ImageSelectorPickerPresenterDelegate?
    
    var isSelected: Bool {
        imageView.image != nil
    }
    
    var image: Data? {
        imageView.image?.pngData()
    }
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "plus.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .hpBlack
        imageView.addTapGesture(target: self, action: #selector(addImageDidTap))
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var xImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "x.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constant.transparentBlack
        imageView.addTapGesture(target: self, action: #selector(removeImageDidTap))
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

private extension ImageSelector {
    func setupViews() {
        [imageView, plusImageView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupPlusImageView()
        layer.borderColor = UIColor.hpGray4.cgColor
        layer.borderWidth = 1
    }
    
    private func setupPlusImageView() {
        NSLayoutConstraint.activate([
            plusImageView.widthAnchor.constraint(equalToConstant: 25),
            plusImageView.heightAnchor.constraint(equalToConstant: 25),
            plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupXImageView() {
        NSLayoutConstraint.activate([
            xImageView.widthAnchor.constraint(equalToConstant: 14),
            xImageView.heightAnchor.constraint(equalToConstant: 14),
            xImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            xImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    @objc func addImageDidTap() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        presenterDelegate?.addImageDidTap(with: picker)
    }
    
    @objc func removeImageDidTap() {
        delegate?.imageDidRemove(from: self)
    }
}

extension ImageSelector: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else {
            // TODO: Handle empty results or item provider not being able load UIImage
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
            DispatchQueue.main.async { [weak self] in
                guard let image = image as? UIImage, let xImageView = self?.xImageView else { return }
                self?.imageView.image = image
                self?.plusImageView.removeFromSuperview()
                self?.addSubview(xImageView)
                self?.setupXImageView()
                self?.delegate?.imageDidAdd()
            }
        }
    }
    
}
