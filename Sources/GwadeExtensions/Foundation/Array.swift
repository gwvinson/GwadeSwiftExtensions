//
//  Array.swift
//  Path
//
//  Created by Garret Vinson on 5/25/25.
//

import Foundation

extension Array {
    /// Split an array into two using a Bool expression. O(n)
    ///
    /// For example: If we call split { $0 % 2 == 0 } when
    /// the array contains [1, 2, 3, 4] we will receive
    /// ([2, 4], [1, 3])
    public func split(_ predicate: (Self.Element) throws -> Bool) rethrows -> ([Self.Element], [Self.Element]) {
        guard self.count > 0 else { return ([], []) }
        
        var x: [Self.Iterator.Element] = []
        var y: [Self.Iterator.Element] = []
        
        for e in self {
            if try predicate(e) {
                x.append(e)
            } else {
                y.append(e)
            }
        }
        
        return (x, y)
    }
}
