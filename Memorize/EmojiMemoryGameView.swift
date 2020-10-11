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
        // Show all the cards from the model in an HStack
        // using our CardView
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
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
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
                .font(Font.system(size: fontSize(for: geometry.size)))
        }
        // Lecture 2 homework item #3
        .aspectRatio(2/3, contentMode: .fit)
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
