//
//  Observable.swift
//  breakingbadapi
//
//  Created by David Martin on 6/12/20.
//

class Observable<T> {
    typealias Listener = (T?) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(self.value)
    }

    var value: T? {
        didSet {
            self.listener?(self.value)
        }
    }

//    init(_ value: T) {
//        self.value = value
//    }
}
