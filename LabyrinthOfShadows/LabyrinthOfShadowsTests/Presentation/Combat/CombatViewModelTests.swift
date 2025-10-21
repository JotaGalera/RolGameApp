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
	}

    @MainActor
	@Test func testThatPerformActionAttackReducesBossHealth_When_PerformActionIsCalled_And_PlayerDamageIsCalculated() async throws {
        let expectedDamage = 3
        let bossName = "Stone Ogre"
        let sut = makeSut(bossName: bossName)
		await sut.startNewRun()
        let initialHealth = sut.boss!.currentHealth

        sut.performAction(.attack)

		#expect(sut.boss?.currentHealth == max(initialHealth - expectedDamage, 0))
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


