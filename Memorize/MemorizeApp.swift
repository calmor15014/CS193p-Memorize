//
//  MemorizeApp.swift
//  Memorize
//
//  Created by James Spece on 10/4/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
