import InterchangeData
import Vocabulaire

extension Entry: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"id": InterchangeData.from(id),
			"foreign": foreign.interchangeData,
			"natives": InterchangeData.from(natives.map({ $0.interchangeData })),
			"author": author?.interchangeData ?? InterchangeData.NullValue
		]
		return data
	}
	public init?(interchangeData: InterchangeData) {
		guard let id = interchangeData["id"]?.int,
			foreign = interchangeData["foreign"].flatMap(ForeignLexeme.init),
			natives = interchangeData["natives"]?.array?.flatMap(NativeLexeme.init),
			author = interchangeData["author"].flatMap(User.init)
			else { return nil }
		self.id = id
		self.foreign = foreign
		self.natives = Set(natives)
		self.author = author
	}
}

func shareVocabulary(vocabulary: Vocabulary) -> InterchangeData {
	return InterchangeData.from(vocabulary.map({ $0.interchangeData }))
}