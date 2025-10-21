import Testing
@testable import LabyrinthOfShadows

struct StartRunUseCaseTests {

    private struct FakeBossRepository: BossGeneratorRepository {
        let bossToReturn: Boss
        func getBosses(prompt: String) async throws -> Boss {
            return bossToReturn
        }
    }

    @Test func testThatRunIsReturned_When_StartRunUseCaseIsCalled_And_BossRepositoryReturnsBoss() async throws {
        // Given
        let expectedBoss = Boss(name: "Test Boss", abilities: ["Roar"], stats: [.health: 50, .strength: 7, .agility: 5], description: "A fake boss")
        let fakeRepo = FakeBossRepository(bossToReturn: expectedBoss)
        let sut = StartRunUseCaseImplementation(bossGenerator: fakeRepo)
        let player = Player(name: "Hero", classType: .warrior, stats: [.health: 30, .strength: 10, .agility: 6], lives: 3)

        // When
        let run = try await sut(for: player)

        // Then
        #expect(run.combats.count == 1)
        let combat = run.combats.first!
        #expect(combat.boss.name == expectedBoss.name)
        #expect(combat.player.name == player.name)
        #expect(run.currentCombatIndex == 0)
    }

}
