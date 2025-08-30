//
//  Bundle-AppVersion.swift
//  Path
//
//  Created by Garret Vinson on 7/14/24.
//

import Foundation

extension Bundle {
    /// Get the current version (CFBundleShortVersionString) from the app Bundle.
    public static var currentAppVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
