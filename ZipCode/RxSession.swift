//
//  RxSession.swift
//  ZipCode
//
//  Created by Hoshi Takanori on 2016/04/27.
//  Copyright © 2016 Hoshi Takanori. All rights reserved.
//

import APIKit
import RxSwift

extension Session {
    public static func rx_response<T: RequestType>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = sendRequest(request) { result in
                switch result {
                case .Success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .Failure(let error):
                    observer.onError(error)
                }
            }
            let t = task
            t?.resume()

            return AnonymousDisposable {
                task?.cancel()
            }
        }
    }
}
