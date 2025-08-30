//
//  MKCoordinateRegion.swift
//  Path
//
//  Created by Garret Vinson on 5/10/25.
//

import MapKit

extension MKCoordinateRegion {
    /// Returns true if the MKCoordinateRegion bounds completely
    /// encapsulate the bounds of another MKCoordinateRegion.
    public func contains(_ other: MKCoordinateRegion) -> Bool {
        let outerMinLat = center.latitude - span.latitudeDelta / 2
        let innerMinLat = other.center.latitude - other.span.latitudeDelta / 2
        if innerMinLat < outerMinLat { return false }
        
        let outerMaxLat = center.latitude + span.latitudeDelta / 2
        let innerMaxLat = other.center.latitude + other.span.latitudeDelta / 2
        if innerMaxLat > outerMaxLat { return false }
        
        let outerMinLon = center.longitude - span.longitudeDelta / 2
        let innerMinLon = other.center.longitude - other.span.longitudeDelta / 2
        if innerMinLon < outerMinLon { return false }
        
        let outerMaxLon = center.longitude + span.longitudeDelta / 2
        let innerMaxLon = other.center.longitude + other.span.longitudeDelta / 2
        if innerMaxLon > outerMaxLon { return false }
        
        return true
    }
}
