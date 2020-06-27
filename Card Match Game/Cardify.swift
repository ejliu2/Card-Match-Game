//
//  Cardify.swift
//  Card Match Game
//
//  Created by Eric Liu on 2020-06-26.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var colour: LinearGradient
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
                
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(colour)
            }
        }
    }
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, colour: LinearGradient) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, colour: colour))
    }
}
