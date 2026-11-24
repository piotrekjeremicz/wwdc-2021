//
//  DubDub.swift
//  wwdc2021
//
//  Created by Piotrek on 20/04/2021.
//

import SwiftUI

public struct DubDub: Identifiable {
    public enum Sound: String, CaseIterable {
        case short, normal, long, dubdub
        
        static func random() -> Sound { Sound.allCases.randomElement()! }
    }
    
    public var id = UUID()
    
    public let position: CGPoint
    public let sound: Sound
    public let player: AudioPlayer
    public let userPosition: CGPoint
    
    @Binding var userDirection: Angle
        
    private var distance: Float = 100
    
    public init(position: CGPoint, userPosition: CGPoint, userDirection: Binding<Angle>, sound: Sound) {
        self._userDirection = userDirection
        self.userPosition = userPosition
        self.position = position
        self.sound = sound
        
        self.player = AudioPlayer()
        player.load(file: sound.rawValue, ext: "m4a", andPlay: false)
    }
    
    public func update() {
        let vector = Vector(start: position, end: .zero)
        let degreesUserAngle = userDirection.degrees > 0 ? userDirection.degrees : (360 - abs(userDirection.degrees))
        let degreesSoundAngle = vector.angle.degrees < 0 ? abs(vector.angle.degrees) : 360 - vector.angle.degrees
        
        let deltaSoundAngle = (degreesSoundAngle - degreesUserAngle) > 0 ? (degreesSoundAngle - degreesUserAngle) : 360 + (degreesSoundAngle - degreesUserAngle)
        let degreesTranslation = deltaSoundAngle <= 180 ? deltaSoundAngle : -(180 - (deltaSoundAngle - 180))

        let pan: Float
        let reducer: Float
        let side: Float = degreesTranslation > 0 ? 1 : -1
        
        if (0...90).contains(abs(degreesTranslation)) {
            pan = Float(abs(degreesTranslation)/90)*side
            reducer = 0
        } else  {
            pan = Float(1-(abs(degreesTranslation)/90-1))*side
            reducer = 0.5 - abs(pan)/2
        }

        let volume = 1 - reducer - Float(vector.size/CGFloat(distance))

        player.pan = Float(pan)
        player.volume = volume > 0 ? volume : 0.1
    }
}
