//
//  ClickGesture.swift
//  wwdc2021
//
//  Created by Piotrek on 14/04/2021.
//

import SwiftUI

public struct ClickGesture: Gesture {
    public let count: Int
    public let coordinateSpace: CoordinateSpace
    
    public typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
    
    public init(count: Int = 1, coordinateSpace: CoordinateSpace = .local) {
        precondition(count > 0, "Count must be greater than or equal to 1.")
        self.count = count
        self.coordinateSpace = coordinateSpace
    }
    
    public var body: SimultaneousGesture<TapGesture, DragGesture> {
        SimultaneousGesture(
            TapGesture(count: count),
            DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
        )
    }
    
    public func onEnded(perform action: @escaping (CGPoint) -> Void) -> _EndedGesture<ClickGesture> {
        ClickGesture(count: count, coordinateSpace: coordinateSpace)
            .onEnded { (value: Value) -> Void in
                guard value.first != nil else { return }
                guard let location = value.second?.startLocation else { return }
                guard let endLocation = value.second?.location else { return }
                guard ((location.x-1)...(location.x+1)).contains(endLocation.x),
                      ((location.y-1)...(location.y+1)).contains(endLocation.y) else {
                    return
                }
                
                action(location)
            }
    }
}
