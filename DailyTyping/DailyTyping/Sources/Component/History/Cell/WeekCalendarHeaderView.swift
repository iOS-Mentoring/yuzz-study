//
//  WeekCalendarHeaderView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

final class WeekCalendarHeaderView: UICollectionReusableView, ViewProtocol {
    private let dayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.design(axis: .horizontal, alignment: .center, distribution: .equalSpacing)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        DayOfTheWeek.allCases.forEach {
            let label = self.createDayOfTheWeekLabel(dayOfTheWeek: $0)
            dayStackView.addArrangedSubview(label)
        }
        addSubview(dayStackView, autoLayout: [.leading(20), .trailing(19), .top(20), .bottom(11), .height(43)])
    }
    
    func createDayOfTheWeekLabel(dayOfTheWeek: DayOfTheWeek) -> DayOfTheWeekLabel {
        let label = DayOfTheWeekLabel()
        label.configureView(dayOfTheWeek: dayOfTheWeek)
        return label
    }
}

enum DayOfTheWeek: String, CaseIterable {
    case Sun, Mon, Tue, Wed, Thu, Fri, Sat
}
