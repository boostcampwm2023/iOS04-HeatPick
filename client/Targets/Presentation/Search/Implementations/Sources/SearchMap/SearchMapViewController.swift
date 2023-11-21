//
//  SearchMapViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//


import UIKit

import ModernRIBs
import NMapsMap

protocol SearchMapPresentableListener: AnyObject {
    
}

final class SearchMapViewController: UIViewController, SearchMapPresentable, SearchMapViewControllable {

    weak var listener: SearchMapPresentableListener?
    
    private lazy var naverMap: NMFNaverMapView = {
        let map = NMFNaverMapView(frame: view.frame)
        map.backgroundColor = .hpWhite
        map.showLocationButton = true
        map.mapView.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension SearchMapViewController {

    func setupViews() {
        view = naverMap
    }
    
}
