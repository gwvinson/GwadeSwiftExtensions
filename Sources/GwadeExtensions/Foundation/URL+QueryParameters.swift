//
//  URL+QueryParameters.swift
//  Path
//
//  Created by Garret Vinson on 4/26/25.
//

import Foundation

extension URL {
    /// Extract query parameters from a URL. For parameter X=Y, X would be a key
    /// and Y would be the corresponding value.
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value?.replacingOccurrences(of: "+", with: " ")
        }
    }
}
