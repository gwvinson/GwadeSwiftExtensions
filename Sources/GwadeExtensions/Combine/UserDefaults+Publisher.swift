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
    ///     type: The data type the object will be decoded to.
    public func publisher<T: Codable & Equatable>(
        forKey key: String,
        as type: T.Type
    ) -> AnyPublisher<T?, Never> {
        
        // Determine the value currently stored.
        let currentValue: T? = {
            guard let data = self.data(forKey: key) else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        }()
        
        // Return the publisher.
        return NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification, object: self)
            .map { _ -> T? in
                guard let data = self.data(forKey: key) else { return nil }
                return try? JSONDecoder().decode(T.self, from: data)
            }
            .prepend(currentValue)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
