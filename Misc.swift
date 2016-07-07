import Foundation

enum ANSIColors: String {
	case black = "\u{001B}[0;30m"
	case red = "\u{001B}[0;31m"
	case green = "\u{001B}[0;32m"
	case yellow = "\u{001B}[0;33m"
	case blue = "\u{001B}[0;34m"
	case magenta = "\u{001B}[0;35m"
	case cyan = "\u{001B}[0;36m"
	case white = "\u{001B}[0;37m"
	
	func name() -> String {
		switch self {
		case black: return "Black"
		case red: return "Red"
		case green: return "Green"
		case yellow: return "Yellow"
		case blue: return "Blue"
		case magenta: return "Magenta"
		case cyan: return "Cyan"
		case white: return "White"
		}
	}
	
	static func all() -> [ANSIColors] {
		return [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white]
	}
}

func + ( left: ANSIColors, right: String) -> String {
	return left.rawValue + right
}

extension CollectionType {
	/// Return a copy of `self` with its elements shuffled.
	func shuffled() -> [Generator.Element] {
		var list = Array(self)
		list.shuffle()
		return list
	}
}

extension MutableCollectionType where Index == Int {
	/// Shuffle the elements of `self` in-place.
	mutating func shuffle() {
		// empty and single-element collections don't shuffle
		if count < 2 { return }
		
		for i in 0..<count - 1 {
			let j = Int(arc4random_uniform(UInt32(count - i))) + i
			guard i != j else { continue }
			swap(&self[i], &self[j])
		}
	}
}