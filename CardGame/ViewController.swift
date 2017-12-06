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
    
    var counter = 0
    
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
        counter += 1
        emoji.removeAll()
        
    }
    
    
    //display the button that was slected and if there is a match. i need the button seelcted and the card
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp{
                if (counter % 3) == 1{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                if (counter % 3) == 2{
                    button.setTitle(emoji(for2: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                if (counter % 3) == 0{
                    button.setTitle(emoji(for3: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        
    }
    
    //randomly fill the emoji with the buttons. i use a dictionary here to store the card number with a symbol.
    
    //MARK: THis is the part i need help with.
    func emoji(for Sportscard: Cards)->String{
        
        if emoji[Sportscard.identifier] == nil {
     
            if sportChoices.count > 0 {
                //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[Sportscard.identifier] = sportChoices.remove(at: sportChoices.count.arc4random)
            }
        }
        
        if emoji[Sportscard.identifier] != nil {
            return emoji[Sportscard.identifier]!
        }else{
            return "?"
        }
        
    }
    
    func emoji(for2 Emojicard: Cards)->String{
        
        if emoji[Emojicard.identifier] == nil {
            
            if emojiChoices.count > 0 {
                //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[Emojicard.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        }
        
        if emoji[Emojicard.identifier] != nil {
            return emoji[Emojicard.identifier]!
        }else{
            return "?"
        }
        
    }
    
    func emoji(for3 animalCard: Cards)->String{
        
        if emoji[animalCard.identifier] == nil {
            
            if animalChoices.count > 0 {
                //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[animalCard.identifier] = animalChoices.remove(at: animalChoices.count.arc4random)
            }
        }
        
        if emoji[animalCard.identifier] != nil {
            return emoji[animalCard.identifier]!
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

