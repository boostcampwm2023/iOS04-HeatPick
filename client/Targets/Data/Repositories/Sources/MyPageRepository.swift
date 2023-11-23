//
//  MyPageRepository.swift
//  DataRepositories
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import MyAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class MyPageRepository: MyPageRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func fetchMyPage() async -> Result<MyPage, Error> {
        let target = MyAPI.myProfile
        let request: Result<MyProfileResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
}
