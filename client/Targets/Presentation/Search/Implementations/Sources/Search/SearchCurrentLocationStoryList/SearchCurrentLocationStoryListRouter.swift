//
//  SearchCurrentLocationStoryListRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchCurrentLocationStoryListInteractable: Interactable {
    var router: SearchCurrentLocationStoryListRouting? { get set }
    var listener: SearchCurrentLocationStoryListListener? { get set }
}

protocol SearchCurrentLocationStoryListViewControllable: ViewControllable { }

final class SearchCurrentLocationStoryListRouter: ViewableRouter<SearchCurrentLocationStoryListInteractable, SearchCurrentLocationStoryListViewControllable>, SearchCurrentLocationStoryListRouting {

    override init(interactor: SearchCurrentLocationStoryListInteractable, viewController: SearchCurrentLocationStoryListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
