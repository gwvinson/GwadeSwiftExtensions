//
//  File.swift
//  GwadeExtensions
//
//  Created by Garret Vinson on 8/30/25.
//

import Foundation

extension Array where Element == String {
    /// Helper function that calls "ListFormatter.localizedString(byJoining: self)".
    public var localizedList: String {
        ListFormatter.localizedString(byJoining: self)
    }
}
