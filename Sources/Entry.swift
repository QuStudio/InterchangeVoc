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

extension VocabularyVersion: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"major": .from(major),
			"minor": .from(minor),
			"patch": .from(patch)
		]
		return data
	}
	public init(mapper: Mapper) throws {
		major = try mapper.map(from: "major")
		minor = try mapper.map(from: "minor")
		patch = try mapper.map(from: "patch")
	}
}

func shareVocabulary(vocabulary: Vocabulary, with version: VocabularyVersion) -> StructuredData {
	let data: StructuredData = [
		"version": version.structuredData,
		"entries": .from(vocabulary.map({ $0.structuredData }))
	]
	return data
}