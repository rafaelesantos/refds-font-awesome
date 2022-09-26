//
//  ContentView.swift
//  Example
//
//  Created by Rafael Escaleira Ferreira dos Santos on 25/09/22.
//

import SwiftUI
import RefdsFontAwesome

struct ContentView: View {
    var body: some View {
        VStack {
            RefdsFontAwesome(iconName: .shop, size: 50)
        }
        .task {
            //print(FontAwesome.shared.store[RefdsIconLabel.shop.rawValue])
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
