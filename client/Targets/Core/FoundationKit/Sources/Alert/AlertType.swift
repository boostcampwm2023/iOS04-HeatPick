//
//  AlertType.swift
//  FoundationKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum AlertType {
    
    case invalidToken
    case signOut
    case resign
    
}

extension AlertType {
    
    public var title: String {
        switch self {
        case .invalidToken: return "올바르지 않은 회원 정보"
        case .signOut: return "로그아웃"
        case .resign: return "회원 탈퇴"
        }
    }
    
    public var message: String {
        switch self {
        case .invalidToken: return "회원 정보가 올바르지 않아요. 확인 버튼을 누르면 로그인 화면으로 이동해요"
        case .signOut: return "로그아웃을 하게 되면 로그인 화면으로 이동해요"
        case .resign: return "탈퇴하시면 기존의 정보는 모두 제거돼요. 정말 탈퇴 하실건가요?"
        }
    }
    
    public var isCancellable: Bool {
        switch self {
        case .invalidToken: return false
        case .signOut: return true
        case .resign: return true
        }
    }
    
}
