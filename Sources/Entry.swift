import Vocabulaire
import Mapper

extension Entry: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"id": StructuredData.from(id),
			"foreign": foreign.structuredData,
			"natives": StructuredData.from(natives.map({ $0.structuredData })),
			"author": author?.structuredData ?? .nullValue
		]
		return data
	}
	public init(mapper: Mapper) throws {
        id = try mapper.map(from: "id")
        foreign = try mapper.map(from: "foreign")
        natives = try Set(mapper.map(arrayFrom: "natives"))
        author = mapper.map(optionalFrom: "author")
	}
}

func shareVocabulary(vocabulary: Vocabulary) -> StructuredData {
	return StructuredData.from(vocabulary.map({ $0.structuredData }))
}