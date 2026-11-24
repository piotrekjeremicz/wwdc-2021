//
//  HistoricalCompas.swift
//  wwdc2021
//
//  Created by Piotrek on 10/04/2021.
//

import SwiftUI

public struct HistoricalCompas: View {
    
    public let compasData = HistoricalCompasModel.Direction.allCases.map { HistoricalCompasModel(direction: $0) }
    private var heightScale: CGFloat = 0.93
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .foregroundColor(.yellow)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundColor(.black)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                Circle()
                    .foregroundColor(.white)
                    .frame(width: proxy.size.width*heightScale, height: proxy.size.height*heightScale)
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundColor(.black)
                    .frame(width: proxy.size.width*heightScale, height: proxy.size.height*heightScale)
                
                ForEach(compasData, id: \.self) { data in
                    Rectangle()
                        .foregroundColor(Int(data.angle.degrees)%90 == 0 ? .black : .red)
                        .frame(width: 4, height: proxy.size.height*heightScale-2)
                        .rotationEffect(data.angle)
                        .zIndex(Int(data.angle.degrees)%90 == 0 ? 1 : 0)
                    Group {
                        Text(data.text)
                            .rotationEffect(-data.angle)
                    }
                    .offset(x: 0, y: -proxy.size.height*heightScale*0.78)
                    .rotationEffect(data.angle)
                }
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct HistoricalCompas_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalCompas()
    }
}
