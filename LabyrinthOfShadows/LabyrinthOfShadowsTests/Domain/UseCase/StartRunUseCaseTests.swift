import Testing
@testable import LabyrinthOfShadows

struct StartRunUseCaseTests {
    @Test func testThatRunIsReturned_When_StartRunUseCaseIsCalled_And_BossRepositoryReturnsBoss() async throws {
        let expectedBoss = Boss(name: "Test Boss", abilities: ["Roar"], stats: [.health: 50, .strength: 7, .agility: 5], description: "A fake boss")
        let bossGeneratorRepositoryMock = BossGeneratorRepositoryMock()
        bossGeneratorRepositoryMock.getBossesPromptStringBossReturnValue = expectedBoss
        let sut = StartRunUseCaseImplementation(bossGenerator: bossGeneratorRepositoryMock)
        let player = Player(name: "Hero", classType: .warrior, stats: [.health: 30, .strength: 10, .agility: 6], lives: 3)

        let run = try await sut(for: player)

        #expect(run.combats.count == 1)
        let combat = run.combats.first!
        #expect(combat.boss.name == expectedBoss.name)
        #expect(combat.player.name == player.name)
        #expect(run.currentCombatIndex == 0)
    }
}
