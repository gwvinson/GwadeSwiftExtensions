//
//  CGSize.swift
//  Path
//
//  Created by Garret Vinson on 7/2/25.
//

import Foundation

extension CGSize {
    /// Compare the size of two CGSize objects with a certain tolerance.
    public func matches(_ sizeTwo: CGSize, tolerance: CGFloat = 0.01) -> Bool {
        let oneWidth = self.width
        let oneHeight = self.height
        let twoWidth = sizeTwo.width
        let twoHeight = sizeTwo.height
        
        if abs(oneWidth - twoWidth) >= tolerance || abs(oneHeight - twoHeight) >= tolerance {
            return false
        } else {
            return true
        }
    }
    
    /// Check if two CGSize objects height properties are equal with a certain tolerance.
    public func matchesHeight(_ sizeTwo: CGSize, tolerance: CGFloat = 0.01) -> Bool {
        let oneHeight = self.height
        let twoHeight = sizeTwo.height
        
        if abs(oneHeight - twoHeight) >= tolerance {
            return false
        } else {
            return true
        }
    }
}
