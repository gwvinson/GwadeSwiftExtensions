//
//  KeyedDecodingContainer.swift
//  Path
//
//  Created by Garret Vinson on 11/9/24.
//

import Foundation

extension KeyedDecodingContainer {
    /// Decode a Date property from a numeric value or ISO 8601 String.
    public func decodeDate(forKey key: K) throws -> Date {
        // Try decoding the date
        if let date = try? self.decode(Date.self, forKey: key) {
            return date
        }
        
        // Try decoding the date as a String (ISO 8601)
        if let dateString = try? self.decode(String.self, forKey: key) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = formatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: key,
                    in: self,
                    debugDescription: "Invalid ISO 8601 date string format for key \(key.stringValue)"
                )
            }
        }
        
        // Throw an error if neither decoding method succeeds
        throw DecodingError.typeMismatch(
            Date.self,
            DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Expected Double or valid ISO 8601 date string for key \(key.stringValue)"
            )
        )
    }
    
    /// Decode an optional Date property from a numeric value or ISO 8601 String.
    public func decodeOptionalDate(forKey key: K) throws -> Date? {
        // Try decoding the date as a Double (Unix timestamp)
        if let date = try? self.decodeIfPresent(Date.self, forKey: key) {
            return date
        }
        
        // Try decoding the date as a String (ISO 8601)
        if let dateString = try? self.decodeIfPresent(String.self, forKey: key) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = formatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: key,
                    in: self,
                    debugDescription: "Invalid ISO 8601 date string format for key \(key.stringValue)"
                )
            }
        }
        
        // Return nil if no value is present for the key
        return nil
    }
}
