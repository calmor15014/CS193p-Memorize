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
                    withAnimation(.easeInOut) {
                        viewModel.newGame()
                    }
                }
            }
            .padding(.horizontal)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            PieView(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    self.startBonusTimeAnimation()
                                }
                        } else {
                            PieView(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        }
                    }.padding(5).opacity(0.4)
                    Text(card.content)
                        // implicit animation from lecture 6.
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                }.cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
            }
        }
        // Lecture 2 homework item #3 - no longer needed with Grid
        //.aspectRatio(2/3, contentMode: .fit)
    }
    
    // MARK: - Drawing Constants
    

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
