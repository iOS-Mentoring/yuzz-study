//
//  TimerManager.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//

import Foundation
import Combine

protocol TimeProvider {
    func timerPublisher(every seconds: TimeInterval) -> AnyPublisher<Int, Never>
}

final class TimerManager: TimeProvider {
    func timerPublisher(every seconds: TimeInterval = 1.0, endSeconds: Int = 60) -> AnyPublisher<Int, Never> {
        Timer.publish(every: seconds, on: .main, in: .common)
            .autoconnect()
            .scan(0) { seconds, _ in
                seconds + 1
            }
            .prefix(endSeconds)
            .eraseToAnyPublisher()
    }
}
