//
//  UICollectionView+.swift
//  DesignKit
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var id: String {
        return String(describing: self)
    }
}

public protocol UICollectionReusableViewProtocol where Self: UICollectionReusableView {
    static var id: String { get }
    
    // UICollectionView.elementKindSectionHeader
    // UICollectionView.elementKindSectionFooter
    static var kind: String { get }
}

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.id)
    }
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.id, for: indexPath) as? T else {
            fatalError("Not Register Cell")
        }
        return cell
    }
    
    func register<T: UICollectionReusableViewProtocol>(_ view: T.Type) {
        register(view, forSupplementaryViewOfKind: view.kind, withReuseIdentifier: view.id)
    }
    
    func dequeue<T: UICollectionReusableViewProtocol>(_ view: T.Type, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: view.kind, withReuseIdentifier: view.id, for: indexPath) as? T else {
            fatalError("Not Register ReusableView")
        }
        return view
    }
    
}
