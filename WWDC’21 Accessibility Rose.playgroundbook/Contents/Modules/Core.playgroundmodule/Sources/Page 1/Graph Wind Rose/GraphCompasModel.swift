//
//  GraphCompasModel.swift
//  wwdc2021
//
//  Created by Piotrek on 11/04/2021.
//

import SwiftUI

public class GraphData {
    public static let data: [GraphModel] = [
        GraphModel(amount: 0.14, direction: .WSW),
        GraphModel(amount: 0.2, direction: .W),
        GraphModel(amount: 0.4, direction: .WNW),
        GraphModel(amount: 0.22, direction: .WNW),
        GraphModel(amount: 0.1, direction: .WNW),
        GraphModel(amount: 0.7, direction: .NW),
        GraphModel(amount: 0.52, direction: .NW),
        GraphModel(amount: 0.23, direction: .NW),
        GraphModel(amount: 0.8, direction: .NNW),
        GraphModel(amount: 0.68, direction: .NNW),
        GraphModel(amount: 0.4, direction: .NNW),
        GraphModel(amount: 0.94, direction: .N),
        GraphModel(amount: 0.7, direction: .N),
        GraphModel(amount: 0.3, direction: .N),
        GraphModel(amount: 0.4, direction: .NNE),
        GraphModel(amount: 0.1, direction: .NNE),
        GraphModel(amount: 0.6, direction: .NNE),
        GraphModel(amount: 0.7, direction: .NE),
        GraphModel(amount: 0.6, direction: .NE),
        GraphModel(amount: 0.45, direction: .NE),
        GraphModel(amount: 0.4, direction: .ENE),
        GraphModel(amount: 0.15, direction: .ENE),
        GraphModel(amount: 0.3, direction: .E),
        GraphModel(amount: 0.18, direction: .E),
        GraphModel(amount: 0.15, direction: .SE),
        GraphModel(amount: 0.1, direction: .S)
    ]
}

public struct GraphModel: Hashable {
    public let color: Color
    public let amount: CGFloat
    public let direction: Direction
    
    public enum Direction: Int, CaseIterable {
        case N = 0
        case NNE = 1
        case NE = 2
        case ENE = 3
        case E = 4
        case ESE = 5
        case SE = 6
        case SSE = 7
        case S = 8
        case SSW = 9
        case SW = 10
        case WSW = 11
        case W = 12
        case WNW = 13
        case NW = 14
        case NNW = 15
    }
    
    public init(amount: CGFloat, direction: Direction) {
        let hueBottom: Double = 40/360
        let hueTop: Double = 260/360
        let hueInterval = hueTop - hueBottom
        let hue = hueTop - hueInterval*Double(amount)
        
        color = Color(hue: hue, saturation: 1, brightness: 1)
        self.amount = amount
        self.direction = direction
    }
}


