//
//  Color.swift
//  Uno
//
//  Created by Josh Birnholz on 6/1/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

enum Color {
	case Blue
	case Red
	case Green
	case Yellow
	
	static let allColors = [Blue, Red, Green, Yellow]
	
	static func random() -> Color {
		switch randomInt(within: 0..<4) {
		case 0:
			return .Blue
		case 1:
			return .Red
		case 2:
			return .Green
		case 3:
			return .Yellow
		default:
			return .Blue
		}
	}
}

extension Scanner {
	func nextColor() -> Color? {
		let scanner = Scanner()
		let str = scanner.next().lowercaseString
		switch str {
		case "red", "r":
			return .Red
		case "blue", "b":
			return .Blue
		case "green", "g":
			return .Green
		case "yellow", "y":
			return .Yellow
		default:
			return nil
		}
	}
}
