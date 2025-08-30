//
//  String.swift
//  Path
//
//  Created by Garret Vinson on 11/2/23.
//

import Foundation

extension String {
    ///Returns true if the string without whitespaces and new lines is empty.
    public var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Remove trailing whitespaces and newlines from a String.
    public var removingTrailingWhitespaces: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
