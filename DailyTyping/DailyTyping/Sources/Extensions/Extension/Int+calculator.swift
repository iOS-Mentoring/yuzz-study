//
//  Int.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

extension Int {
    func calculateWidth() -> CGFloat {
        return UIScreen.width * CGFloat(self)/60.0
    }
}
