//
//  Input.swift
//  Uno
//
//  Created by Josh Birnholz on 6/1/16.
//  Copyright © 2016 Josh Birnholz. All rights reserved.
//

import Foundation

class Scanner {
	
	let fileHandle: NSFileHandle!
	
	init() {
		fileHandle = NSFileHandle.fileHandleWithStandardInput()
	}
	
	func next() -> String {
		let inputData = fileHandle.availableData
		return (NSString(data: inputData, encoding: NSUTF8StringEncoding)!.string) - "\n"
	}
	
	func nextInt( force: Bool = false) -> Int? {
		
		if force {
			guard let value = Int(next()) else {
//				print("Please enter a valid Integer value.", terminator: " ")
				return nextInt(force)
			}
			return value
		}
		
		return Int(next())
	}
	
	func nextPositiveInt(force: Bool = false, allowZero: Bool = false) -> Int? {
		
		guard let value = nextInt(force) else {
			return nextPositiveInt(force)
		}
		
		guard value > 0 || (value >= 0 && allowZero) else {
//			print("Please enter a positive number.", terminator: " ")
			return nextPositiveInt(force)
		}
		return value
	}
	
	func nextBool(force: Bool = false) -> Bool? {
		var bool: Bool?
		let str = next().lowercaseString
		
		switch str {
		case "false", "f", "no", "n":
			bool = false
		case "true", "t", "yes", "y":
			bool =  true
		default:
			bool = nil
		}
		
		if force {
			guard bool != nil else {
//				print("Please enter a valid Boolean value (true, false, yes, or no).", terminator: " ")
				return nextBool(force)
			}
		}
		
		return bool
	}
	
	func nextDouble() -> Double? {
		return Double(next())
	}
	
	func nextFloat() -> Float? {
		return Float(next())
	}
	
}

