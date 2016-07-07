import Foundation

extension String {
	
	/// Modifies a `String` by removing any non-numeric characters.
	mutating func numericize() {
		let digits: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
		var textWithOnlyDigits = ""
		for character in self.characters {
			if digits.contains(character) {
				textWithOnlyDigits = textWithOnlyDigits + String(character)
			}
		}
		self = textWithOnlyDigits
	}
	
	/// Returns a new `String` by removing any non-numeric characters from a String.
	func stringByNumericizing() -> String {
		let digits: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
		var textWithOnlyDigits = ""
		for character in self.characters {
			if digits.contains(character) {
				textWithOnlyDigits = textWithOnlyDigits + String(character)
			}
		}
		return textWithOnlyDigits
	}
	
	/**
	Modifies a `String` to replace any instances of a certain `Character` with a `String` of any length.
	- parameter target: The original `Character` to be replaced.
	- parameter replacement: The `String` with which to replace the original `Character`.
	*/
	mutating func replace(target: String, withString replacement: String) {
		self = self.stringByReplacingOccurrencesOfString(target, withString: replacement)
	}
	
	/**
	Removes all occurrances of a target `String` from a String.
	- parameter target: The `String` to be stripped out.
	*/
	mutating func strip(target: String) {
		self.replace(target, withString: "")
	}
	
	/**
	Returns a new string made by appending to the receiver a given string.
	
	Availability: iOS (8.0 and later)
	- parameter aString: The path component to append to the receiver.
	- returns: A new string made by appending aString to the receiver, preceded if necessary by a path separator.
	*/
	func stringByAppendingPathComponent(aString: String) -> String {
		
		let nsStr = self as NSString
		
		return nsStr.stringByAppendingPathComponent(aString)
	}
	
	/**
	Returns a new string that is a substring of this string for the indexes specified by a Range.
	
	Examples:
	
	"hamburger"[4..<8] == "urge"
	"smiles"[1...5] == "miles"
	
	- parameter range: The range of `Character`s to include in the substring.
	- returns: The specified substring.
	*/
	subscript (range: Range<Int>) -> String {
		get {
			let startIndex = self.startIndex.advancedBy(range.startIndex)
			let endIndex = startIndex.advancedBy(range.endIndex - range.startIndex)
			
			return self[Range(startIndex ..< endIndex)]
		}
	}
	
	/**
	Returns a new string that is a substring of this string. The substring begins with the character at the specified index and extends to the end of this string.
	
	Examples:
	
	"unhappy"[2] == "happy"
	"Harbison"[3] == "bison"
	"emptiness"[9] == ""
	
	- parameter beginIndex: The beginning index, inclusive.
	- returns: The specified substring.
	*/
	subscript (fromIndex: Int) -> String {
		get {
			return self[Range(self.startIndex.advancedBy(fromIndex) ..< self.endIndex)]
		}
	}
	
	/**
	Returns the `Character` value at the specified index.
	- parameter index: The index of the `Character` value.
	- returns: The `Character` value at the specified index of this string. The first char value is at index 0.
	*/
	func characterAtIndex(index: Int) -> Character {
		return Character(self[index...index + 1])
	}
	
	var nsString: NSString {
		return self as NSString
	}
}

/// Returns a new String created by removing all occurrances of the String on the right hand side of the operator from the String on the left hand side, replacing them with empty space.
func - (lhs: String, rhs: String) -> String {
	return lhs.stringByReplacingOccurrencesOfString(rhs, withString: "")
}