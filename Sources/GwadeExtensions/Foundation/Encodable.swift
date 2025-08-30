//
//  Encodable.swift
//  Path
//
//  Created by Garret Vinson on 11/5/23.
//

import Foundation

extension Encodable {
    /// Encode data using a standard JSONEncoder.
    public func encoded() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            #if DEBUG
                print("Failed to encode \(self): \(error)")
            #endif
            return nil
        }
    }
}
