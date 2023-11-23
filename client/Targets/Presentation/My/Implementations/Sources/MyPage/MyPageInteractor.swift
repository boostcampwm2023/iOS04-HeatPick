//
//  MyPageInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import CoreKit
import ModernRIBs
import MyInterfaces
import DomainEntities
import DomainInterfaces

protocol MyPageRouting: ViewableRouting {
    func attachUserDashboard()
    func detachUserDashboard()
    func attachStoryDashboard()
    func detachStoryDashboard()
    func attachStorySeeAll()
    func detachStorySeeAll()
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
}

protocol MyPageInteractorDependency: AnyObject {
    var myPageUseCase: MyPageUseCaseInterface { get }
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener {
    
    weak var router: MyPageRouting?
    weak var listener: MyPageListener?
    
    private let depedency: MyPageInteractorDependency
    
    init(
        presenter: MyPagePresentable,
        depedency: MyPageInteractorDependency
    ) {
        self.depedency = depedency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachUserDashboard()
        router?.attachStoryDashboard()
        fetchMyPage()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSetting() {
        print("# Setting 화면으로 이동")
    }
    
    // MARK: - UserDashboard
    
    func userDashboardDidTapProfile() {
        print("# 프로필 변경으로 이동")
    }
    
    // MARK: - StoryDashboard
    
    func storyDashboardDidTapSeeAll() {
        router?.attachStorySeeAll()
    }
    
    // MARK: - StorySeeAll
    
    func myPageStorySeeAllDidTapClose() {
        router?.detachStorySeeAll()
    }
    
    private func fetchMyPage() {
        Task { [weak self] in
            guard let self else { return }
            await depedency.myPageUseCase
                .fetchMyPage()
                .onSuccess(on: .main, with: self) { this, myPage in
                    print("# HI: \(myPage)")
                    // UseCase에서 분배하고 있어서 필요 없음
                }
                .onFailure { error in
                    print("# BYE: \(error)")
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }
    }
    
}
