//
//  Vector.swift
//  wwdc2021
//
//  Created by Piotrek on 12/04/2021.
//

import SwiftUI

struct Vector {
    let start: CGPoint
    let end: CGPoint
    
    init(start: CGPoint = .zero, end: CGPoint) {
        self.start = start
        self.end = end
    }
    
    var size: CGFloat {
        return pow(pow(end.x - start.x, 2) + pow(end.y - start.y, 2), 0.5)
    }
    
    var angle: Angle {
        return .init(radians: Double(atan2(end.x - start.x, end.y - start.y)))
    }
}
