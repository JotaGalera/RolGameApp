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
