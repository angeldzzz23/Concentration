//
//  ViewController.swift
//  Concentration
//
//  Created by Angel Zambrano on 1/5/19.
//  Copyright © 2019 Icon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1 ) / 2
    }
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    override func viewDidLoad() {
        super.viewDidLoad()
          emojiChoices = game.getRandomTheme(of: emojiChoicesTheme)
    }
   
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let buttonIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        } else {
            print("button is not in the collection of cardbuttons")
        }
    }
    
    
    func updateViewFromModel() {
        gameScoreLabel.text = String(game.gameScore)
        flipCountLabel.text = String(game.flipCount)
        for i in cardButtons.indices {
            let button = cardButtons[i]
            let card = game.cards[i]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    var emojiChoices = [String]()
    var emoji: Dictionary<Int, String> = [:]
    var emojiChoicesTheme = [
        "faces": ["😎","😍","🥰","🤪","🤬","🥵"],
        "halloween": ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"],
        "sports": ["⚽️","🏀","🏈","⚾️","🎾","🏐","🥏"],
        "weather": ["🌨","⛅️","🌤","🌩","⚡️","🌪","⛈"],
        "cars": [  "🚗","🚕","🏎","🚔","🚘","🛵","🚜","🚒"],
        "animals":["🦓","🦒","🦘","🕷","🐋","🐀","🦞","🦖","🐐","🐒"]
    
    ]
    
    
    // getting emoji from emojiChoices
    func emoji(for card: Card) -> String {
        game.chosenBefore = Array(emoji.keys)
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
   
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        gameScoreLabel.text = String(game.gameScore)
        game.startNewGame(numberOfPairsOfCards: numberOfPairsOfCards)
        restartEmojiChoices()
        updateViewFromModel()
    }
    
    func restartEmojiChoices(){
        if !emojiChoices.isEmpty {
            emojiChoices += Array(emoji.values)
            emoji.removeAll()
        } else {
            emojiChoices = Array(emoji.values)
            emoji.removeAll()
        }
        emojiChoices = game.getRandomTheme(of: emojiChoicesTheme)
        
    }

  


}
