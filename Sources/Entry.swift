import InterchangeData
import Vocabulaire
import Topo

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
	public init(map: Mapper) throws {
		try id = map.from("id")
		try foreign = map.from("foreign")
		try natives = Set(map.fromArray("natives"))
		author = map.optionalFrom("author")
	}
}

func shareVocabulary(vocabulary: Vocabulary) -> InterchangeData {
	return InterchangeData.from(vocabulary.map({ $0.interchangeData }))
}