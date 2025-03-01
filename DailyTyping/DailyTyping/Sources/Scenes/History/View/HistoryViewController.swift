//
//  HistoryViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit
import Combine

final class HistoryViewController: BaseViewController {
    private let mainView = HistoryView()
    private let viewModel: any ViewModelType
    var coordinator: HistoryCoordinator?
    
    var dateList: [Date] = []
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        coordinator?.removeCoordinator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30, height: 41)
        layout.minimumInteritemSpacing = 20
        mainView.calendarCollectionView.collectionViewLayout = layout
    }
    
    private func setDelegate() {
        mainView.calendarCollectionView.delegate = self
        mainView.calendarCollectionView.dataSource = self
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func bind() {
        guard let viewModel = viewModel as? HistoryViewModel else { return }
        let input = HistoryViewModel.Input(
            viewDidLoad: Just(()).eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        
        let calendarManager = CalendarManager()
        dateList = calendarManager.getCurrentWeekDates()
        mainView.calendarCollectionView.reloadData()
    }
    
    override func configureNavigationItem() {
        navigationItem.titleView = mainView.navigationTitleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDayCollectionViewCell.identifier, for: indexPath) as? WeekDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = dateList[indexPath.item]
        cell.configureCell(day: data, isCompleted: true)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: WeekCalendarHeaderView.identifier,
                for: indexPath
              ) as? WeekCalendarHeaderView else { return UICollectionReusableView() }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 23)
    }
}
