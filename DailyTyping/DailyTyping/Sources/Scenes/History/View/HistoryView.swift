//
//  HistoryView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

final class HistoryView: BaseView {
    let navigationTitleLabel: UILabel = {
        let label = UILabel()
        let title = HistoryLabelText.navigationTitle.rawValue
        label.text = title
        label.setAttributedString(
            text: title,
            color: .primaryEmphasis,
            font: .nanumMyeongjo(type: .Bold, size: 21),
            lineHeight: 27,
            charSpacing: -0.02
        )
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .iconLeftArrow.resized(to: CGSize(width: 24, height: 24))
        button.configuration = configuration
        
        return button
    }()
    
    let calendarCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .inversePrimaryEmphasis
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 19, right: 10)
        collectionView.register(WeekCalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekCalendarHeaderView.identifier)
        collectionView.register(WeekDayCollectionViewCell.self, forCellWithReuseIdentifier: WeekDayCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 4, right: 19)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let historyBackgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .crumpledWhitePaper)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .backgroundGray
        return imageView
    }()
    
    let bottomView = BottomView()
    
    override func configureLayout() {
        addSubview(historyBackgroundImageView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .bottom(0)])
        addSubview(calendarCollectionView, autoLayout: [.topSafeArea(0), .leading(0), .trailing(0), .height(94.5)])
        addSubview(bottomView, autoLayout: [.bottom(0), .leading(0), .trailing(0), .height(200)])
    }
    
    override func configureView() {
        super.configureView()
    }
    
    private func createCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 44, height: 44)
    }
}
