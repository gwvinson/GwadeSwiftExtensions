//
//  Measurement.swift
//  Path
//
//  Created by Garret Vinson on 12/4/23.
//

import Foundation

extension Measurement where UnitType: Dimension {
    /// Convert a Measurement of UnitType X to UnitType Y where both X and Y
    /// share the same base unit.
    public func convert(to unit: UnitType, decimalToRound: Double) -> Double {
        //perform the conversion
        let conversion = self.converted(to: unit).value
        
        //calculate the truncating divisor and rounding point for accurate rounding
        let truncatingDivisor = pow(10, -decimalToRound)
        let roundingPoint = 0.5 * truncatingDivisor
        
        if conversion.truncatingRemainder(dividingBy: truncatingDivisor) >= roundingPoint { //The remainder is greater than the rounding point.
            return conversion + (truncatingDivisor - conversion.truncatingRemainder(dividingBy: truncatingDivisor)) //round up
        } else {
            return conversion - conversion.truncatingRemainder(dividingBy: truncatingDivisor) //round down
        }
    }
}
