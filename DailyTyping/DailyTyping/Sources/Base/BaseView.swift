//
//  BaseView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func configureHierarchy() { }
    override func configureLayout() { }
    override func configureView() {
        backgroundColor = .white
    }

}
