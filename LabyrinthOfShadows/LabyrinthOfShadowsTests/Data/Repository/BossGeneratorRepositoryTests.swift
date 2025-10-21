//
//  BossGeneratorRepositoryTests.swift
//  LabyrinthOfShadowsTests
//
//  Created by Javier Galera Garrido on 21/10/25.
//

import Testing
@testable import LabyrinthOfShadows

struct BossGeneratorRepositoryTests {

	private struct FakeDataSource: BossDataSource {
		let bossToReturn: Boss
		func generateBoss(prompt: String) async throws -> Boss {
			return bossToReturn
		}
	}

	@Test func testThatRepositoryReturnsBoss_When_DataSourceSucceeds() async throws {
		// Given
		let expectedBoss = Boss(name: "RepoBoss", abilities: ["Stomp"], stats: [.health: 35, .strength: 6, .agility: 4], description: "repo boss")
		let fake = FakeDataSource(bossToReturn: expectedBoss)
		let sut = BossGeneratorRepositoryImplementation(generatorDataSource: fake)

		// When
		let boss = try await sut.getBosses(prompt: "prompt")

		// Then
		#expect(boss.name == expectedBoss.name)
		#expect(boss.stats[.health] == expectedBoss.stats[.health])
	}

}
