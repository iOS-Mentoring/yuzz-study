//
//  TypingResultView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

final class IntrinsicView: UIView {
    var myIntrinsicSize: CGSize = .zero
    override var intrinsicContentSize: CGSize {
        return myIntrinsicSize
    }
}

final class TypingResultView: BaseView {
    private let resultStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.design(axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 8)
        return stackView
    }()
    
    // WPM
    private let wpmLabel: ResultTitleLabel = {
        let label = ResultTitleLabel()
        label.configureView(title: TypingCompletedLabelText.wpm.rawValue)
        return label
    }()
    
    private let wpmValueLabel: ResultValueLabel = {
        let label = ResultValueLabel()
        label.configureView(title: "430")
        return label
    }()
    
    private lazy var wpmStackView = createStackView(view1: wpmLabel, view2: wpmValueLabel)
    
    // ACC
    private let accLabel: ResultTitleLabel = {
        let label = ResultTitleLabel()
        label.configureView(title: TypingCompletedLabelText.acc.rawValue)
        return label
    }()
    
    private let accValueLabel: ResultValueLabel = {
        let label = ResultValueLabel()
        label.configureView(title: "99%")
        return label
    }()
    private lazy var accStackView = createStackView(view1: accLabel, view2: accValueLabel)
    
    // Date
    private let dateLabel: ResultTitleLabel = {
        let label = ResultTitleLabel()
        label.configureView(title: TypingCompletedLabelText.date.rawValue)
        return label
    }()
    
    private let dateValueLabel: ResultValueLabel = {
        let label = ResultValueLabel()
        label.configureView(title: "Jan 28")
        return label
    }()
    private lazy var dateStackView = createStackView(view1: dateLabel, view2: dateValueLabel)
    
    override func configureLayout() {
        addSubview(resultStackView, autoLayout: [.top(20), .leading(0), .trailing(0), .bottom(20)])
        
        [wpmStackView, createDividorView(), accStackView, createDividorView(), dateStackView].forEach {
            resultStackView.addArrangedSubview($0)
        }
    }
    
    func createDividorView() -> IntrinsicView {
        let view = IntrinsicView(frame: CGRect(x: 0, y: 0, width: 0.5, height: 35))
        view.myIntrinsicSize = CGSize(width: 0.5, height: 35)
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }
    
    func createStackView(view1: UIView, view2: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.design(axis: .vertical, alignment: .center, distribution: .fill, spacing: 12)
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        return stackView
    }
}
