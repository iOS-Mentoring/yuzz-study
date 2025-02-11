//
//  HistoryViewController.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import UIKit

final class HistoryViewController: BaseViewController {
    private let mainView = HistoryView()
    private let viewModel: any ViewModelType
    var coordinator: Coordinator?
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func loadView() {
        view = mainView
    }
    
    override func bind() {
        
    }
}
