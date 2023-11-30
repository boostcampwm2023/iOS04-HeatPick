//
//  HomeFollowRequestDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

struct HomeFollowRequestDTO: Encodable {
    let offset: Int
    let limit: Int
    let sortOption: Int
}
