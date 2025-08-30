//
//  Comparable.swift
//  Path
//
//  Created by Garret Vinson on 5/7/25.
//

import Foundation

extension Comparable {
    /// Clamp a comparable value to a certain ClosedRange of values.
    public func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
