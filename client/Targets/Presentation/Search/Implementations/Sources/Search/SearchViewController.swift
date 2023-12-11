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
    func didTapSearchTextField()
    func didTapStory(storyId: Int)
    func didAppear()
    func didTapMarker(place: Place)
    func didTapCluster(cluster: Cluster)
    func didTapSymbol(symbol: SearchMapSymbol)
    func didTapLocation(location: SearchMapLocation)
    func mapWillMove()
    func mapDidChangeLocation(location: SearchMapLocation)
    func mapDidChangeLocation(zoomLevel: Double, southWest: SearchMapLocation, northEast: SearchMapLocation)
    func didTapStoryCreate()
    func didTapReSearch()
}

final class SearchViewController: BaseViewController, SearchPresentable, SearchViewControllable {
    
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
    
    private var markerStorage: [MarkerAdaptable] = []
    
    private lazy var naverMap = NMFNaverMapView(frame: view.frame)
    private let searchTextField = SearchTextField()
    private let showSearchHomeListButton = UIButton(configuration: .filled())
    private let storyView = SearchMapStoryView()
    private let selectedMarker = NMFMarker()
    private let selectedView = SearchMapSelectedView()
    private let reSearchView = SearchMapReSearchView()
    private let selectedClusterView = SearchMapClusterListView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.didAppear()
    }
    
    func moveMap(lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        naverMap.mapView.moveCamera(cameraUpdate)
    }
    
    func selectMap(title: String, lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 15.0)
        naverMap.mapView.moveCamera(cameraUpdate)
        listener?.didTapSymbol(symbol: .init(
            title: title,
            lat: lat,
            lng: lng
        ))
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
    
    func updateMarkers(clusters: [Cluster]) {
        clusters.forEach {
            let adapter = MarkerFactory.makeMarkerAdpater(cluster: $0)
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
    
    func updateSelectedMarker(lat: Double, lng: Double) {
        selectedMarker.position = .init(lat: lat, lng: lng)
        selectedMarker.mapView = naverMap.mapView
    }
    
    func hideSelectedMarker() {
        selectedMarker.mapView = nil
    }
    
    func showStoryView(model: SearchMapStoryViewModel) {
        storyView.setup(model: model)
        storyView.isHidden = false
    }
    
    func showClusterListView(models: [SearchMapClusterListCellModel]) {
        selectedClusterView.setup(models: models)
        selectedClusterView.isHidden = false
    }
    
    func showSelectedView(title: String) {
        selectedView.setup(title: title)
        selectedView.isHidden = false
    }
    
    func showReSearchView() {
        reSearchView.isHidden = false
    }
    
    func hideReSearchView() {
        reSearchView.isHidden = true
    }
    
    func deselectAll() {
        hideSelectedMarker()
        selectedView.isHidden = true
        selectedClusterView.isHidden = true
        storyView.isHidden = true
    }
    
    override func setupLayout() {
        view = naverMap
        
        [searchTextField, reSearchView, showSearchHomeListButton, storyView, selectedView, selectedClusterView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.SearchTextField.topSpacing),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            reSearchView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            reSearchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            showSearchHomeListButton.widthAnchor.constraint(equalToConstant: Constant.ShowSearchHomeListButton.length),
            showSearchHomeListButton.heightAnchor.constraint(equalToConstant: Constant.ShowSearchHomeListButton.length),
            showSearchHomeListButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constant.ShowSearchHomeListButton.offset),
            showSearchHomeListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.ShowSearchHomeListButton.offset),
            
            storyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            storyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            storyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            selectedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            selectedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            selectedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            selectedClusterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            selectedClusterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            selectedClusterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            selectedClusterView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    override func setupAttributes() {
        naverMap.do {
            $0.backgroundColor = .hpWhite
            $0.showLocationButton = true
            $0.mapView.addCameraDelegate(delegate: self)
            $0.mapView.touchDelegate = self
            $0.mapView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        searchTextField.do {
            $0.placeholder = Constant.SearchTextField.placeholder
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        showSearchHomeListButton.do {
            $0.configuration?.image = UIImage(systemName: Constant.ShowSearchHomeListButton.image)
            $0.configuration?.baseForegroundColor = .hpBlue1
            $0.configuration?.baseBackgroundColor = .hpWhite
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constant.ShowSearchHomeListButton.length / 2
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        storyView.do {
            $0.delegate = self
            $0.isHidden = true
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
            $0.layer.borderColor = UIColor.hpGray3.cgColor
            $0.layer.borderWidth = 1
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        selectedMarker.do {
            $0.iconImage = NMFOverlayImage(image: .markerBlue)
            $0.zIndex = 1
        }
        
        selectedView.do {
            $0.delegate = self
            $0.isHidden = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        reSearchView.do {
            $0.isHidden = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        selectedClusterView.do {
            $0.isHidden = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        searchTextField
            .tapGesturePublisher
            .withOnly(self)
            .sink { this in
                this.listener?.didTapSearchTextField()
            }
            .store(in: &cancellables)
        
        showSearchHomeListButton
            .tapPublisher
            .withOnly(self)
            .sink { this in
                this.listener?.didTapCurrentLocation()
            }
            .store(in: &cancellables)
        
        reSearchView
            .tapGesturePublisher
            .withOnly(self)
            .sink { this in
                this.listener?.didTapReSearch()
            }
            .store(in: &cancellables)
        
        selectedClusterView
            .buttonTapPublisher
            .withOnly(self)
            .sink { this in
                this.listener?.didTapStoryCreate()
            }
            .store(in: &cancellables)
        
        selectedClusterView
            .itemSelectPublisher
            .with(self)
            .sink { this, model in
                this.listener?.didTapStory(storyId: model.storyId)
            }
            .store(in: &cancellables)
    }
    
}

extension SearchViewController: SearchMapMarkerAdapterDelegate {
    
    func searchMapMarkerDidTap(place: Place) {
        listener?.didTapMarker(place: place)
    }
    
}

extension SearchViewController: SearchMapClusterMarkerAdpaterDelegate {
    
    func searchMapMarkerDidTap(cluster: Cluster) {
        listener?.didTapCluster(cluster: cluster)
    }
    
}

extension SearchViewController: SearchMapSelectedViewDelegate, SearchMapStoryViewDelegate {
    
    func searchMapSelectedViewDidTapCreate(_ view: SearchMapSelectedView) {
        listener?.didTapStoryCreate()
    }
    
    func searchMapStoryViewDidTapCreate(_ view: SearchMapStoryView) {
        listener?.didTapStoryCreate()
    }
    
    func searchMapStoryViewDidTap(_ view: SearchMapStoryView, storyId: Int) {
        listener?.didTapStory(storyId: storyId)
    }
    
}

extension SearchViewController: NMFMapViewCameraDelegate, NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        listener?.mapWillMove()
    }
    
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        listener?.mapDidChangeLocation(location: .init(
            lat: mapView.cameraPosition.target.lat,
            lng: mapView.cameraPosition.target.lng
        ))
        
        listener?.mapDidChangeLocation(
            zoomLevel: mapView.cameraPosition.zoom,
            southWest: .init(
                lat: mapView.coveringBounds.southWestLat,
                lng: mapView.coveringBounds.southWestLng
            ),
            northEast: .init(
                lat: mapView.coveringBounds.northEastLat,
                lng: mapView.coveringBounds.northEastLng
            )
        )
    }
    
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        listener?.didTapSymbol(symbol: .init(
            title: symbol.caption, 
            lat: symbol.position.lat,
            lng: symbol.position.lng
        ))
        return true
    }
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        listener?.didTapLocation(location: .init(lat: latlng.lat, lng: latlng.lng))
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
    
    func makeMarkerAdapter(overlay: NMFOverlayImage, place: Place) -> SearchMapMarkerAdapter {
        let marker = NMFMarker(position: .init(lat: place.lat, lng: place.lng))
        marker.iconImage = overlay
        marker.captionText = place.title
        let adapter = SearchMapMarkerAdapter(marker: marker, place: place)
        return adapter
    }
    
}
