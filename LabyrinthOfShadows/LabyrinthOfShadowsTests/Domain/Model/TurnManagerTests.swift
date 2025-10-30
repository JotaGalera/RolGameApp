//
//  TurnManagerTests.swift
//  LabyrinthOfShadowsTests
//
//  Created by Javier Galera Garrido on 29/10/25.
//

import Testing
@testable import LabyrinthOfShadows

struct TurnManagerTests {

	@Test func testThatTurnOrderIsPlayerThenBoss_When_PlayerAndBossHaveEqualAgility() {
		let player = Player(name: "P", classType: .warrior, stats: [.agility: 5, .health: 10], lives: 3)
		let boss = Boss(name: "B", abilities: [], stats: [.agility: 5, .health: 10], description: "")
		let manager = TurnManagerImplementation(player: player, boss: boss)

		let first = manager.getCurrentTurn()
		#expect(first.participant == .player)

		let second = manager.nextTurn()
		#expect(second.participant == .boss)

		let third = manager.nextTurn()
		#expect(third.participant == .player)
	}

	@Test func testThatPlayerGetsExtraTurns_When_PlayerAgilityIsTenHigherThanBoss() {
		let player = Player(name: "P", classType: .warrior, stats: [.agility: 15, .health: 10], lives: 3)
		let boss = Boss(name: "B", abilities: [], stats: [.agility: 5, .health: 10], description: "")
		let manager = TurnManagerImplementation(player: player, boss: boss)

		let t1 = manager.getCurrentTurn()
		#expect(t1.participant == .player)

		let t2 = manager.nextTurn()
		#expect(t2.participant == .player)

		let t3 = manager.nextTurn()
		#expect(t3.participant == .boss)
	}

	@Test func testThatBossGetsMultipleExtraTurns_When_BossAgilityIsMuchHigher() {
		let player = Player(name: "P", classType: .thief, stats: [.agility: 5, .health: 10], lives: 3)
		let boss = Boss(name: "B", abilities: [], stats: [.agility: 25, .health: 10], description: "")
		let manager = TurnManagerImplementation(player: player, boss: boss)

		let t1 = manager.getCurrentTurn()
		#expect(t1.participant == .boss)

		let t2 = manager.nextTurn()
		#expect(t2.participant == .boss)

		let t3 = manager.nextTurn()
		#expect(t3.participant == .boss)

		let t4 = manager.nextTurn()
		#expect(t4.participant == .player)
	}

	@Test func testThatGetCurrentAndNextTurnCycle_When_CalledRepeatedly() {
		let player = Player(name: "P", classType: .mage, stats: [.agility: 5, .health: 10], lives: 3)
		let boss = Boss(name: "B", abilities: [], stats: [.agility: 5, .health: 10], description: "")
		let manager = TurnManagerImplementation(player: player, boss: boss)

		let expected: [Participant] = [.player, .boss, .player, .boss, .player]
		var results: [Participant] = []
		for _ in 0..<5 {
			results.append(manager.getCurrentTurn().participant)
			_ = manager.nextTurn()
		}

		#expect(results == expected)
	}

}

