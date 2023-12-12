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
    case completeResign
    case didFailResign
    case didFailToLoadAddress
    case didFailToLoadMetadataForEditor
    case didFailToSaveStory
    case didFailToLoadStoryDetail
    case didFailToDeleteStory
    case didFailToFollow
    case didFailToLike
    case didFailToLoadComments
    case didFailToSaveComment
    case didFailToImageLoad
    
}

extension AlertType {
    
    public var title: String {
        switch self {
        case .invalidToken: return "올바르지 않은 회원 정보"
        case .signOut: return "로그아웃"
        case .resign: return "회원 탈퇴"
        case .didFailResign: return "회원 탈퇴 실패"
        case .completeResign: return "회원 탈퇴"
        case .didFailToLoadAddress: return "주소 획득 실패"
        case .didFailToLoadMetadataForEditor: return "사용자 정보 획득 실패"
        case .didFailToSaveStory: return "스토리 작성 실패"
        case .didFailToLoadStoryDetail: return "스토리 정보 획득 실패"
        case .didFailToDeleteStory: return "스토리 삭제 실패"
        case .didFailToFollow: return "팔로우/언팔로우 실패"
        case .didFailToLike: return "좋아요/좋아요 취소 실패"
        case .didFailToLoadComments: return "댓글 정보 획득 실패"
        case .didFailToSaveComment: return "댓글 작성 실패"
        case .didFailToImageLoad: return "이미지 로드 실패"
        }
    }
    
    public var message: String {
        switch self {
        case .invalidToken: return "회원 정보가 올바르지 않아요.\n 확인 버튼을 누르면 로그인 화면으로 이동해요."
        case .signOut: return "로그아웃을 하게 되면 로그인 화면으로 이동해요."
        case .resign: return "탈퇴하시면 기존의 정보는 모두 제거돼요.\n 정말 탈퇴 하실건가요?"
        case .didFailResign: return "탈퇴에 실패했어요.\n 잠시 후 다시 시도해주세요"
        case .completeResign: return "탈퇴가 완료되었어요.\n 다시 이용해주시기를 기다릴게요"
        case .didFailToLoadAddress: return "선택하신 위치의 주소 정보를 찾는데 실패했어요."
        case .didFailToLoadMetadataForEditor: return "스토리 생성에 필요한 사용자 정보를 가져오는데 실패했어요.\n 확인 버튼을 누르면 이전화면으로 이동해요."
        case .didFailToSaveStory: return "스토리 작성에 실패했어요.\n 다시 시도하시겠어요?"
        case .didFailToLoadStoryDetail: return "스토리 정보를 가져오는데 실패했어요.\n 확인 버튼을 누르면 이전화면으로 이동해요."
        case .didFailToDeleteStory: return "스토리를 삭제하는데 실패했어요."
        case .didFailToFollow: return "팔로우/언팔로우에 실패했어요."
        case .didFailToLike: return "좋아요/좋아요 취소에 실패했어요."
        case .didFailToLoadComments: return "댓글을 불러오는데 실패했어요.\n 확인 버튼을 누르면 이전화면으로 이동해요."
        case .didFailToSaveComment: return "댓글 작성에 실패했어요.\n 다시 시도하시겠어요?"
        case .didFailToImageLoad: return "지원하지 않는 이미지 타입이에요."
        }
    }
    
    public var isCancellable: Bool {
        switch self {
        case .invalidToken: return false
        case .signOut: return true
        case .resign: return true
        case .completeResign: return false
        case .didFailResign: return false
        case .didFailToLoadAddress: return false
        case .didFailToLoadMetadataForEditor: return false
        case .didFailToSaveStory: return true
        case .didFailToLoadStoryDetail: return false
        case .didFailToDeleteStory: return false
        case .didFailToFollow: return false
        case .didFailToLike: return false
        case .didFailToLoadComments: return false
        case .didFailToSaveComment: return true
        case .didFailToImageLoad: return false
        }
    }
    
}
