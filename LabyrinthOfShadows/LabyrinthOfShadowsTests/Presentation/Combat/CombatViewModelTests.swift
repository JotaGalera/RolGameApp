import Testing
@testable import LabyrinthOfShadows

struct CombatViewModelTests {

	private struct FakeStartRunUseCase: StartRunUseCase {
		let run: Run
		func callAsFunction(for player: Player) async throws -> Run {
			return run
		}
	}

    @MainActor
	@Test func testThatBossIsSet_When_startNewRunIsCalled_And_StartRunUseCaseReturnsRun() async throws {
		let bossName = "Stone Ogre"
        let sut = makeSut(bossName: bossName)

		await sut.startNewRun()

        #expect(sut.boss?.name == bossName)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        // Due to Player and Boss have the same Agility
        #expect(sut.isPlayerTurn == true)
	}

    @MainActor
	@Test func testThatPerformActionAttackReducesBossHealth_When_PerformActionIsCalled_And_PlayerDamageIsCalculated() async throws {
        let expectedPlayerDamage = 3
        let expectedBossDamage = 1
        let bossName = "Stone Ogre"
        let sut = makeSut(bossName: bossName)
		await sut.startNewRun()
        let initialBossHealth = sut.boss!.currentHealth
        let initialPlayerHealth = sut.player!.currentHealth

        sut.performAction(.attack)

        #expect(sut.boss?.currentHealth == max(initialBossHealth - expectedPlayerDamage, 0))
        #expect(sut.player?.currentHealth == max(initialPlayerHealth - expectedBossDamage, 0))
        // Turn should have returned to player
        #expect(sut.isPlayerTurn == true)
	}

    @MainActor
    private func makeSut(bossName: String) -> CombatViewModel {
        let boss = Boss(name: bossName, abilities: [], stats: [.health: 40, .strength: 0, .agility: 5], description: "A test boss")
        let player = Player(name: "Tester", classType: .warrior, stats: [.health: 30, .strength: 10, .agility: 5], lives: 3)
        let combat = Combat(player: player, boss: boss)
        let run = Run(combats: [combat], currentCombatIndex: 0)
        let fakeUseCase = FakeStartRunUseCase(run: run)
        return CombatViewModel(startRunUseCase: fakeUseCase)
    }
}


