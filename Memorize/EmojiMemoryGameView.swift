//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by James Spece on 10/4/20.
//
//  View for the Memorize App

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        // Homework 2 - items 6, 7, and 9
        // Make space in the UI for score, theme, and new button
        // Use our new Grid to show the cards
        VStack {
            HStack {
                Text(viewModel.themeName)
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
            }
            .padding(.horizontal)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(viewModel.themeColor)
            Text("Score: \(viewModel.score)")
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
                ZStack {
                    // If face up, show the content of the card and a border
                    if card.isFaceUp {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                        Text(card.content)
                    // Otherwise, show just the back of the card (solid color filll)
                    } else {
                        if !card.isMatched {
                            RoundedRectangle(cornerRadius: cornerRadius).fill()
                        }
                    }
                }
                .font(Font.system(size: fontSize(for: geometry.size)))
        }
        // Lecture 2 homework item #3 - no longer needed with Grid
        //.aspectRatio(2/3, contentMode: .fit)
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
