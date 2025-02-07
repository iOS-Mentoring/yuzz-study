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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() {
        backgroundColor = .white
    }

}
