//
//  MotionManager.swift
//  wwdc2021
//
//  Created by Piotrek on 12/04/2021.
//

import SwiftUI
import CoreMotion

public class MotionManager: ObservableObject {

    private var manager: CMMotionManager

    public var measurmentAccuracy: Double = .infinity
    public var maximumDataAmmount: Int = 50
    
    public var updateInterval: TimeInterval {
        get { manager.accelerometerUpdateInterval }
        set { manager.accelerometerUpdateInterval = newValue }
    }
    
    @Published var x: Double = 0.0
    @Published var y: Double = 0.0
    @Published var graphData: [GraphModel] = []
    
    public init() {        
        manager = CMMotionManager()
        manager.accelerometerUpdateInterval = 1/10
        manager.startAccelerometerUpdates(to: .main) { [self] data, error in
            guard error == nil else { return }

            if let data = data {
                x = data.acceleration.x
                y = data.acceleration.y
                
                if graphData.count < Int(maximumDataAmmount) {
                    let vector = Vector(end: .init(x: x, y: y))
                    let degrees = vector.angle.degrees > 0 ? vector.angle.degrees : vector.angle.degrees + 360
                    
                    let direction = GraphModel.Direction(rawValue: Int(degrees/22.5)) ?? .N
                    let amount = floor(Double(vector.size)/measurmentAccuracy)*measurmentAccuracy
                    
                    let model = GraphModel(amount: CGFloat(amount), direction: direction)
                    
                    guard graphData.count > 0 else { graphData.append(model); return }
                    if !graphData.contains(model) { graphData.append(model) }
                }
            }
        }
    }
}
