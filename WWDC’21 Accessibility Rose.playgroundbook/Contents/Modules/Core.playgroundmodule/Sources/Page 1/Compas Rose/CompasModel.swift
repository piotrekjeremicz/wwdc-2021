//
//  CompasModel.swift
//  wwdc2021
//
//  Created by Piotrek on 10/04/2021.
//

import SwiftUI

public struct CompasModel: Hashable {
    public let text: String
    public let angle: Angle
    public let color: Color
    public let level: Level
    public let direction: Direction
    
    public enum Direction: String, CaseIterable {
        case N, E, S, W
        case NE, SE, SW, NW
    }

    public enum Level {
        case first, second
    }
    
    public init(direction: Direction) {
        text = direction.rawValue
        self.direction = direction
        
        switch direction {
        case .N, .E, .S, .W:
            color = .black
            level = .first
        case .NE, .SE, .SW, .NW:
            color = .gray
            level = .second
        }
        
        switch direction {
        case .N:
            angle = .degrees(0)
        case .NE:
            angle = .degrees(45)
        case .E:
            angle = .degrees(90)
        case .SE:
            angle = .degrees(135)
        case .S:
            angle = .degrees(180)
        case .SW:
            angle = .degrees(225)
        case .W:
            angle = .degrees(270)
        case .NW:
            angle = .degrees(315)
        }
    }
}
