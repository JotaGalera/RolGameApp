import Testing
@testable import LabyrinthOfShadows

struct CombatViewModelTests {
    var startRunUseCaseMock = StartRunUseCaseMock()
    var checkVictoryConditionUseCaseMock = CheckCombatVictoryConditionUseCaseMock()
    
    @MainActor
	@Test func testThatBossIsSet_When_startNewRunIsCalled_And_StartRunUseCaseReturnsRun() async throws {
		let bossName = "Stone Ogre"
        let sut = makeSut(bossName: bossName)

		await sut.startNewRun()

        #expect(sut.boss?.name == bossName)
        #expect(sut.errorMessage == nil)
        #expect(startRunUseCaseMock.callAsFunctionForPlayerPlayerRunCallsCount == 1)
        // Due to Player and Boss have the same Agility
        #expect(sut.isPlayerTurn == true)
        // View state should be updated to inProgress when ongoing
        #expect(sut.viewState == .inProgress)
        #expect(checkVictoryConditionUseCaseMock.callAsFunctionPlayerPlayerBossBossCombatVictoryConditionCallsCount == 1)
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
        // Third time is because boss is attacking automatically after player attack
        #expect(checkVictoryConditionUseCaseMock.callAsFunctionPlayerPlayerBossBossCombatVictoryConditionCallsCount == 3)
        #expect(sut.viewState == .inProgress)
	}

    @MainActor
    @Test func testThatViewStateBecomesRunVictory_When_nextCombatCalled_And_NoMoreCombatsRemain() async throws {
        // Given: a run with a single combat
        let bossName = "Final Boss"
        let boss = Boss(name: bossName, abilities: [], stats: [.health: 40, .strength: 0, .agility: 5], description: "")
        let player = Player(name: "Tester", classType: .warrior, stats: [.health: 30, .strength: 10, .agility: 5], lives: 3)
        let combat = Combat(player: player, boss: boss)
        let run = Run(combats: [combat], currentCombatIndex: 0)

        let sut = makeSut(bossName: bossName, run: run, victoryReturn: .ongoing)
        await sut.startNewRun()

        // When: advance to next combat (none left)
        sut.nextCombat()

        // Then: viewState should indicate run victory
        #expect(sut.viewState == .runVictory)
    }

    @MainActor
    @Test func testThatViewStateBecomesDefeat_When_nextCombatCalled_And_PlayerIsDead() async throws {
        // Given: a run whose last combat has a dead player
        let bossName = "Final Boss"
        let boss = Boss(name: bossName, abilities: [], stats: [.health: 40, .strength: 0, .agility: 5], description: "")
        let player = Player(name: "Tester", classType: .warrior, stats: [.health: 0, .strength: 10, .agility: 5], lives: 0)
        let combat = Combat(player: player, boss: boss)
        let run = Run(combats: [combat], currentCombatIndex: 0)

        let sut = makeSut(bossName: bossName, run: run, victoryReturn: .playerDefeat)
        await sut.startNewRun()

        // When: attempt to go to next combat (none left because player is dead)
        sut.nextCombat()

        // Then: viewState should indicate defeat
        #expect(sut.viewState == .defeat)
    }
    
    @MainActor
    private func makeSut(bossName: String, run: Run? = nil, victoryReturn: CombatVictoryCondition = .ongoing) -> CombatViewModel {
        let bossMock = Boss(name: bossName, abilities: [], stats: [.health: 40, .strength: 0, .agility: 5], description: "A test boss")
        let playerMock = Player(name: "Tester", classType: .warrior, stats: [.health: 30, .strength: 10, .agility: 5], lives: 3)
        let combatMock = Combat(player: playerMock, boss: bossMock)
        let runMock = run ?? Run(combats: [combatMock], currentCombatIndex: 0)
        startRunUseCaseMock.callAsFunctionForPlayerPlayerRunReturnValue = runMock
        checkVictoryConditionUseCaseMock.callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReturnValue = victoryReturn

        return CombatViewModel(startRunUseCase: startRunUseCaseMock, checkVictoryConditionUseCase: checkVictoryConditionUseCaseMock)
    }
}


