//
//  SearchHomeListViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchHomeListPresentableListener: AnyObject {
    
}

final class SearchHomeListViewController: UIViewController, SearchHomeListPresentable, SearchHomeListViewControllable {
    
    weak var listener: SearchHomeListPresentableListener?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupSheet()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSheet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

private extension SearchHomeListViewController {
    func setupSheet() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
        isModalInPresentation = true
    }
    
    func setupViews() {
        view.backgroundColor = .hpGray4
    }
}

extension SearchHomeListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let sheetPresentationController = SearchHomeListSheetPresentationController(presentedViewController: presented, presenting: source)
        sheetPresentationController.detents = [
            .small(),
            .medium(),
            .large(),
        ]
        
        sheetPresentationController.selectedDetentIdentifier = .small
        sheetPresentationController.largestUndimmedDetentIdentifier = .large
        
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        
        return sheetPresentationController
    }
}



