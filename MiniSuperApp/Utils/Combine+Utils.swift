//
//  Combine+Utills.swift
//  MiniSuperApp
//
//  Created by sangheon on 2022/11/03.
//

import Combine
import CombineExt

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    
    public typealias Output = Element
    public typealias Failure = Never
    
    public var value: Element {
        currentValueRealy.value
    }
    
    fileprivate let currentValueRealy: CurrentValueRelay<Output>
    
    fileprivate init(_ initialValue: Element) {
        currentValueRealy = CurrentValueRelay(initialValue)
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Element == S.Input {
        currentValueRealy.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    
    typealias Output = Element
    typealias Failure = Never
    
    public override init(_ initialValue: Element) {
        super.init(initialValue)
    }
    
    public func send(_ value: Element) {
        currentValueRealy.accept(value)
    }
}
