//
//  ViewModelType.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
  
    func transform(input: Input) -> Output
}
