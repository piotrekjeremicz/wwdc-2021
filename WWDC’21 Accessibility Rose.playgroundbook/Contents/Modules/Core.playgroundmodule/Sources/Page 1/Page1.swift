//
//  Page1.swift
//  wwdc2021
//
//  Created by Piotrek on 11/04/2021.
//

import SwiftUI

public struct Page1: View {
    @State private var selectedCompas = 1
    
    public init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.alwaysBlack], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.alwaysBlack], for: .normal)
    }
    
    public var body: some View {
        ZStack {
            Background()
            VStack {
                VStack {
                    switch selectedCompas {
                    case 1:
                        HistoricalCompas()
                    case 2:
                        Compas()
                    default:
                        GraphCompas(data: GraphData.data)
                            .scaleEffect(0.4)
                    }
                }
                .frame(width: 400, height: 400)
                ViewContainer() {
                    Text("Select the Compas Type")
                        .foregroundColor(.alwaysBlack)
                        .font(.title2)
                        .padding(.bottom, 20)
                    Picker(selection: $selectedCompas, label: Text("Wind Rose Samples"), content: {
                        Text("Historical").tag(1)
                        Text("Copmas").tag(2)
                        Text("Graph").tag(3)
                    })
                    
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 400)
                }
                
            }
        }
        .background(Color.gray.opacity(0.2))
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Page1()
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 597, height: 720))
        }
    }
}
