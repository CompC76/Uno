//
//  Card.swift
//  Uno
//
//  Created by Josh Birnholz on 6/1/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

infix operator =? {}

func =? (lhs: Card, rhs: Card) -> Bool {
	var number1: Int?
	var number2: Int?
	var color1: Color?
	var color2: Color?
	
	switch lhs {
	case .Number(let c, let i):
		color1 = c
		number1 = i
	case .Skip(let c):
		color1 = c
	case .DrawTwo(let c):
		color1 = c
	case .Reverse(let c):
		color1 = c
	case .Wild:
		return true
	case .WildDrawFour:
		return true
	}
	
	switch rhs {
	case .Number(let c, let i):
		color2 = c
		number2 = i
	case .Skip(let c):
		color2 = c
	case .DrawTwo(let c):
		color2 = c
	case .Reverse(let c):
		color2 = c
	case .Wild(nil):
		return true
	case .WildDrawFour(nil):
		return true
	case .Wild(let c):
		color2 = c
	case .WildDrawFour(let c):
		color2 = c
	}
	
	if number1 != nil && number2 != nil {
		if number1! == number2! {
			return true
		}
	}
	
	if color1 != nil && color2 != nil {
		if color1! == color2! {
			return true
		}
	}
	
	switch (lhs, rhs) {
	case (.Skip, .Skip):
		return true
	case (.DrawTwo, .DrawTwo):
		return true
	case (.Reverse, .Reverse):
		return true
	default:
		return false
	}

}

enum Card: CustomStringConvertible {
	case Number(Color, Int)
	case Skip(Color)
	case DrawTwo(Color)
	case Reverse(Color)
	case Wild(Color?)
	case WildDrawFour(Color?)
	
	var description: String {
		switch self {
		case .Number(let color, let value):
			return "\(color) \(value)"
		case .Skip(let color):
			return "\(color) Skip"
		case .DrawTwo(let color):
			return "\(color) Draw Two"
		case .Reverse(let color):
			return "\(color) Reverse"
		case .Wild(nil):
			return "Wild"
		case .Wild(let color):
			return "Wild (\(color!))"
		case .WildDrawFour(nil):
			return "Wild Draw Four"
		case .WildDrawFour(let color):
			return "Wild Draw Four (\(color!))"
		}
	}
	
	func isKindOfCard(card: Card) -> Bool {
		switch (self, card) {
		case (.Number, .Number):
			return true
		case (.Skip, .Skip):
			return true
		case (.DrawTwo, .DrawTwo):
			return true
		case (.Reverse, .Reverse):
			return true
		case (.Wild, .Wild):
			return true
		case (.WildDrawFour, .WildDrawFour):
			return true
		default:
			return false
		}
	}
	
	var color: Color? {
		switch self {
		case .Number(let color, _):
			return color
		case .Skip(let color):
			return color
		case .DrawTwo(let color):
			return color
		case .Reverse(let color):
			return color
		case .Wild(nil):
			return nil
		case .Wild(let color):
			return color
		case .WildDrawFour(nil):
			return nil
		case .WildDrawFour(let color):
			return color
		}
	}
	
}

extension SequenceType where Generator.Element == Card {
	func containsMatchForCard(cardToMatch: Card) -> Bool {
		for card: Card in self {
			if card =? cardToMatch {
				return true
			}
		}
		return false
	}
}