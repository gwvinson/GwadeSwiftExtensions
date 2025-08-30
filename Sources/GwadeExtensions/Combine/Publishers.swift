//
//  Publisher.swift
//  Path
//
//  Created by Garret Vinson on 1/31/24.
//

import Combine
import Foundation

extension Publishers {
    /// Merge several Notifications into a single Publisher.
    public static func combinedNotificationPublisher(for notifications: [Notification.Name]) -> AnyPublisher<Notification, Never> {
        guard let first = notifications.first else {
            return Empty<Notification, Never>().eraseToAnyPublisher()
        }

        let initialPublisher = NotificationCenter.default.publisher(for: first).eraseToAnyPublisher()
        return notifications.dropFirst().reduce(initialPublisher) { combined, name in
            combined
                .merge(with: NotificationCenter.default.publisher(for: name))
                .eraseToAnyPublisher()
        }
    }
}
