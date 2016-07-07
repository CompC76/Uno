import Foundation

extension NSFileManager {
	
	/**
	Returns a Boolean value that indicates whether a file or directory exists at a specified path. If the file at the specified path does not exist, this method returns `nil`.
	- parameter path: The path of a file or directory. If `path` begins with a tilde (~), it must first be expanded with stringByExpandingTildeInPath, or this method will return false.
	- returns: `true` if `path` is a directory or if the final path element is a symbolic link that points to a directory; otherwise, `false`. If `path` doesn’t exist, this value is `nil` upon return.
	*/
	func fileIsDirectoryAtPath(path: String) -> Bool? {
		
		var isDirectory: ObjCBool = false
		
		let exists = fileExistsAtPath(path, isDirectory: &isDirectory)
		
		return exists ? Bool(isDirectory) : nil
		
	}
	
}