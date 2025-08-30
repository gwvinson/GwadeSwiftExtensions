//
//  Result-Void.swift
//  Path
//
//  Created by Garret Vinson on 12/10/24.
//

import Foundation

extension Result where Success == Void {
    /// Return a successful Result.
    public static func success() -> Result<Void, Failure> {
        return .success(())
    }
}
