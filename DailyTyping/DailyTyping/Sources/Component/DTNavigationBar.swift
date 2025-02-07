//
//  DTNavigationBar.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

final class DTNavigationBar: BaseView {
    private var titleLabel: UILabel?
    private var leftButton: UIButton?
    private var rightButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavigationItem(
        titleLabel: UILabel? = nil,
        leftButton: UIButton? = nil,
        rightButton: UIButton? = nil
    ) {
        self.titleLabel = titleLabel
        self.leftButton = leftButton
        self.rightButton = rightButton
        configureLayout()
    }
    
    override func configureLayout() {
        if let titleLabel { addSubview(titleLabel, autoLayout: [.center(0)]) }
        if let leftButton { addSubview(leftButton, autoLayout: [.leading(20), .centerY(0)]) }
        if let rightButton { addSubview(rightButton, autoLayout: [.trailing(20), .centerY(0), .width(24), .height(24)]) }
    }
    
    override func configureView() {
        super.configureView()
    }
}
