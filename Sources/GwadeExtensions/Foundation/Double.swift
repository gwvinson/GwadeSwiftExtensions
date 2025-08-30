//
//  Double.swift
//  Path
//
//  Created by Garret Vinson on 11/28/23.
//

import Foundation

extension Double {
    /// Round a given Double to a specified number of decimal places.
    public func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Format a given double value to show a certain number of decimal values.
    public func dp(_ places: Int, removingTrilingZeros: Bool = false, showPositiveSign: Bool = false) -> String {
        var string = self.dp(places, removingTrailingZeros: removingTrilingZeros)
        if showPositiveSign && self > 0 {
            string.insert("+", at: string.startIndex)
        }
        return string
    }
    
    /// Format a given double value to show a certain number of decimal values.
    public func dp(_ places: Int, removingTrailingZeros: Bool = false) -> String {
        var str = String(format: "%.\(places)f", self)
        guard removingTrailingZeros && str.contains(".") else { return str }
        for char in str.reversed() {
            if char == "0" { str.removeLast() }
            else if char == "." { str.removeLast(); return str}
            else { return str }
        }
        
        #if DEBUG
            print("\(#file) - \(#function) never returned a value from the for loop. This should never occur.")
        #endif
        return str
    }
}
