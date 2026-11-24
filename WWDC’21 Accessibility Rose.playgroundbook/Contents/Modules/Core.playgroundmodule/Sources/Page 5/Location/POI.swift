//
//  POI.swift
//  wwdc2021
//
//  Created by Piotrek on 18/04/2021.
//

import SwiftUI

public struct POI {
    public let point: CGPoint
    public let description: String
    
    public func isClose(to point: CGPoint) -> Bool {
        abs(point.x - self.point.x) < 80 && abs(point.y - self.point.y) < 80 ? true : false
    }
}

public struct POIData {
    public static let data = [
        POI(point: .init(x: -1466, y: 633), description: "South eighth street"),
        POI(point: .init(x: -1262, y: 536), description: "South seventh street"),
        POI(point: .init(x: -277, y: 376), description: "South third street"),
        POI(point: .init(x: -87, y: 259), description: "South second street - attention light rail"),
        POI(point: .init(x: 124, y: 137), description: "South first street - attention light rail"),
        POI(point: .init(x: 353, y: 4), description: "South Market street"),
    ]
}
