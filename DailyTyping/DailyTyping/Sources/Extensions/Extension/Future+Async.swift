//
//  Future+Async.swift
//  YDRealm
//
//  Created by wi_seong on 12/17/24.
//

import Combine

public extension Future where Failure == Never {
    convenience init(asyncFunc: @escaping @Sendable () async throws -> Output) {
        self.init { promise in
            let sendablePromise = unsafeBitCast(promise, to: (@Sendable (Result<Output, Never>) -> Void).self)
            Task { @Sendable in
                do {
                    let result = try await asyncFunc()
                    sendablePromise(.success(result))
                } catch {
                    // Failure가 Never인 경우, 에러 처리는 생략하거나 로깅 등으로 처리합니다.
                }
            }
        }
    }
}
