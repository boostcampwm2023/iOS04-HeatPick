//
//  AnyCancellableTask.swift
//  CoreKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol AnyCancellableTask {
    func cancel()
}

extension Task: AnyCancellableTask {}
