//
//  WeekDayCollectionViewCell.swift
//  DailyTyping
//
//  Created by 조유진 on 2/25/25.
//

import UIKit

final class WeekDayCollectionViewCell: UICollectionViewCell, ViewProtocol {
    private let dayLabel: DayLabel = {
        let label = DayLabel()
        label.configureView(day: "")
        return label
    }()
    
    private let dayBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(calendarPilsaItem: CalendarPilsaItem) {
        let dayString = String(Calendar.current.component(.day, from: calendarPilsaItem.day))
        dayLabel.configureView(day: dayString)
        circleView.isHidden = !calendarPilsaItem.isCompleted
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
    func configureLayout() {
        addSubview(dayBackgroundView, autoLayout: [.top(0), .leading(0), .trailing(0), .width(30), .height(30)])
        addSubview(dayLabel, autoLayout: [.centerX(0), .top(9), .height(12)])
        addSubview(circleView, autoLayout: [.topNext(to: dayBackgroundView, constant: 5), .centerX(0), .bottomLessThan(2), .width(4), .height(4)])
    }
}
