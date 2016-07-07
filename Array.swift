import Foundation

extension Array {
	
	func elementExistsAtIndex(index: Int) -> Bool {
		return index >= 0 && index < self.count
	}
	
	var contents: String {
		return map { String($0) }.joinWithSeparator(", ")
	}
	
	func random(amount: Int) -> [Element] {
		var selectedIndexes = [Int]()
		
		var sample = [Element]()
		for _ in 0 ..< amount {
			var index = -1
			while !selectedIndexes.contains(index) {
				index = Int(arc4random_uniform(UInt32(self.count)))
			}
			selectedIndexes.append(index)
			sample.append(self[index])
		}
		
		return sample
	}
	
	var random: Element {
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
	
	var flattened: [Element] {
		return self.flatMap {$0}
	}
	
}

extension Array where Element:NSCoding {
	
	/**
	Converts the array to an `NSData` object and writes it to the file specified by a given path.
	
	**Note:** The type of the elements stored in the array must conform to the protcol `NSCoding`.
	- parameter path: The location to which to write the receiver's bytes. If path contains a tilde (~) character, you must expand it with stringByExpandingTildeInPath before invoking this method.
	- parameter atomically: If `true`, the data is written to a backup file, and then—assuming no errors occur—the backup file is renamed to the name specified by path; otherwise, the data is written directly to `path`.
	- returns: `true` if the operation succeeds, otherwise `false`.
	*/
	func writeToFile(path: String, atomically useAuxiliaryFile: Bool) -> Bool {
		return NSKeyedArchiver.archivedDataWithRootObject(self as NSArray).writeToFile(path, atomically: useAuxiliaryFile)
	}
	
}

/// Appends the items in the array to the array, the number of times specified.
func * <T: Any>(lhs: [T], rhs: Int) -> [T] {
	
	var array = [T]()
	
	for _ in 0..<rhs {
		array += lhs
	}
	
	return array
	
}