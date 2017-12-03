//
//  ViewController.swift
//  CardGame
//
//  Created by Curtis Wiseman on 12/2/17.
//  Copyright © 2017 Curtis Wiseman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "FLips: \(flipCount)"
        }
    }
    
    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count+1) / 2)
    
    var emojiChoices = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🥅"]
    
    var emoji = [Int:String]()

    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
        //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
        }else {
            print("chosen cards was not in button")
        }
    }
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        flipCount = 0
        updateViewFromModel()
        
    }
    
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        
    }
    
    func emoji(for card: Cards)->String{
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        
        if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        }else{
            return "?"
        }
        
    }
   


}

