//
//  ContentView.swift
//  Memorize
//
//  Created by James Spece on 10/4/20.
//
//  View for the Memorize App

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
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
        // Font adjustment for count - Lecture 2 homework item #5
        .font(viewModel.cards.count < 10 ? Font.largeTitle : Font.title)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            // If face up, show the content of the card and a border
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            // Otherwise, show just the back of the card (solid color filll)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        // Lecture 2 homework item #3
        .aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
