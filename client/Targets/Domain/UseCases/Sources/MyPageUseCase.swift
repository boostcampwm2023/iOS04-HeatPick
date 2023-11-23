//
//  MyPageUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities
import DomainInterfaces

public final class MyPageUseCase: MyPageUseCaseInterface {
    
    private let repository: MyPageRepositoryInterface
    
    public init(repository: MyPageRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchMyPage() async -> Result<MyPage, Error> {
        await repository.fetchMyPage()
    }
    
}
