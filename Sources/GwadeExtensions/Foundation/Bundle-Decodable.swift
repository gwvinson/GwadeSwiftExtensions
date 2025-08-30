//
//  Bundle-Decodable.swift
//
//  Created by Garret Vinson on 8/17/23.
//

import Foundation

extension Bundle {
    /// Use a standard JSONDecoder to decode decodable objects from a file.
    public func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        do {
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error)")
        }
    }
    
    /// Uses a provided JSONDecoder to decode decodable objects from a file.
    public func decode<T: Decodable>(_ file: String, decoder: JSONDecoder) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        do {
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error)")
        }
    }
}
