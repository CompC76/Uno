//
//  Deck.swift
//  Uno
//
//  Created by Josh Birnholz on 6/1/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

class Deck: CustomStringConvertible {
	
	var cards: [Card]
	
	init() {
		
		cards = [Card]()
		
		for color in Color.allColors {
			for i in 0...9 {
				cards.append(Card.Number(color, i))
				if i != 0 {
					cards.append(Card.Number(color, i))
				}
			}
			cards.append(Card.Skip(color))
			cards.append(Card.Skip(color))
			cards.append(Card.DrawTwo(color))
			cards.append(Card.DrawTwo(color))
			cards.append(Card.Reverse(color))
			cards.append(Card.Reverse(color))
			cards.append(Card.Wild(nil))
			cards.append(Card.WildDrawFour(nil))
		}
		
	}
	
	/// Shuffles the order of the cards in the Deck.
	func shuffle() {
		cards.shuffle()
		
		for (index, card) in cards.enumerate() {
			switch card {
			case .Wild:
				cards[index] = .Wild(nil)
			default:
				break
			}
		}
		
		print("> The deck has been shuffled.")
	}
	
	/// Removes `number` `Card`s from the Deck and returns them in an Array. Returns nil if the
	func deal(number: Int = 1, inout pileForRefill: [Card]) -> [Card] {
		var cardsToDeal = [Card]()
		
		for _ in 0..<number {
			if cards.count > 0 {
				cardsToDeal.append(cards.removeFirst())
			} else {
				reconstructFromPile(&pileForRefill)
				cardsToDeal.append(cards.removeFirst())
			}
		}
		
		return cardsToDeal
	}
	
	func reconstructFromPile( inout pile: [Card]) {
		cards = pile
		pile = [cards.last!]
		shuffle()
	}
	
	var description: String {
		var desc = "\(cards.count) cards in the deck:\n"
		for card in cards{
			desc += "- \(card)\n"
		}
		return desc
	}
	
}