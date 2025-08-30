//
//  Collection.swift
//  Path
//
//  Created by Garret Vinson on 1/31/24.
//

import Foundation

extension Collection {
    /// Remove the first n elements from a collection.
    /// Returns a subsequence starting after the specified number of elements.
    public func removingFirst(_ n: Int) -> SubSequence {
        // Ensure that the number of elements to remove does not exceed the count of the collection
        let numberToRemove = Swift.min(n, count)
        return self.dropFirst(numberToRemove)
    }
    
    /// Combine two collections and sort them.
    public func mergeAndSort(with otherCollection: [Element], reverse: Bool) -> [Element] where Element: Comparable & Equatable {
        // Combine this collection with the other collection
        let combinedArray = Array(self) + otherCollection
        
        // Sort the combined array
        let sortedArray = combinedArray.sorted { !reverse ? $0 < $1 : $0 > $1 }
        
        // Remove duplicates
        var result = [Element]()
        for item in sortedArray {
            if result.last != item {
                result.append(item)
            }
        }
        
        return result
    }
}

// MARK: Double Iterator

extension Collection where Iterator.Element == Double {
    /// Return the average value of the elements in the sequence
    public func average() -> Double {
        guard self.count > 0 else { return 0 }
        let total = self.reduce(0) { $0 + $1 }
        return total / Double(self.count)
    }
    
    /// Return the sum of all elements in the collection.
    public func sum() -> Double {
        return self.reduce(0) { $0 + $1 }
    }
}


// MARK: Chunks

extension Collection {
    /// Returns an array of arrays, where each sub-array is of a specified maximum size.
    public func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        var startIndex = self.startIndex
        while let endIndex = self.index(startIndex, offsetBy: size, limitedBy: self.endIndex) {
            chunks.append(Array(self[startIndex..<endIndex]))
            startIndex = endIndex
        }
        if startIndex != self.endIndex {
            chunks.append(Array(self[startIndex..<self.endIndex]))
        }
        return chunks
    }
}
