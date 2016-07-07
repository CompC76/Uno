//
//  Int.swift
//  Uno
//
//  Created by Josh Birnholz on 6/2/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

extension Int {
	
	var ordinalString: String {
		var ending: String
		let ones = self % 10
		var tens = Int(floor(Double(self / 10)))
		tens = tens % 10
		if tens == 1 {
			ending = "th"
		} else {
			switch ones {
			case 1:
				ending = "st"
			case 2:
				ending = "nd"
			case 3:
				ending = "rd"
			default:
				ending = "th"
			}
		}
		return "\(self)\(ending)"
	}
	
}