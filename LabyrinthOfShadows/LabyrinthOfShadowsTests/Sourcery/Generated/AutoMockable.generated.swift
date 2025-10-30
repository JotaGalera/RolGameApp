// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import SwiftUI
@testable import LabyrinthOfShadows
#elseif os(OSX)
import AppKit
#endif


























class BossDataSourceMock: BossDataSource {




    //MARK: - generateBoss

    var generateBossPromptStringBossThrowableError: (any Error)?
    var generateBossPromptStringBossCallsCount = 0
    var generateBossPromptStringBossCalled: Bool {
        return generateBossPromptStringBossCallsCount > 0
    }
    var generateBossPromptStringBossReceivedPrompt: (String)?
    var generateBossPromptStringBossReceivedInvocations: [(String)] = []
    var generateBossPromptStringBossReturnValue: Boss!
    var generateBossPromptStringBossClosure: ((String) async throws -> Boss)?

    func generateBoss(prompt: String) async throws -> Boss {
        generateBossPromptStringBossCallsCount += 1
        generateBossPromptStringBossReceivedPrompt = prompt
        generateBossPromptStringBossReceivedInvocations.append(prompt)
        if let error = generateBossPromptStringBossThrowableError {
            throw error
        }
        if let generateBossPromptStringBossClosure = generateBossPromptStringBossClosure {
            return try await generateBossPromptStringBossClosure(prompt)
        } else {
            return generateBossPromptStringBossReturnValue
        }
    }


}
class BossGeneratorRepositoryMock: BossGeneratorRepository {




    //MARK: - getBosses

    var getBossesPromptStringBossThrowableError: (any Error)?
    var getBossesPromptStringBossCallsCount = 0
    var getBossesPromptStringBossCalled: Bool {
        return getBossesPromptStringBossCallsCount > 0
    }
    var getBossesPromptStringBossReceivedPrompt: (String)?
    var getBossesPromptStringBossReceivedInvocations: [(String)] = []
    var getBossesPromptStringBossReturnValue: Boss!
    var getBossesPromptStringBossClosure: ((String) async throws -> Boss)?

    func getBosses(prompt: String) async throws -> Boss {
        getBossesPromptStringBossCallsCount += 1
        getBossesPromptStringBossReceivedPrompt = prompt
        getBossesPromptStringBossReceivedInvocations.append(prompt)
        if let error = getBossesPromptStringBossThrowableError {
            throw error
        }
        if let getBossesPromptStringBossClosure = getBossesPromptStringBossClosure {
            return try await getBossesPromptStringBossClosure(prompt)
        } else {
            return getBossesPromptStringBossReturnValue
        }
    }


}
class CheckCombatVictoryConditionUseCaseMock: CheckCombatVictoryConditionUseCase {




    //MARK: - callAsFunction

    var callAsFunctionPlayerPlayerBossBossCombatVictoryConditionCallsCount = 0
    var callAsFunctionPlayerPlayerBossBossCombatVictoryConditionCalled: Bool {
        return callAsFunctionPlayerPlayerBossBossCombatVictoryConditionCallsCount > 0
    }
    var callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReceivedArguments: (player: Player, boss: Boss)?
    var callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReceivedInvocations: [(player: Player, boss: Boss)] = []
    var callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReturnValue: CombatVictoryCondition!
    var callAsFunctionPlayerPlayerBossBossCombatVictoryConditionClosure: ((Player, Boss) -> CombatVictoryCondition)?

    func callAsFunction(player: Player, boss: Boss) -> CombatVictoryCondition {
        callAsFunctionPlayerPlayerBossBossCombatVictoryConditionCallsCount += 1
        callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReceivedArguments = (player: player, boss: boss)
        callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReceivedInvocations.append((player: player, boss: boss))
        if let callAsFunctionPlayerPlayerBossBossCombatVictoryConditionClosure = callAsFunctionPlayerPlayerBossBossCombatVictoryConditionClosure {
            return callAsFunctionPlayerPlayerBossBossCombatVictoryConditionClosure(player, boss)
        } else {
            return callAsFunctionPlayerPlayerBossBossCombatVictoryConditionReturnValue
        }
    }


}
class GetDamageCalculatedUseCaseMock: GetDamageCalculatedUseCase {




    //MARK: - callAsFunction

    var callAsFunctionForDamageIntIntCallsCount = 0
    var callAsFunctionForDamageIntIntCalled: Bool {
        return callAsFunctionForDamageIntIntCallsCount > 0
    }
    var callAsFunctionForDamageIntIntReceivedDamage: (Int)?
    var callAsFunctionForDamageIntIntReceivedInvocations: [(Int)] = []
    var callAsFunctionForDamageIntIntReturnValue: Int!
    var callAsFunctionForDamageIntIntClosure: ((Int) -> Int)?

    func callAsFunction(for damage: Int) -> Int {
        callAsFunctionForDamageIntIntCallsCount += 1
        callAsFunctionForDamageIntIntReceivedDamage = damage
        callAsFunctionForDamageIntIntReceivedInvocations.append(damage)
        if let callAsFunctionForDamageIntIntClosure = callAsFunctionForDamageIntIntClosure {
            return callAsFunctionForDamageIntIntClosure(damage)
        } else {
            return callAsFunctionForDamageIntIntReturnValue
        }
    }


}
class StartRunUseCaseMock: StartRunUseCase {




    //MARK: - callAsFunction

    var callAsFunctionForPlayerPlayerRunThrowableError: (any Error)?
    var callAsFunctionForPlayerPlayerRunCallsCount = 0
    var callAsFunctionForPlayerPlayerRunCalled: Bool {
        return callAsFunctionForPlayerPlayerRunCallsCount > 0
    }
    var callAsFunctionForPlayerPlayerRunReceivedPlayer: (Player)?
    var callAsFunctionForPlayerPlayerRunReceivedInvocations: [(Player)] = []
    var callAsFunctionForPlayerPlayerRunReturnValue: Run!
    var callAsFunctionForPlayerPlayerRunClosure: ((Player) async throws -> Run)?

    func callAsFunction(for player: Player) async throws -> Run {
        callAsFunctionForPlayerPlayerRunCallsCount += 1
        callAsFunctionForPlayerPlayerRunReceivedPlayer = player
        callAsFunctionForPlayerPlayerRunReceivedInvocations.append(player)
        if let error = callAsFunctionForPlayerPlayerRunThrowableError {
            throw error
        }
        if let callAsFunctionForPlayerPlayerRunClosure = callAsFunctionForPlayerPlayerRunClosure {
            return try await callAsFunctionForPlayerPlayerRunClosure(player)
        } else {
            return callAsFunctionForPlayerPlayerRunReturnValue
        }
    }


}
class TurnManagerMock: TurnManager {




    //MARK: - nextTurn

    var nextTurnTurnCallsCount = 0
    var nextTurnTurnCalled: Bool {
        return nextTurnTurnCallsCount > 0
    }
    var nextTurnTurnReturnValue: Turn!
    var nextTurnTurnClosure: (() -> Turn)?

    func nextTurn() -> Turn {
        nextTurnTurnCallsCount += 1
        if let nextTurnTurnClosure = nextTurnTurnClosure {
            return nextTurnTurnClosure()
        } else {
            return nextTurnTurnReturnValue
        }
    }

    //MARK: - getCurrentTurn

    var getCurrentTurnTurnCallsCount = 0
    var getCurrentTurnTurnCalled: Bool {
        return getCurrentTurnTurnCallsCount > 0
    }
    var getCurrentTurnTurnReturnValue: Turn!
    var getCurrentTurnTurnClosure: (() -> Turn)?

    func getCurrentTurn() -> Turn {
        getCurrentTurnTurnCallsCount += 1
        if let getCurrentTurnTurnClosure = getCurrentTurnTurnClosure {
            return getCurrentTurnTurnClosure()
        } else {
            return getCurrentTurnTurnReturnValue
        }
    }


}
