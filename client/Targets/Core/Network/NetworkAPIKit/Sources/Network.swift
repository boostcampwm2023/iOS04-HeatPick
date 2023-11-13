//
//  Network.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine

public protocol Network {
    
    func request<T: Target>(_ target: T) -> AnyPublisher<T.Response, Error>
    
}
