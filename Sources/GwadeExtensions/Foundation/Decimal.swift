//
//  Double.swift
//  Path
//
//  Created by Garret Vinson on 11/28/23.
//

import Foundation

extension Decimal {
    /// Convert the Decimal value to a Double.
    public var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
