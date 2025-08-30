//
//  KeyedDecodingContainer-VariableEnum.swift
//  Path
//
//  Created by Garret Vinson on 5/3/25.
//

import Foundation

public enum VariableEnumDecodeError: Error {
    case containerUnavailable
    case rawTypeMismatch
}

extension KeyedDecodingContainer where Key: CodingKey {
    /// Decodes a RawRepresentable object. If the return type cannot
    /// be initialized from the decoded rawValue, nil is returned.
    public func decodeRawRepresentable<T: RawRepresentable, RawType: Decodable>(
        _ type: T.Type,
        rawType: RawType.Type,
        forKey key: Key
    ) throws -> T? {
        let rawValue = try decode(rawType, forKey: key)
        
        guard let raw = rawValue as? T.RawValue else {
            throw VariableEnumDecodeError.rawTypeMismatch
        }
        
        return T(rawValue: raw)
    }
    
    /// Decodes a collection of RawRepresentable objects. If the return type
    /// cannot be initialized from the decoded rawValue, the object is skipped.
    public func decodeRawRepresentable<T: RawRepresentable, RawType: Decodable>(
        _ type: T.Type,
        rawType: RawType.Type,
        forKey key: Key
    ) throws -> [T] {
        var container: any UnkeyedDecodingContainer
        
        do {
            container = try nestedUnkeyedContainer(forKey: key)
        } catch {
            throw VariableEnumDecodeError.containerUnavailable
        }
        
        var rawValues: [RawType] = []
        while !container.isAtEnd {
            let rawValue: RawType
            
            do {
                rawValue = try container.decode(rawType)
            } catch {
                throw VariableEnumDecodeError.rawTypeMismatch
            }
            
            rawValues.append(rawValue)
        }
        
        return rawValues
            .compactMap { $0 as? T.RawValue }
            .compactMap { T(rawValue: $0) }
    }
}
