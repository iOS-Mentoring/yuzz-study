//
//  HomeViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 4/20/25.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setAttributedString(
            text: "안녕하세요.\n하루필사입니다.",
            color: .inversePrimaryEmphasis,
            font: .nanumMyeongjo(type: .Bold, size: 36),
            lineHeight: 50,
            charSpacing: -0.03
        )
        label.numberOfLines = 0
        return label
    }()
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.setAttributedString(
            text: "문장을 따라 필사하며 이야기가 흐르는\n하루를 쌓아보세요.",
            color: .inversePrimaryEmphasis.withAlphaComponent(0.6),
            font: .nanumMyeongjo(type: .Regular, size: 15),
            lineHeight: 23,
            charSpacing: -0.03
        )
        label.numberOfLines = 0
        return label
    }()
    
    private let pilsaContentView = ContentButtonView(content: .pilsa)
    private let typeCompetitionView = ContentButtonView(content: .typeCompetition)
    
    var coordinator: HomeCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureView()
    }
    
    override func closeButtonTapped() {
        coordinator?.removeCoordinator()
    }
    
    private func configureLayout() {
        view.addSubview(titleLabel, autoLayout: [.topSafeArea(120), .leading(30)])
        view.addSubview(guideLabel, autoLayout: [.topNext(to: titleLabel, constant: 10), .leading(30)])
        view.addSubview(pilsaContentView, autoLayout: [.bottomSafeArea(25), .leading(25),
            .width((UIScreen.main.bounds.width - 55)/2), .height((UIScreen.main.bounds.width - 55)/2)])
        view.addSubview(typeCompetitionView, autoLayout: [.bottomSafeArea(25), .trailing(25),
            .width((UIScreen.main.bounds.width - 55)/2), .height((UIScreen.main.bounds.width - 55)/2)])
    }
    
    private func configureView() {
        view.backgroundColor = .backgroundDarkGray
        
        pilsaContentView.isUserInteractionEnabled = true
        typeCompetitionView.isUserInteractionEnabled = true
        
        pilsaContentView.tapPublisher.sink { [weak self] _ in
            guard let self else { return }
            coordinator?.showTypingVC()
        }
        .store(in: &cancellables)
        
        typeCompetitionView.tapPublisher.sink { _ in
            
        }
        .store(in: &cancellables)
    }
}

enum Content {
    case pilsa
    case typeCompetition
    
    var title: String {
        switch self {
        case .pilsa: "필사하러 가기"
        case .typeCompetition: "타이핑 대결하기"
        }
    }
    
    var image: UIImage {
        switch self {
        case .pilsa: UIImage.miText
        case .typeCompetition: UIImage.miText2
        }
    }
}
