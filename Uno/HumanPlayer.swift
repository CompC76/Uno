//
//  Player.swift
//  Uno
//
//  Created by Josh Birnholz on 6/1/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

class HumanPlayer: Player, CustomStringConvertible {
	
	var name: String
	
	var cardsInHand = [Card]()
	
	required init(name: String) {
		self.name = name
	}
	
	func draw(numberOfCards: Int = 1, fromDeck deck: Deck, inout pileForRefill: [Card]) {
		cardsInHand.appendContentsOf(deck.deal(numberOfCards, pileForRefill: &pileForRefill))
		print("> \(name) drew \(numberOfCards) \("card".pluralize(numberOfCards)).")
	}

	func showHand() {
		for (index, card) in cardsInHand.enumerate() {
			print("- \(index): \(card)")
		}
	}
	
	var handCountString: String {
		let count = cardsInHand.count
		return "> \(name)'s hand has \(count) \("card".pluralize(count))."
	}
	
	func selectCard(toMatch cardToMatch: Card, deckToDrawFrom deck: Deck) -> Card {
		showHand()
		
		let scanner = Scanner()
		
		print("The card to match is: \(cardToMatch).")
		
		print("Enter the index of a card to play:", terminator: " ")
		guard let selectedIndex = scanner.nextInt() else {
			print("Please enter a valid integer.")
			return selectCard(toMatch: cardToMatch, deckToDrawFrom: deck)
		}
		
		guard cardsInHand.elementExistsAtIndex(selectedIndex) else {
			print("You don't have a card in your hand at that index.")
			return selectCard(toMatch: cardToMatch, deckToDrawFrom: deck)
		}
		
		let selectedCard = cardsInHand[selectedIndex]
		
		
		if selectedCard =? cardToMatch {
			cardsInHand.removeAtIndex(selectedIndex)
			return selectedCard
		} else {
			print("\n\(selectedCard) doesn't match \(cardToMatch).\n")
			return selectCard(toMatch: cardToMatch, deckToDrawFrom: deck)
		}
		
	}
	
	func selectColor() -> Color {
		
		showHand()
		
		print("Choose a color:", terminator: " ")
		let scan = Scanner()
		if let color = scan.nextColor() {
			return color
		} else {
			print("Please enter a valid color.")
			return selectColor()
		}
	}
	
	var description: String {
		return name
	}
}
