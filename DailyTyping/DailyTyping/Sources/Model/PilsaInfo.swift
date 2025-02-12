//
//  Untitled.swift
//  DailyTyping
//
//  Created by 조유진 on 2/12/25.
//


struct PilsaInfo {
    let title: String
    let author: String
    let link: String
    let message: String
}

extension PilsaInfo {
    static let defaultPilsaInfo = PilsaInfo(
        title: TypingLabelText.defaultTitle.rawValue,
        author: TypingLabelText.author.rawValue,
        link: LinkWebLabelText.defaultLink.rawValue,
        message: TypingLabelText.typingValue.rawValue
    )
}
