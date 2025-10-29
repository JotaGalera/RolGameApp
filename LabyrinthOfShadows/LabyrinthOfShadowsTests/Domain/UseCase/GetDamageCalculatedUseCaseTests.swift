//
//  GetDamageCalculatedUseCaseTests.swift
//  LabyrinthOfShadowsTests
//
//  Created by Javier Galera Garrido on 29/10/25.
//

import Foundation
import Testing
@testable import LabyrinthOfShadows

struct GetDamageCalculatedUseCaseTests {

    @Test func testThatReturnsOneWhenDamageIsZeroOrLessThanFive() {
        let sut = GetDamageCalculatedUseCaseImplementation()

        #expect(sut(for: 0) == 1)
        #expect(sut(for: 4) == 1)
    }

    @Test func testThatDamageIncreasesByOneEveryFivePoints() {
        let sut = GetDamageCalculatedUseCaseImplementation()

        #expect(sut(for: 5) == 2)
        #expect(sut(for: 9) == 2)
        #expect(sut(for: 10) == 3)
        #expect(sut(for: 25) == 6) // 1 + (25/5) = 6
    }

}
