//
//  BossDataSourceTests.swift
//  LabyrinthOfShadowsTests
//
//  Created by Javier Galera Garrido on 21/10/25.
//

import Testing
@testable import LabyrinthOfShadows

struct BossDataSourceTests {

	@Test func testThatCleanJSONResponseRemovesCodeFencesAndTrims_When_InputContainsBackticksAndWhitespace() {
		// Given
		let raw = "\n```json\n{ \"name\": \"X\" }\n```\n"
		let sut = BossDataSourceImplementation()

		// When
		let cleaned = sut.cleanJSONResponse(raw)

		// Then
		#expect(cleaned.contains("```") == false)
		#expect(cleaned.trimmingCharacters(in: .whitespacesAndNewlines) == cleaned)
		#expect(cleaned.contains("{ \"name\": \"X\" }") )
	}

	@Test func testThatGenerateInstructionsContainsRequiredGuidance_When_Called() {
		// Given
		let sut = BossDataSourceImplementation()

		// When
		let instructions = sut.generateIntrunctions()

		// Then
		#expect(instructions.contains("Return **only** a JSON object") )
		#expect(instructions.contains("Health: boss health ≥ player health") )
		#expect(instructions.contains("Every 10 points of Agility difference grant an extra turn") )
	}

}
