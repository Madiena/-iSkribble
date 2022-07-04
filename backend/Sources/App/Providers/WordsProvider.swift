import Foundation
import shared
import Vapor

class WordsProvider {
	static let shared = WordsProvider()
    
    private var words: [String] = []
    
    private init() {}

	func loadWords(app: Application) throws {
        let wordsURL = URL(fileURLWithPath: app.directory.resourcesDirectory)
            .appendingPathComponent("words.json")

        let wordsData = try Data(contentsOf: wordsURL)

        words = try JSONSerializer.decode([String].self, from: wordsData)
	}

    func getWords() -> [String] {
        return words
    }

    func getRandomWords(_ amount: Int) -> [String] {
        return words.randomSample(count: amount)
    }
}