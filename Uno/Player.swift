//
//  Player.swift
//  Uno
//
//  Created by Josh Birnholz on 6/2/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

protocol Player: class {
	
	/// The name of the player.
	var name: String { get set }
	
	/// An array of cards the player is currently holding.
	var cardsInHand: [Card] { get set }
	
	/// Adds the specified number of cards from the specified deck to the player's hand.
	func draw(numberOfCards: Int, fromDeck deck: Deck, inout pileForRefill: [Card])
	
	/// Initializes a new Player with the specified name.
	init(name: String)
	
	/// Asks the player to choose a card from their hand that matches a specified card. The chosen card should be returned.
	///
	/// If the player isn't holding a playable card, a card should be drawn from the deck before being asked to choose.
	func selectCard(toMatch cardToMatch: Card, deckToDrawFrom deck: Deck) -> Card
	
	/// Asks the user to select a `Color` for a Wild card.
	func selectColor() -> Color
}