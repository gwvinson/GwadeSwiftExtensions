//
//  Color.swift
//  Path
//
//  Created by Garret Vinson on 10/31/23.
//

import SwiftUI

extension Color {
    /// Initialize a Color from a UIColor in the asset catalog.
    public init(uiColor name: String) {
        if let uiColor = UIColor(named: name) {
            self = Color(uiColor)
        } else {
            self = Color.clear // Fallback in case the color name is not found
        }
    }
}
