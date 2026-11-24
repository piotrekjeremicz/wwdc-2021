//
//  Navigation.swift
//  wwdc2021
//
//  Created by Piotrek on 18/04/2021.
//

import SwiftUI

public struct NavigatorModel {
    public let id: Int
    
    public let start: CGPoint
    public let end: CGPoint
    public let navigationDirection: Location.Direction
    
    public let image: Image
    public let title: String
    public let next: String
    
    public func isClose(to point: CGPoint) -> Bool {
        abs(point.x - self.end.x) < 50 && abs(point.y - self.end.y) < 50 ? true : false
    }
}

public struct NavigationData {
    public static let data: [NavigatorModel] = [
        NavigatorModel(
            id: 1,
            start: .init(x: -1504, y: 979),
            end: .init(x: -1644, y: 758),
            navigationDirection: .SE,
            image: Image(systemName: "arrow.up"),
            title: "Go straight 100 meters",
            next: "Next: turn right"
        ),
        NavigatorModel(
            id: 2,
            start: .init(x: -1644, y: 758),
            end: .init(x: -677, y: 193),
            navigationDirection: .SW,
            image: Image(systemName: "arrow.turn.up.right"),
            title: "Go straight 500 meters",
            next: "Next: turn right"
        ),
        NavigatorModel(
            id: 3,
            start: .init(x: -677, y: 193),
            end: .init(x: -494, y: 499),
            navigationDirection: .NW,
            image: Image(systemName: "arrow.turn.up.left"),
            title: "Go straight 200 meters",
            next: "Next: turn left"
        ),
        NavigatorModel(
            id: 4,
            start: .init(x: 494, y: 499),
            end: .init(x: 512, y: -92),
            navigationDirection: .SW,
            image: Image(systemName: "arrow.turn.up.left"),
            title: "Go straight 500 meters",
            next: "You will reach the destination"
        ),
        NavigatorModel(
            id: 5,
            start: .init(x: 512, y: -92),
            end: .init(x: 512, y: -92),
            navigationDirection: .SE,
            image: Image(systemName: "target"),
            title: "You reach WWDC!",
            next: "The destination is on the left"
        ),
    ]
}

extension CGSize {
    var asCGPoint: CGPoint {
        return .init(x: self.width, y: self.height)
    }
}
