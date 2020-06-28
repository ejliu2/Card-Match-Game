//
//  Cardify.swift
//  Card Match Game
//
//  Created by Eric Liu on 2020-06-26.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var colour: LinearGradient
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    init(isFaceUp: Bool, colour: LinearGradient) {
        rotation = isFaceUp ? 0 : 180
        self.colour = colour
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
                
            RoundedRectangle(cornerRadius: cornerRadius).fill(colour)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, colour: LinearGradient) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, colour: colour))
    }
}
