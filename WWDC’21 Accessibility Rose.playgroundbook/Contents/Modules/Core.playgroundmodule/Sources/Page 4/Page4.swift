//
//  Page4.swift
//  wwdc2021
//
//  Created by Piotrek on 19/04/2021.
//

import SwiftUI

public struct Page4: View {
    
    public let dcPlayer = AudioPlayer()
    public let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var location = Location(isSoundEnabled: false)
    
    @State private var points: Int = 0
    @State private var dubDubSounds: [DubDub] = []
    @State private var dubDubMarkers: [DubMarker] = []
    @State private var screenCenter = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        
    
    private var distance: Float = 100

    public init() { }
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                Background()
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            screenCenter = CGPoint(x: proxy.frame(in: .global).midX, y: proxy.frame(in: .global).midY)
                        }
                    })
                    .onTapGesture(perform: sayDC)
            }
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
                .frame(width: 400, height: 400)
                .padding()
            ForEach(dubDubMarkers) { dubDubMarker in
                dubDubMarker
            }
            UserMarker(userRotation: $location.direction)
                .onAppear(perform: onAppear)
            VStack {
                HStack {
                    ViewContainer {
                        VStack {
                            Text("Score").font(.headline).bold().foregroundColor(.alwaysBlack)
                            Text("\(points)").foregroundColor(.alwaysBlack)
                        }
                    }
                    Spacer()
                    ViewContainer {
                        VStack {
                            Text("DubDub's").font(.headline).bold().foregroundColor(.alwaysBlack)
                            Text("\(dubDubSounds.count)").foregroundColor(.alwaysBlack)
                        }
                    }
                }
                .padding()
                Spacer()
            }
        }
        .onReceive(timer, perform: { _ in createNewDubDub() })
    }
    
    private func onAppear() {
        location.start()
        location.onUpdate = { self.dubDubSounds.forEach { (dub) in dub.update() }}
        dcPlayer.load(file: "dc", ext: "m4a", andPlay: false)
        
    }
    
    private func sayDC() {
        dcPlayer.stop()
        dcPlayer.play()
        
        var toRemove: [DubDub] = []
        dubDubSounds.forEach { (sound) in
            let vector = Vector(start: sound.position, end: .zero)
            let degreesSoundAngle = vector.angle.degrees < 0 ? abs(vector.angle.degrees) : 360 - vector.angle.degrees
            
            if abs(degreesSoundAngle - location.direction.degrees) < 45 {
                if abs(degreesSoundAngle - location.direction.degrees) < 10 {
                    points += 100
                } else if abs(degreesSoundAngle - location.direction.degrees) < 25 {
                    points += 50
                } else if abs(degreesSoundAngle - location.direction.degrees) < 45 {
                    points += 25
                }
                
                dubDubMarkers.append(DubMarker(position: sound.position))
                
                sound.player.stop()
                toRemove.append(sound)
            }
        }
        
        dubDubSounds.removeAll(where: { dubdub -> Bool in
            toRemove.contains { (toRemove) -> Bool in
                dubdub.id == toRemove.id
            }
        })
    }
    
    private func createNewDubDub() {
        let level = Int(points/100 + 1)
        
        if dubDubSounds.count < level {
            let xRandom = Float.random(in: -1...1)
            let yRandom = Float.random(in: -1...1)
            
            let newPoint = CGPoint(x: CGFloat(distance * xRandom), y: CGFloat(distance * yRandom))
            
            dubDubSounds.append(DubDub(position: newPoint, userPosition: screenCenter, userDirection: $location.direction, sound: DubDub.Sound.random()))
        }
        
        let random = Int.random(in: 0...dubDubSounds.count - 1)
        if !dubDubSounds[random].player.isPlaying {
            dubDubSounds[random].player.play()
        }
    }
}

struct Page4_Previews: PreviewProvider {
    static var previews: some View {
        Page4()
            .previewLayout(.fixed(width: 597, height: 720))
    }
}
