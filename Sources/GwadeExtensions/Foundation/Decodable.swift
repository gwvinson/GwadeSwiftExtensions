//
//  Decodable.swift
//  Path
//
//  Created by Garret Vinson on 11/5/23.
//

import Foundation

extension Decodable {
    /// Decode data using a standard JSONDecoder.
    public static func decode(from data: Data) -> Self? {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(Self.self, from: data)
            return object
        } catch {
            #if DEBUG
                print("Failed to decode to \(Self.self): \(error)")
            #endif
            return nil
        }
    }
}
