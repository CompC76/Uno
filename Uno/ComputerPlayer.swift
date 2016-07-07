//
//  ComputerPlayer.swift
//  Uno
//
//  Created by Josh Birnholz on 6/1/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

postfix operator ++ {}

postfix func ++ (inout number: Int) -> Int {
	number += 1
	return number
}

class ComputerPlayer: HumanPlayer {
	
	static var shouldSleep = false
	
	var maxColorInHand: Color {
		var blueCount = 0
		var redCount = 0
		var greenCount = 0
		var yellowCount = 0
		
		for card in cardsInHand.flattened where card.color != nil {
			switch card.color! {
			case .Blue:
				blueCount += 1
			case .Green:
				greenCount += 1
			case .Red:
				redCount += 1
			case .Yellow:
				yellowCount += 1
			}
		}
		
		let counts = [(color: Color.Blue, count: blueCount), (color: Color.Red, count: redCount), (color: Color.Green, count: greenCount), (color: Color.Yellow, count: yellowCount)].shuffled()
		
		var max = 0
		var color = Color.random()
		for i in counts {
			if i.count > max {
				max = i.count
				color = i.color
			}
		}
		
		return color
	}
	
	override func showHand() {
		print("\(name) is thinking", terminator: "")
		let secondsToSleep = arc4random_uniform(2) + 3
		for _ in 0..<secondsToSleep {
			print(".", terminator: "")
			if self.dynamicType.shouldSleep { sleep(1) }
		}
		print()
	}
	
	override func selectCard(toMatch cardToMatch: Card, deckToDrawFrom deck: Deck) -> Card {
		var playableCardIndices = [Int]()
		showHand()
		
		for (index, card) in cardsInHand.enumerate() {
			if card =? cardToMatch {
				playableCardIndices.append(index)
			}
		}
		
		let maxColor = maxColorInHand
		
		var playableCardIndicesOfMaxColor = [Int]()
		
		for index in playableCardIndices where cardsInHand[index].color != nil {
			if cardsInHand[index].color! == maxColor {
				playableCardIndicesOfMaxColor.append(index)
			}
		}
		
		let selectedIndex = playableCardIndicesOfMaxColor.count > 0 ? playableCardIndicesOfMaxColor.random : playableCardIndices.random
		return cardsInHand.removeAtIndex(selectedIndex)
		
	}
	
	override func selectColor() -> Color {
		return maxColorInHand
	}
	
	
	
}