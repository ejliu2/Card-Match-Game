//
//  Array+Only.swift
//  Card Match Game
//
//  Created by Eric Liu on 2020-06-11.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
