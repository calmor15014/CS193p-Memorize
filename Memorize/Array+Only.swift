//
//  Array+Only.swift
//  Memorize
//
//  Created by James Spece on 10/11/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
