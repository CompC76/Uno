import Foundation

var deck = Deck()
var pile = [Card]()
var players = [Player]()
var winners = [Player]()

let scanner = Scanner()

print("Sleep?", terminator: " ")
var shouldSleep = scanner.nextBool(true)!
ComputerPlayer.shouldSleep = shouldSleep

print("How many human players?", terminator: " ")
let humanPlayerCount = scanner.nextPositiveInt(true, allowZero: true)!

print("How many computer players?", terminator: " ")
let computerPlayerCount = scanner.nextPositiveInt(true, allowZero: true)!

for i in 0..<humanPlayerCount {
	print("Player \(players.count + 1): What is your name?", terminator: " ")
	players.append(HumanPlayer(name: scanner.next()))
}

for i in 0..<computerPlayerCount {
	let name = "COM \(i + 1)"
	players.append(ComputerPlayer(name: name))
}

var playerShouldDrawTwo = false
var playerShouldDrawFour = false
var playerShouldSkipTurn = false
var shouldReverse = false

var turnOrder = players

let totalPlayerCount = players.count

print("> Beginning the game with \(totalPlayerCount) players: \(players.contents)")
print()
if shouldSleep { sleep(1) }

deck.shuffle()
for player in players {
	player.draw(7, fromDeck: deck, pileForRefill: &pile)
}
print()

repeat {
	pile.appendContentsOf(deck.deal(pileForRefill: &pile))
	print("> Turned over a \(pile.last!) from the deck onto the pile.")
	
	switch pile.last! {
	case .Skip:
		playerShouldSkipTurn = true
	case .DrawTwo:
		playerShouldDrawTwo = true
		playerShouldSkipTurn = true
	case .Reverse:
		turnOrder = turnOrder.reverse()
		print("> The order of play has been reversed!")
	case .Wild:
		print("> \(turnOrder.first!) will choose the starting color. ")
		pile[0] = Card.Wild(turnOrder.first!.selectColor())
	case .WildDrawFour:
		print("> Returning the card to the deck and starting over.")
		print()
		deck.cards.appendContentsOf(pile)
		pile.removeAll()
		deck.shuffle()
	default:
		break
	}
	
} while pile.last!.isKindOfCard(.WildDrawFour(nil))

func handCountDescriptionForPlayer(player: Player) -> String {
	let count = player.cardsInHand.count
	return "> \(player)'s hand has \(count) \("card".pluralize(count))."
}

print()

round: while turnOrder.count > 1 {
	
	turn: for (index, currentPlayer) in turnOrder.enumerate() {
		print("> \(currentPlayer)'s Turn")
		print(handCountDescriptionForPlayer(currentPlayer))
		
		if playerShouldDrawTwo {
			currentPlayer.draw(2, fromDeck: deck, pileForRefill: &pile)
			print(handCountDescriptionForPlayer(currentPlayer))
			playerShouldDrawTwo = false
		}
		
		if playerShouldDrawFour {
			currentPlayer.draw(4, fromDeck: deck, pileForRefill: &pile)
			print(handCountDescriptionForPlayer(currentPlayer))
			playerShouldDrawFour = false
		}
		
		if playerShouldSkipTurn {
			print("> \(currentPlayer)'s turn is skipped!")
			playerShouldSkipTurn = false
			print()
			if shouldSleep { sleep(2) }
			continue turn
		}
		
		var cardsDrawn = 0
		while !(currentPlayer.cardsInHand.containsMatchForCard(pile.last!)) {
			print("> \(currentPlayer) doesn't have a card to play!")
			currentPlayer.draw(1, fromDeck: deck, pileForRefill: &pile)
			cardsDrawn += 1
			if shouldSleep { sleep(2) }
		}
		
		if cardsDrawn > 1 {
			print("> \(currentPlayer) drew \(cardsDrawn) \("card".pluralize(cardsDrawn)) total.")
		}
		
		if cardsDrawn > 0 {
			print(handCountDescriptionForPlayer(currentPlayer))
		}
		
		var playedCard = currentPlayer.selectCard(toMatch: pile.last!, deckToDrawFrom: deck)  // Assuming the pile will never be empty
		
		switch playedCard {
		case .Wild:
			playedCard = Card.Wild(currentPlayer.selectColor())
		case .WildDrawFour:
			playedCard = Card.WildDrawFour(currentPlayer.selectColor())
			playerShouldDrawFour = true
			playerShouldSkipTurn = true
		case .Skip, 
       .Reverse where players.count == 2:
			playerShouldSkipTurn = true
		case .Reverse where players.count != 2:
			let currentIndex = turnOrder.indexOf { p in return p === currentPlayer }!
			var newOrder = [Player]()
			
			for index in currentIndex..<turnOrder.count {
				newOrder.append(turnOrder[index])
			}
			
			for index in 0..<currentIndex {
				newOrder.append(turnOrder[index])
			}
			turnOrder = newOrder.reverse()
			print()
			shouldReverse = true
		case .DrawTwo:
			playerShouldDrawTwo = true
			playerShouldSkipTurn = true
		default:
			break
		}
		
		pile.append(playedCard)
		print("> \(currentPlayer) played \(pile.last!).")
		if shouldSleep { sleep(2) }
		
		
		if shouldReverse {
			print("> The order of play has been reversed!")
			if shouldSleep { sleep(2) }
		}
		
		if currentPlayer.cardsInHand.count == 1 {
			print("> Uno!")
			if shouldSleep { sleep(1) }
		}
		
//		for player in turnOrder {
//			print("\(player)'s hand:", terminator: " ")
//			for _ in 0..<player.cardsInHand.count {
//				print("🂠", terminator: "")
//			}
//			print()
//		}
//		if shouldSleep { sleep(2) }
		
		if currentPlayer.cardsInHand.isEmpty {
			winners.append(currentPlayer)
			turnOrder.removeAtIndex(index)
			let ordinal = winners.count.ordinalString
			print("> \(currentPlayer) came in \(ordinal)!")
		}
		
		print()
		
		if shouldReverse {
			shouldReverse = false
			continue round
		}
		
		
	}
	
}

print("> Game over!")
for (index, player) in winners.enumerate() {
	print("\((index + 1).ordinalString) place: \(player)")
}
print("\((winners.count+1).ordinalString) place: \(turnOrder.first!)")