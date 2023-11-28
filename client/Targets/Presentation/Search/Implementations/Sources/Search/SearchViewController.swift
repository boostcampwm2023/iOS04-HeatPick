//
//  SearchViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import CoreKit
import DesignKit
import DomainEntities
import BasePresentation

import NMapsMap
import ModernRIBs

protocol SearchPresentableListener: AnyObject {
    func didTapCurrentLocation()
    func didTapSearch()
    func didTapStory(storyID: Int)
    func didAppear()
    func didTapMarker(place: Place)
    func mapWillMove()
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    
    private enum Constant {
        enum TabBar {
            static let title = "검색"
            static let image = "magnifyingglass"
        }
        
        enum SearchTextField {
            static let placeholder = "위치, 장소 검색"
            static let topSpacing: CGFloat = 20
        }
        
        enum ShowSearchHomeListButton {
            static let image = "chevron.up"
            static let length: CGFloat = 45
            static let offset: CGFloat = -25
        }
    }
    
    weak var listener: SearchPresentableListener?

    private var markerStorage: [SearchMapMarkerAdapter] = []
    
    private lazy var naverMap: NMFNaverMapView = {
        let map = NMFNaverMapView(frame: view.frame)
        map.backgroundColor = .hpWhite
        map.showLocationButton = true
        map.mapView.addCameraDelegate(delegate: self)
        map.mapView.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchTextFieldDidTap))
        textField.addGestureRecognizer(tapGesture)
        
        textField.placeholder = Constant.SearchTextField.placeholder
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var showSearchHomeListButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.image = UIImage(systemName: Constant.ShowSearchHomeListButton.image)
        button.configuration?.baseForegroundColor = .hpBlue1
        button.configuration?.baseBackgroundColor = .hpWhite
        button.clipsToBounds = true
        button.layer.cornerRadius = Constant.ShowSearchHomeListButton.length / 2
        
        button.addTarget(self, action: #selector(showSearchHomeListButtonDidTap), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var storyView: SearchMapStoryView = {
        let storyView = SearchMapStoryView()
        storyView.isHidden = true
        storyView.layer.cornerRadius = Constants.cornerRadiusMedium
        storyView.layer.borderColor = UIColor.hpGray3.cgColor
        storyView.layer.borderWidth = 1
        storyView.translatesAutoresizingMaskIntoConstraints = false
        storyView.addTapGesture(target: self, action: #selector(storyViewDidTap))
        return storyView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.didAppear()
    }
    
    func moveMap(lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        naverMap.mapView.moveCamera(cameraUpdate)
    }
    
    func updateMarkers(places: [Place]) {
        let overlay = NMFOverlayImage(image: .marker)
        
        places.forEach {
            let adapter = makeMarkerAdapter(overlay: overlay, place: $0)
            adapter.marker.mapView = naverMap.mapView
            adapter.delegate = self
            markerStorage.append(adapter)
        }
    }
    
    func removeAllMarker() {
        markerStorage.forEach {
            $0.clear()
        }
        markerStorage.removeAll()
    }
    
    func showStoryView(model: SearchMapStoryViewModel) {
        storyView.setup(model: model)
        storyView.isHidden = false
    }
    
    func hideStoryView() {
        guard storyView.isHidden == false else { return }
        storyView.isHidden = true
    }
    
}

extension SearchViewController: SearchMapMarkerAdapterDelegate {
    
    func searchMapMarkerDidTap(place: Place) {
        listener?.didTapMarker(place: place)
    }
    
}

extension SearchViewController: NMFMapViewCameraDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        listener?.mapWillMove()
    }
    
}

private extension SearchViewController {
    
    @objc func storyViewDidTap() {
        guard let storyID = storyView.storyID else { return }
        listener?.didTapStory(storyID: storyID)
    }
    
}

private extension SearchViewController {
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.TabBar.title,
            image: .init(systemName: Constant.TabBar.image)?.withRenderingMode(.alwaysTemplate),
            selectedImage: .init(systemName: Constant.TabBar.image)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
    func setupViews() {
        view = naverMap
        [searchTextField, showSearchHomeListButton, storyView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.SearchTextField.topSpacing),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            showSearchHomeListButton.widthAnchor.constraint(equalToConstant: Constant.ShowSearchHomeListButton.length),
            showSearchHomeListButton.heightAnchor.constraint(equalToConstant: Constant.ShowSearchHomeListButton.length),
            showSearchHomeListButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constant.ShowSearchHomeListButton.offset),
            showSearchHomeListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.ShowSearchHomeListButton.offset),
            
            storyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            storyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            storyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func makeMarkerAdapter(overlay: NMFOverlayImage, place: Place) -> SearchMapMarkerAdapter {
        let marker = NMFMarker(position: .init(lat: place.lat, lng: place.lng))
        marker.iconImage = overlay
        marker.captionText = place.title
        let adapter = SearchMapMarkerAdapter(marker: marker, place: place)
        return adapter
    }
    
}

private extension SearchViewController {
    
    @objc func searchTextFieldDidTap() {
        listener?.didTapSearch()
    }
    
    @objc func showSearchHomeListButtonDidTap() {
        listener?.didTapCurrentLocation()
    }
    
}
