//
//  Result+Scheduler.swift
//  CoreKit
//
//  Created by 홍성준 on 11/19/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum ResultScheduler {
    
    case main
    case global
    case current
    
    func exeucte(_ handler: @escaping () -> Void) {
        switch self {
        case .main:
            DispatchQueue.main.async {
                handler()
            }
            
        case .global:
            DispatchQueue.global().async {
                handler()
            }
            
        case .current:
            handler()
        }
    }
    
}

public extension Result {
    
    @discardableResult
    func onSuccess(
        on scheduler: ResultScheduler = .current,
        _ execute: @escaping (Success) -> Void
    ) -> Self {
        switch self {
        case .success(let value):
            scheduler.exeucte {
                execute(value)
            }
            return self
            
        default:
            return self
        }
    }
    
    @discardableResult
    func onSuccess<T: AnyObject>(
        on scheduler: ResultScheduler = .current,
        with unretainObject: T,
        _ execute: @escaping (T, Success) -> Void
    ) -> Self {
        switch self {
        case .success(let value):
            scheduler.exeucte { [weak unretainObject] in
                guard let object = unretainObject else { return }
                execute(object, value)
            }
            return self
            
        default:
            return self
        }
    }
    
    @discardableResult
    func onFailure(
        on scheduler: ResultScheduler = .current,
        _ execute: @escaping (Failure) -> Void
    ) -> Self {
        switch self {
        case .failure(let error):
            scheduler.exeucte {
                execute(error)
            }
            return self
            
        default:
            return self
        }
    }
    
    @discardableResult
    func onFailure<T: AnyObject>(
        on scheduler: ResultScheduler = .current,
        with unretainObject: T,
        _ execute: @escaping (T, Failure) -> Void
    ) -> Self {
        switch self {
        case .failure(let error):
            scheduler.exeucte { [weak unretainObject] in
                guard let object = unretainObject else { return }
                execute(object, error)
            }
            return self
            
        default:
            return self
        }
    }
    
}
