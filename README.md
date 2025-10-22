# Labyrinth of Shadows: Algorithm's Descent

## 🧩 Description
**Labyrinth of Shadows: Algorithm's Descent** is a **roguelike RPG** game for iOS, developed in **Swift**, where the player controls a character to fight dynamically generated monsters using **AI**.  
Every decision made by the player influences how the algorithm creates new enemies and scenarios, making each run unique and unpredictable.  

## 🎮 Main Features
- ⚔️ **Roguelike combat**: permadeath and run-based progression.  
- 👾 **AI-generated monsters** based on player decisions and character evolution.  
- 🌌 **Unique experience in every run** thanks to procedural generation.  
- 📱 **Native iOS app** built with **Swift**.  
- ⌚ Possible future integration with **Apple Watch**.  

## 🚀 Tech Stack
- [Swift](https://developer.apple.com/swift/)  
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)  
- [Foundation Models](https://developer.apple.com/documentation/FoundationModels)
- [Xcode](https://developer.apple.com/xcode/)
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery) Mocks generation.

*About Sourcery*
To use Sourcery, download binary an unzip in Dependencies. Rename the folder as: "sourcery". Then just run ./run-automockable from the project root folder.

## Game Description

Game: A run is made up of a list of combats. Each run progresses as the player faces a sequence of combats against procedurally generated bosses.

Combat: Each combat involves two participants: the player and a boss. Combat is turn-based and ends when either the player or the boss has no remaining "health".

Turns: On a turn the active participant can attack. Turn order priority is determined by the Agility attribute. A character may obtain consecutive turns when their Agility is sufficiently higher than their opponent's: every full 10-point advantage in Agility grants one additional consecutive turn for that character.

Damage and lives: The player has 3 lives. A life is lost when the player's Health reaches zero or below. Damage dealt depends on the attacking character's class main attribute (see Playable classes below).

Playable classes: The player can choose one of three classes: Warrior, Thief, or Mage.

Main attributes:
- Warrior -> Strength
- Thief -> Dexterity
- Mage -> Intelligence

Attributes used by the system:
- health
- strength
- agility
- intelligence
- dexterity