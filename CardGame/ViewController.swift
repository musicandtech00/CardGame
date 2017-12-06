//
//  ViewController.swift
//  CardGame
//
//  Created by Curtis Wiseman on 12/2/17.
//  Copyright © 2017 Curtis Wiseman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //to keep track of the card game
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "FLips: \(flipCount)"
        }
    }
    
    //game model
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    // return the number of cards
    var numberOfPairOfCards: Int{
        get{
            return (cardButtons.count+1) / 2
        }
    }
    var sportChoices = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🥅"]
    var emojiChoices = ["😀","☠️","🤣","😎","😤","🤢","👽","💩","👿",]
    var animalChoices = ["🐶","🐱","🐧","🐸","🐛","🦋","🐣","🐊","🐋"]
    
    
    //so this is where i combine the three data structures into a dictionary
    var allTheChoices = ["sportChoices":["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🥅"],"emojiChoices":["😀","☠️","🤣","😎","😤","🤢","👽","💩","👿",],"animalChoices":["🐶","🐱","🐧","🐸","🐛","🦋","🐣","🐊","🐋"]]

    
    
    
    //hold the values to display the emoji for each button
    var emoji = [Int:String]()

    
    @IBOutlet weak var flipCountLabel: UILabel! //flip count label
    
    @IBOutlet var cardButtons: [UIButton]!  //array of buttons

    //Touch the buttond/card and the update the view.
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
    
    //start a new game
    @IBAction func startNewGame(_ sender: UIButton) {
        flipCount = 0
        game.restartGame()
        updateViewFromModel()
        
    }
    
    
    //display the button that was slected and if there is a match. i need the button seelcted and the card
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
    
    //randomly fill the emoji with the buttons. i use a dictionary here to store the card number with a symbol.
    
    //MARK: THis is the part i need help with. 
    func emoji(for card: Cards)->String{
        
        if emoji[card.identifier] == nil {
     
            if sportChoices.count > 0 {
                //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = sportChoices.remove(at: sportChoices.count.arc4random)
            }
        }
        
        if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        }else{
            return "?"
        }
        
    }

}
//create a random number
extension Int{
    var arc4random: Int{
        if self > 0{
        return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}

