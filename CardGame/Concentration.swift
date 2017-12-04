//
//  Concentration.swift
//  CardGame
//
//  Created by Curtis Wiseman on 12/2/17.
//  Copyright © 2017 Curtis Wiseman. All rights reserved.
//

import Foundation


class Concentration {
    
    var cards = [Cards]()
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFacedUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            
            for index in cards.indices{
                cards[index].isFacedUp = (index == newValue)
            }
            
        }
    }//keep track if there one and only card face up
    
    //1)no cards are face up
    //2) two cards are face up either matching or not matching
    //3)one card face up and see if they match
    func chooseCard(at index: Int){
    
        
        //first ignore all match cards
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
                //indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //either no cards or 2 cards are face up
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFacedUp = false
//
//                }
//                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
             }
        }
       
    }
    
    
    
    init(numberOfPairOfCards: Int) {
        for _ in 1...numberOfPairOfCards{
            let card = Cards()
            let matchingCard = card
            cards.append(card)
            cards.append(matchingCard)
        }
        cards.shuffle()
        
        
    }
    
    func restartGame(){
        for index in cards.indices{
            cards[index].isFacedUp = false
            cards[index].isMatched = false 
        }
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0..<((count>0) ? (count-1) : 0) {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
