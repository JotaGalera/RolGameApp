import Testing
@testable import LabyrinthOfShadows

struct BossModelTests {

    @Test func testThatCurrentHealthIsSetToMax_When_BossIsInitialized_And_MaxHealthProvided() {
        let boss = BossModel(name: "Goblin", abilities: ["Slash"], description: "A small goblin", maxHealth: 50, damage: 5)
        
        #expect(boss.maxHealth == 50)
        #expect(boss.currentHealth == 50)
        #expect(boss.name == "Goblin")
        #expect(boss.damage == 5)
    }

    @Test func testThatHealthIsReducedByAmount_When_UpdateHealthIsCalled_And_DoesNotDropBelowZero() {
        let boss = BossModel(name: "Troll", abilities: [], description: "A big troll", maxHealth: 40, damage: 10)
        let damaged = boss.updateHealth(amount: 15)
        #expect(damaged.currentHealth == 25)

        let overDamaged = damaged.updateHealth(amount: 100)
        #expect(overDamaged.currentHealth == 0)
    }
}
