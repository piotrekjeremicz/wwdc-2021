//
//  Page5.swift
//  wwdc2021
//
//  Created by Piotrek on 17/04/2021.
//

import SwiftUI

public struct Page5: View {
        
    public let speaker = Speaker()
    public let alertPlayer = AudioPlayer()
    public let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State private var isBlackout: Bool = false
    @State private var isHintHidden: Bool = true
    @State private var mapOffset = CGSize(width: -1504, height: 979)
    @State private var navigateTo = NavigationData.data.first!
    @State private var navigationImage: Image = Image(systemName: "arrow.up")
    
    @ObservedObject var location = Location()
    @GestureState private var isTapped = false
    
    public init() { }
    
    public var body: some View {
        
        let tapGesture = DragGesture(minimumDistance: 0)
            .updating($isTapped) { _, isTapped, _ in
                isTapped = true
            }
        
        return ZStack {
            ZStack {
                Image(uiImage: UIImage(named: "Map.png")!)
                    .frame(width: 4608, height: 3072)
                    .offset(mapOffset)
                UserMarker(userRotation: $location.direction)
                    .onAppear(perform: onAppear)
                    .frame(width: 800, height: 800)
            }
            
            Color.black
                .opacity(isBlackout ? 1 : 0)
            
            VStack {
                ViewContainer {
                    Text("Now we will try to walk in the darkness.\nYou will hear the streets that will be crossing.\nIf you will be lost press\"Show Map\" button.")
                        .multilineTextAlignment(.center)
                }
                .opacity(isHintHidden ? 0 : 1)
                
                HStack(alignment: .bottom) {
                    ViewContainer {
                        Button {
                            withAnimation {
                                isBlackout.toggle()
                            }

                        } label: {
                            Image(systemName: isBlackout ? "eye.slash" : "eye").foregroundColor(.alwaysBlack)
                            Text(isBlackout ? "Show map" : "Hide map").foregroundColor(.alwaysBlack)
                        }
                    }
                    .padding(.leading, 20)
                    Spacer()
                    ViewContainer {
                        HStack {
                            navigationImage.font(.title).foregroundColor(.alwaysBlack)
                            VStack(alignment: .leading) {
                                Text(navigateTo.title).font(.title).foregroundColor(.alwaysBlack)
                                Text(navigateTo.next).font(.body).foregroundColor(.alwaysBlack)
                            }
                            .padding(.leading, 20)
                        }
                    }
                    .padding(.trailing, 20)
                }
                .frame(width: 540)
                .padding(.top, 480)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .gesture(tapGesture)
        .onReceive(timer, perform: { _ in onReceive() })
    }
    
    private func onAppear() {
        alertPlayer.load(sound: .triangle, andPlay: false)
        location.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            location.start()
        }
    }
    
    private func onReceive() {
        POIData.data.forEach { (poi) in
            if poi.isClose(to: mapOffset.asCGPoint) {
                speaker.say(poi.description)
            }
        }
        
        if isTapped {
            let endPoint = CGPoint(x: sin(location.direction.radians), y: cos(location.direction.radians))
            let vector = Vector(start: .init(x: 0, y: 0), end: endPoint)
            
            mapOffset = .init(width: mapOffset.width - vector.end.x, height: mapOffset.height + vector.end.y)            
        }
        
        if navigateTo.isClose(to: mapOffset.asCGPoint) && NavigationData.data.count > navigateTo.id {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let next = NavigationData.data[navigateTo.id - 1]
                let before = NavigationData.data[navigateTo.id - 2]
                let action = before.next.replacingOccurrences(of: "Next: ", with: "")
                speaker.say(action + " " + next.title)
            }
            
            navigateTo = NavigationData.data[navigateTo.id]
            
            if navigateTo.id == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        isBlackout = true
                        isHintHidden = false
                    }
                }
            }
            
            alertPlayer.play()
            navigationImage = navigateTo.image
            location.targetDirection = navigateTo.navigationDirection
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                navigationImage = Image(systemName: "arrow.up")
            }
        }
    }
}

struct Page5_Previews: PreviewProvider {
    static var previews: some View {
        Page5()
            .previewLayout(.fixed(width: 597, height: 720))
    }
}
