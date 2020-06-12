//
//  Array+Identifiable.swift
//  Card Match Game
//
//  Created by Eric Liu on 2020-06-11.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
