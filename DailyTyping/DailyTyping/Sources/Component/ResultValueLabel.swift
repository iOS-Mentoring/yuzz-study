//
//  ResultValueLabel.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class ResultValueLabel: UILabel {
    var myIntrinsicSize: CGSize = .zero
    override var intrinsicContentSize: CGSize {
        return myIntrinsicSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(title: String) {
        setAttributedString(text: title, font: .pretendard(type: .Bold, size: 20), lineHeight: 20, charSpacing: -0.025)
        textAlignment = .center
        myIntrinsicSize = CGSize(width: 100, height: 20)
    }
}
