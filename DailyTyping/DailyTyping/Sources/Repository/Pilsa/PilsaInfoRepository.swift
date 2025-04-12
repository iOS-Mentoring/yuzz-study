//
//  PilsaRepository.swift
//  DailyTyping
//
//  Created by 조유진 on 3/31/25.
//

import Combine
import Foundation

protocol PilsaInfoRepository: Sendable  {
    func fetchPilsaInfo(title: String) async throws -> PilsaInfo
}

extension PilsaInfoRepository {
    func fetchPilsaInfo(title: String = TypingLabelText.defaultTitle.rawValue) async throws -> PilsaInfo {
        return try await fetchPilsaInfo(title: title)
    }
}

extension PilsaInfoRepository {
    func fetchPilsaInfoPublisher(title: String = TypingLabelText.defaultTitle.rawValue) -> Future<PilsaInfo, Never> {
        Future(asyncFunc: {
            return try await self.fetchPilsaInfo(title: title)
        })
    }
}

final class PilsaInfoRepositoryImpl: PilsaInfoRepository {
    func fetchPilsaInfo(title: String) async throws -> PilsaInfo {
        return .mock
    }
}

extension PilsaInfo {
    static let mock: PilsaInfo =
    PilsaInfo(
        title: "불안한 사람들",
        author: "프레드릭 베크만",
        link: "https://pilsa/1",
        message: "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
    )
}

enum NetworkError: LocalizedError {
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            "알 수 없는 에러가 발생하였습니다."
        }
    }
}
