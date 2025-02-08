//
//  UIFont+named.swift
//  YDUI
//
//  Created by 류연수 on 2/4/25.
//

import UIKit

public extension UIFont {
    
    static func pretendard(type: YDFontFamily.PretendardType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
    
    static func nanumMyeongjo(type: YDFontFamily.NanumMyeongjoType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
}

public enum YDFontFamily {
    
    public enum PretendardType: String {
        case Black
        case Bold
        case ExtraBold
        case ExtraLight
        case Light
        case Medium
        case Regular
        case SemiBold
        case Thin
        
        func font(size: CGFloat) -> UIFont {
            return UIFont(name: "Pretendard-\(self.rawValue)", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
    
    public enum NanumMyeongjoType: String {
        case Regular = "OTF"
        case Bold = "OTFBold"
        case ExtraBold = "OTFExtraBold"
        
        func font(size: CGFloat) -> UIFont {
            return UIFont(name: "NanumMyeongjo\(self.rawValue)", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
}
