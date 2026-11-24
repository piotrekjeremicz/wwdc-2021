//
//  Location.swift
//  wwdc2021
//
//  Created by Piotrek on 17/04/2021.
//

import SwiftUI
import CoreMotion

public class Location: NSObject, ObservableObject {
    
    public var onUpdate: (() -> ())?
    
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
    
    public let clickPlayer = AudioPlayer()
    public let tickPlayer = AudioPlayer()
    public var manager = CMMotionManager()
    
    public var targetDirection: Direction = .SE
    private var lastDirection: Direction = .N
    
    private let isSoundEnabled: Bool
    
    @Published public var direction: Angle = .init(degrees: 0)
    
    public init(isSoundEnabled: Bool = true) {
        self.isSoundEnabled = isSoundEnabled
    }
    
    public func start() {
        manager.deviceMotionUpdateInterval = 1/60
        
        manager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main) { monitor, error in
            guard let monitor = monitor else { return }
            
            self.onUpdate?()
            
            self.direction = .init(degrees: monitor.heading)
            let currentDirection = Direction(rawValue: Int(monitor.heading/22.5)) ?? .N
            
            if currentDirection != self.lastDirection {
                self.lastDirection = currentDirection
                if currentDirection == self.targetDirection {
                    if self.isSoundEnabled { self.tickPlayer.play() }
                } else {
                    if self.isSoundEnabled { self.clickPlayer.play() }
                }
            }
        }
        
        
        if isSoundEnabled {
            clickPlayer.load(click: .click, andPlay: false)
            tickPlayer.load(sound: .tink, andPlay: false)
        }
    }
}
