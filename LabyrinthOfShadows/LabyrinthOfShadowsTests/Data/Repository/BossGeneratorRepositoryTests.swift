//
//  BossGeneratorRepositoryTests.swift
//  LabyrinthOfShadowsTests
//
//  Created by Javier Galera Garrido on 21/10/25.
//

import Testing
@testable import LabyrinthOfShadows

struct BossGeneratorRepositoryTests {
	@Test func testThatRepositoryReturnsBoss_When_DataSourceSucceeds() async throws {
		let expectedBoss = Boss(name: "RepoBoss", abilities: ["Stomp"], stats: [.health: 35, .strength: 6, .agility: 4], description: "repo boss")
		let generatorDataSourceMock = BossDataSourceMock()
        generatorDataSourceMock.generateBossPromptStringBossReturnValue = expectedBoss
		let sut = BossGeneratorRepositoryImplementation(generatorDataSource: generatorDataSourceMock)

		let boss = try await sut.getBosses(prompt: "prompt")

		#expect(boss.name == expectedBoss.name)
		#expect(boss.stats[.health] == expectedBoss.stats[.health])
	}
}
