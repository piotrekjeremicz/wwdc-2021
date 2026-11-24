//
//  HistoricalCompasModel.swift
//  wwdc2021
//
//  Created by Piotrek on 10/04/2021.
//

import SwiftUI

public struct HistoricalCompasModel: Hashable {
    public let text: String
    public let angle: Angle
    public let direction: Direction
    
    public enum Direction: String, CaseIterable {
        case N, E, S, W
        case NE, SE, SW, NW
        case NNE, SSE, SSW, NNW
    }

    public enum Level {
        case first, second
    }
    
    public init(direction: Direction) {
        self.direction = direction
                
        switch direction {
        case .N:
            text = "ὰπαρκτίας"
            angle = .degrees(0)
        case .NNE:
            text = "μέσης"
            angle = .degrees(30)
        case .NE:
            text = "καικίας"
            angle = .degrees(60)
        case .E:
            text = "ὰπηλιώτης"
            angle = .degrees(90)
        case .SE:
            text = "εΰρος"
            angle = .degrees(120)
        case .SSE:
            text = "εὺρόνοtος"
            angle = .degrees(150)
        case .S:
            text = "νόtος"
            angle = .degrees(180)
        case .SSW:
            text = "λιβόνοtος"
            angle = .degrees(210)
        case .SW:
            text = "λίψ"
            angle = .degrees(240)
        case .W:
            text = "ζέφυρος"
            angle = .degrees(270)
        case .NW:
            text = "ὰργέστης"
            angle = .degrees(300)
        case .NNW:
            text = "θρασκίας"
            angle = .degrees(330)
        }
    }
}
