//  Concentration.swift
//  Concentration
//
//  Created by Angel Zambrano on 1/5/19.
//  Copyright © 2019 Icon. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    let themes = ["faces", "halloween", "sports", "weather",  "cars", "animals"]
    var gameScore = 0
    var flipCount = 0
    var chosenBefore = [Int]()

    func chooseCard(at index: Int) {
       
        if !cards[index].isMatched {
             flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                   gameScore += 2
                } else {
                    for chosenIdentifier in chosenBefore.indices {
                        if cards[index].identifier == chosenBefore[chosenIdentifier] || cards[matchIndex].identifier == chosenBefore[chosenIdentifier] {
                            gameScore -= 1
                        }
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            } else {
                // ignore this
                for indexOfFaceDown in cards.indices {
                    cards[indexOfFaceDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
               indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
   
    
    func startNewGame(numberOfPairsOfCards: Int) {
        gameScore = 0
        flipCount = 0
        for card in cards.indices {
            cards[card].isFaceUp = false
            cards[card].isMatched = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
    }
    
    func getRandomTheme(of emoji: Dictionary<String, [String]>) -> [String] {
        let indexTheme = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        let theme = emoji[indexTheme]! 
        
        return theme
    }
    
    init(numberOfPairsOfCards: Int ) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
