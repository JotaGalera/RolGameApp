//
//  CheckCombatVictoryConditionUseCaseTests.swift
//  LabyrinthOfShadowsTests
//
//  Created by Javier Galera Garrido on 23/10/25.
//

import Testing
@testable import LabyrinthOfShadows

struct CheckCombatVictoryConditionUseCaseTests {

	@Test func testThatPlayerVictoryIsReturned_When_BossHealthIsZero() {
		// Given
		let boss = Boss(name: "Dead Boss", abilities: [], stats: [.health: 0], description: "")
		let player = Player(name: "Hero", classType: .warrior, stats: [.health: 10], lives: 3)
		let sut = CheckCombatVictoryConditionUseCaseImplementation()

		// When
		let result = sut.callAsFunction(player: player, boss: boss)

		// Then
		#expect(result == .playerVictory)
	}

	@Test func testThatPlayerDefeatIsReturned_When_PlayerLivesAreZero() {
		// Given
		let boss = Boss(name: "Boss", abilities: [], stats: [.health: 10], description: "")
		var player = Player(name: "Hero", classType: .warrior, stats: [.health: 10], lives: 0)
		let sut = CheckCombatVictoryConditionUseCaseImplementation()

		// When
		let result = sut.callAsFunction(player: player, boss: boss)

		// Then
		#expect(result == .playerDefeat)
	}

	@Test func testThatOngoingIsReturned_When_PlayerHealthIsZeroButHasRemainingLives() {
		// Given
		let boss = Boss(name: "Boss", abilities: [], stats: [.health: 10], description: "")
		var player = Player(name: "Hero", classType: .warrior, stats: [.health: 0], lives: 2)
		let sut = CheckCombatVictoryConditionUseCaseImplementation()

		// When
		let result = sut.callAsFunction(player: player, boss: boss)

		// Then
		#expect(result == .ongoing)
	}

	@Test func testThatOngoingIsReturned_When_BothHavePositiveHealthAndLives() {
		// Given
		let boss = Boss(name: "Boss", abilities: [], stats: [.health: 20], description: "")
		let player = Player(name: "Hero", classType: .warrior, stats: [.health: 15], lives: 3)
		let sut = CheckCombatVictoryConditionUseCaseImplementation()

		// When
		let result = sut.callAsFunction(player: player, boss: boss)

		// Then
		#expect(result == .ongoing)
	}

}

