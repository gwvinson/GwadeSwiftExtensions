//
//  File.swift
//  GwadeExtensions
//
//  Created by Garret Vinson on 9/27/25.
//

import Foundation

extension NSLock {
    /// Execute logic preceeded by a lock() call and
    /// succeded by a unlock() call.
    func withLock<T>(_ body: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try body()
    }
    
    /// Execute logic preceeded by a lock() call and
    /// succeded by a unlock() call.
    func withLock<T>(_ body: () -> T) -> T {
        lock()
        defer { unlock() }
        return body()
    }
}
