//
//  FetchPilsaInfoUseCase.swift
//  DailyTyping
//
//  Created by 조유진 on 4/6/25.
//

import Foundation
import Combine

protocol FetchPilsaInfoUseCase: Sendable {
    func execute(
        title: String
    ) -> Future<PilsaInfo, Never>
}

extension FetchPilsaInfoUseCase {
    func execute(
        title: String = "불안한 사람들"
    ) -> Future<PilsaInfo, Never> {
        execute(title: title)
    }
}

final class DefaultFetchPilsaInfoUseCase: FetchPilsaInfoUseCase, @unchecked Sendable {
    private let pilsaInfoRepository: PilsaInfoRepository
    
    init(pilsaInfoRepository: PilsaInfoRepository) {
        self.pilsaInfoRepository = pilsaInfoRepository
    }
    
    func execute(title: String = "불안한 사람들") -> Future<PilsaInfo, Never> {
        return pilsaInfoRepository.fetchPilsaInfoPublisher(title: title)
    }
}

