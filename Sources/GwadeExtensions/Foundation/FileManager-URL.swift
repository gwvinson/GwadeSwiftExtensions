//
//  FileManager-URL.swift
//
//  Created by Garret Vinson on 8/17/23.
//

import Foundation

extension FileManager {
    /// Get a URL for the FileManager.default documentDirectory.
    public static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    /// Decode data from a file in the FileManager.default documentDirectory into
    /// a type conforming to Decodable.
    ///
    /// This function uses the default JSONDecoder.
    public static func decode<T: Decodable>(_ file: String) -> T? {
        guard let data = try? Data(contentsOf: documentsDirectory.appendingPathComponent(file)) else {
            print("Unable to access data in \(file)")
            return nil
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            print ("Unable to decode data in \(file)")
            return nil
        }
        
        return decoded
    }
    
    /// Decode data from a file in the FileManager.default documentDirectory into
    /// a type conforming to Decodable using a custom JSONDecoder.
    public static func decode<T: Decodable>(_ file: String, jsonDecoder: JSONDecoder) -> T? {
        guard let data = try? Data(contentsOf: documentsDirectory.appendingPathComponent(file)) else {
            print("Unable to access data in \(file)")
            return nil
        }
        
        guard let decoded = try? jsonDecoder.decode(T.self, from: data) else {
            print ("Unable to decode data in \(file)")
            return nil
        }
        
        return decoded
    }
    
    /// Write Data into a specified file in the documentsDirectory.
    public static func write(data: Data, to file: String) throws {
        let url = URL.documentsDirectory.appending(path: file)
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
    
    /// Read Data from a specified file in the documentsDirectory.
    public static func read(file: String) throws -> Data {
        let url = URL.documentsDirectory.appending(path: file)
        let data = try Data(contentsOf: url)
        return data
    }
    
    /// Delete a specified file from the documentsDirectory. If no such file exists,
    /// no op occurs.
    public static func delete(file: String) throws {
        let url = URL.documentsDirectory.appending(path: file)
        if FileManager.default.fileExists(atPath: url.path()) {
            try FileManager.default.removeItem(at: url)
        }
    }
    
    /// Create a URL for a specified file in the documentsDirectory.
    public static func urlFor(file: String) -> URL {
        URL.documentsDirectory.appending(path: file)
    }
}
