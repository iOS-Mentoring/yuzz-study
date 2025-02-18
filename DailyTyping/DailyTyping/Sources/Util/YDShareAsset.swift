//
//  YDShareAsset.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

enum YDShareAsset: String {
    case iconBookmark = "icon_bookmark"
    case iconBookmarkFill = "icon_bookmark_fill"
    case iconClose = "icon_close"
    case iconDoubleQuotes = "icon_double_quotes"
    case iconInverseDownload = "icon_inverse_download"
    case iconInverseShare = "icon_inverse_share"
    case iconLink = "icon_link"
    case iconHistory = "icon_history"
    case iconLeftArrow = "icon_left_arrow"
    case illustHaruHalf = "illust_haru_half"
    case illustHaruWhole = "illust_haru_whole"
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
