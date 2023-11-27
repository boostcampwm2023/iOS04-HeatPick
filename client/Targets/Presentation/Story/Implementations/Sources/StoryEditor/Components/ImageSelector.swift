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
        static let buttonWidthHeight: CGFloat = 44
    }
    weak var delegate: ImageSelectorDelegate?
    weak var presenterDelegate: ImageSelectorPickerPresenterDelegate?
    
    var isSelected: Bool {
        imageView.image != nil
    }
    
    var image: Data? {
        imageView.image?.jpegData(compressionQuality: 1.0)
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
            plusImageView.widthAnchor.constraint(equalToConstant: Constant.buttonWidthHeight),
            plusImageView.heightAnchor.constraint(equalToConstant: Constant.buttonWidthHeight),
            plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupXImageView() {
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
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        presenterDelegate?.addImageDidTap(with: picker)
    }
    
    @objc func removeImageDidTap() {
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
        
        if let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async { [weak self] in
                    guard let image = image as? UIImage, let self else { return }
                    imageView.image = image
                    changeToRemoveButton()
                }
            }
            return
        }
        
        if let livePhotoProgress = results.first?.itemProvider, livePhotoProgress.canLoadObject(ofClass: PHLivePhoto.self) {
            livePhotoProgress.loadObject(ofClass: PHLivePhoto.self) { livePhoto, _ in
                guard let livePhoto = livePhoto as? PHLivePhoto,
                      let photo = PHAssetResource.assetResources(for: livePhoto).first(where: { $0.type == .photo }) else { return }
                
                let imageData = NSMutableData()
                PHAssetResourceManager.default().requestData(for: photo, options: nil, dataReceivedHandler: { data in
                    imageData.append(data)
                }, completionHandler: { error in
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        imageView.image = UIImage(data: imageData as Data)
                        changeToRemoveButton()
                    }
                })
            }
        }
        
    }
    
}
