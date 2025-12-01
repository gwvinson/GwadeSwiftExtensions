//
//  UserDefaults+Publisher.swift
//  GwadeExtensions
//
//  Created by Garret Vinson on 11/30/25.
//

import Combine
import Foundation

extension UserDefaults {
    /// Emits the value of data stored in UserDefaults at a specific key.
    /// Immediately emits the current value.
    ///
    ///     - Parameters:
    ///     key: The UserDefaults key used to store the data.
    public func publisher<T: Equatable>(forKey key: String) -> AnyPublisher<T?, Never> {
        NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification, object: self)
            .map { _ in self.object(forKey: key) as? T }
            .prepend(self.object(forKey: key) as? T)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
