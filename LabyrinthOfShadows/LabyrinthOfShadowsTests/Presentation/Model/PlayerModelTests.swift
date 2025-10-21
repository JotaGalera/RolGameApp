import Testing
@testable import LabyrinthOfShadows

struct PlayerModelTests {

    @Test func testThatCurrentHealthAndLivesAreSetToMax_When_PlayerIsInitialized_And_MaxValuesProvided() {
        let player = PlayerModel(name: "Ayla", classType: .mage, maxHealth: 60, maxLives: 3, damage: 8)
        
        #expect(player.maxHealth == 60)
        #expect(player.currentHealth == 60)
        #expect(player.maxLives == 3)
        #expect(player.currentLives == 3)
        #expect(player.classType == .mage)
    }

    @Test func testThatHealthIsReducedByAmountAndClampedAtZero_When_UpdateHealthIsCalled_And_DamageExceedsCurrentHealth() {
        let player = PlayerModel(name: "Korr", classType: .warrior, maxHealth: 45, maxLives: 3, damage: 12)
        let damaged = player.updateHealth(amount: 10)
        #expect(damaged.currentHealth == 35)

        let fatal = damaged.updateHealth(amount: 100)
        #expect(fatal.currentHealth == 0)
    }
}
