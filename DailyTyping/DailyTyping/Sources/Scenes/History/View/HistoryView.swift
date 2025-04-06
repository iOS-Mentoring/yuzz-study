//
//  HistoryView.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

enum HistorySection: Int {
    case calendar
}

final class HistoryView: BaseView {
    let navigationTitleLabel: UILabel = {
        let label = UILabel()
        let title = HistoryLabelText.navigationTitle.rawValue
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
    
    lazy var calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
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
        calendarCollectionView.backgroundColor = .inversePrimaryEmphasis
        calendarCollectionView.register(WeekCalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekCalendarHeaderView.identifier)
        calendarCollectionView.register(WeekDayCollectionViewCell.self, forCellWithReuseIdentifier: WeekDayCollectionViewCell.identifier)
        calendarCollectionView.bounces = false
    }
}

extension HistoryView {
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, UIListEnvironment -> NSCollectionLayoutSection? in
            guard let self else { return nil}
            
            if let historySection = HistorySection(rawValue: sectionIndex) {
                let section: NSCollectionLayoutSection
                
                switch historySection {
                case .calendar:
                    section = calendarLayout()
                }
                return section
            } else {
                return nil
            }
        }
        
        return layout
    }
 
    private func calendarLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(1.0/7.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(41)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 7)
        group.interItemSpacing = .flexible(20)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 19)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(43.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}
