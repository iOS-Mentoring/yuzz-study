//
//  HistoryViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit
import Combine

final class HistoryViewController: UIViewController {
    private let mainView = HistoryView()
    private let viewModel: any ViewModelType
    var coordinator: HistoryCoordinator?
    
    private var dataSource: UICollectionViewDiffableDataSource<HistorySection, CalendarPilsaItem>!
    private typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<WeekCalendarHeaderView>

    private var cancellables = Set<AnyCancellable>()
    
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        coordinator?.removeCoordinator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSubject.send(())
        configureNavigationItem()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func bind() {
        guard let viewModel = viewModel as? HistoryViewModel else { return }
        let input = HistoryViewModel.Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        
        mainView.backButton.tapPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                coordinator?.removeCoordinator()
            }
            .store(in: &cancellables)
        
        output.configureDataSource
            .sink { [weak self] _ in
                guard let self else { return }
                configureDataSource()
                configureSupplementaryViewDataSource()
            }
            .store(in: &cancellables)
        
        output.calendarItemPublisher
            .sink { [weak self] items in
                guard let self else { return }
                applySnapshot(items: items)
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigationItem() {
        navigationController?.navigationBar.backgroundColor = .inversePrimaryEmphasis
        navigationItem.titleView = mainView.navigationTitleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
    }
}

extension HistoryViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.calendarCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDayCollectionViewCell.identifier, for: indexPath) as? WeekDayCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(calendarPilsaItem: item)
            return cell
        })
    }
    
    private func configureSupplementaryViewDataSource() {
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekCalendarHeaderView.identifier, for: indexPath) as? WeekCalendarHeaderView else { return UICollectionReusableView() }
                return header
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    private func applySnapshot(items: [CalendarPilsaItem], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<HistorySection, CalendarPilsaItem>()
        snapshot.appendSections([.calendar])
        snapshot.appendItems(items, toSection: .calendar)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
