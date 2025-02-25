//
//  Reuse.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

protocol Reuse: AnyObject {
    static var identifier: String { get }
}

extension UICollectionReusableView: Reuse {
    static var identifier: String {
        String(describing: self)
    }
}
