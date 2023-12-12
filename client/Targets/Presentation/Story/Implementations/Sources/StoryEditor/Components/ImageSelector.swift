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
    func imageDidFailToLoad()
    func imageDidRemove(from selector: ImageSelector)
}

protocol ImageSelectorPickerPresenterDelegate: AnyObject {
    func addImageDidTap(with picker: PHPickerViewController)
}

final class ImageSelector: UIView {
    
    enum Constant {
        static let transparentBlack: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        static let buttonWidthHeight: CGFloat = 44
    }
    weak var delegate: ImageSelectorDelegate?
    weak var presenterDelegate: ImageSelectorPickerPresenterDelegate?
    
    private var isLoading = false
    
    var isSelected: Bool {
        imageView.image != nil
    }
    
    var image: Data? {
        imageView.image?.jpegData(compressionQuality: 0.3)
    }
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "plus.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .hpBlack
        imageView.addTapGesture(target: self, action: #selector(addImageDidTap))
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
        imageView.contentMode = .scaleAspectFill
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
            plusImageView.widthAnchor.constraint(equalToConstant: Constant.buttonWidthHeight),
            plusImageView.heightAnchor.constraint(equalToConstant: Constant.buttonWidthHeight),
            plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupXImageView() {
        xImageView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            xImageView.widthAnchor.constraint(equalToConstant: Constant.buttonWidthHeight),
            xImageView.heightAnchor.constraint(equalToConstant: Constant.buttonWidthHeight),
            xImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            xImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

private extension ImageSelector {
    
    @objc func addImageDidTap() {
        guard !isLoading else { return }
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        presenterDelegate?.addImageDidTap(with: picker)
    }
    
    @objc func removeImageDidTap() {
        xImageView.isUserInteractionEnabled = false
        delegate?.imageDidRemove(from: self)
    }
    
    func changeToRemoveButton() {
        plusImageView.removeFromSuperview()
        addSubview(xImageView)
        setupXImageView()
        delegate?.imageDidAdd()
    }
}

extension ImageSelector: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        isLoading = true
        
        guard let itemProvider = results.first?.itemProvider else {
            isLoading = false
            return
        }
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            loadUIImage(itemProvider)
        } else if itemProvider.canLoadObject(ofClass: PHLivePhoto.self) {
            loadLivePhoto(itemProvider)
        } else {
            delegate?.imageDidFailToLoad()
            isLoading = false
        }
    }
    
    private func loadUIImage(_ itemProvider: NSItemProvider) {
        itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
            DispatchQueue.main.async { [weak self] in
                guard let image = image as? UIImage, let self else {
                    self?.delegate?.imageDidFailToLoad()
                    self?.isLoading = false
                    return
                }
                imageView.image = image
                isLoading = false
                changeToRemoveButton()
            }
        }
    }
    
    private func loadLivePhoto(_ itemProvider: NSItemProvider) {
        itemProvider.loadObject(ofClass: PHLivePhoto.self) { [weak self] livePhoto, _ in
            guard let livePhoto = livePhoto as? PHLivePhoto,
                  let photo = PHAssetResource.assetResources(for: livePhoto).first(where: { $0.type == .photo })
            else {
                self?.delegate?.imageDidFailToLoad()
                self?.isLoading = false
                return
            }
            
            let imageData = NSMutableData()
            PHAssetResourceManager.default().requestData(
                for: photo,
                options: nil,
                dataReceivedHandler: { _ in },
                completionHandler: { _ in
                    DispatchQueue.main.async { [weak self] in
                        guard let self else {
                            self?.delegate?.imageDidFailToLoad()
                            self?.isLoading = false
                            return
                        }
                        imageView.image = UIImage(data: imageData as Data)
                        isLoading = false
                        changeToRemoveButton()
                    }
                }
            )
        }
    }
    
}
