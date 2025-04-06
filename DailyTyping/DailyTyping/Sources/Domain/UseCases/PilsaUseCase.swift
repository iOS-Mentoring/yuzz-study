//
//  PilsaUseCase.swift
//  DailyTyping
//
//  Created by 조유진 on 4/6/25.
//

import Foundation

protocol PilsaUseCase {
    /// 주어진 초(second)와 텍스트에서 계산된 문자 개수를 이용해 WPM을 산출하는 함수
    func calculateWPM(pilsaMessage: String, second: Int, text: String) -> Int
    
    /// 최종 타이핑 결과(PilsaTypingResult)를 생성하는 함수
    func createPilsaResult(pilsaInfo: PilsaInfo, second: Int, text: String) -> PilsaTypingResult
    func validateCharacter(text: String, pilsaMessage: String) -> NSAttributedString
    func isMatchHangulCharacter(text: String, pilsaMessage: String) -> Bool 
}

final class PilsaUseCaseImpl: PilsaUseCase {
    private let typingCalculator: TypingCalulator
    
    init(typingCalculator: TypingCalulator) {
        self.typingCalculator = typingCalculator
    }
    
    func calculateWPM(pilsaMessage: String, second: Int, text: String) -> Int {
        let count = typingCalculator.getMatchHangulCharacterCount(text: text, pilsaMessage: pilsaMessage)
        return typingCalculator.getWPM(second: second, characterCount: count)
    }
    
    func createPilsaResult(pilsaInfo: PilsaInfo, second: Int, text: String) -> PilsaTypingResult {
        let pilsaPerformance = getPilsaPerformance(pilsaMessage: pilsaInfo.message, second: second, text: text)
        
        return PilsaTypingResult(
            pilsaInfo: pilsaInfo,
            pilsaPerformance: pilsaPerformance
        )
    }
    
    private func getPilsaPerformance(pilsaMessage: String, second: Int, text: String) -> PilsaPerformance {
        let wpm = calculateWPM(pilsaMessage: pilsaMessage, second: second, text: text)
        let acc = typingCalculator.calculateAcc(text: text, pilsaMessage: pilsaMessage)
        
        return PilsaPerformance(
            wpm: wpm,
            acc: acc,
            date: Date()
        )
    }
    
    func validateCharacter(text: String, pilsaMessage: String) -> NSAttributedString {
        return typingCalculator.validateCharacter(text: text, pilsaMessage: pilsaMessage)
    }
    
    func isMatchHangulCharacter(text: String, pilsaMessage: String) -> Bool {
        return typingCalculator.isMatchHangulCharacter(text: text, pilsaMessage: pilsaMessage)
    }
}
