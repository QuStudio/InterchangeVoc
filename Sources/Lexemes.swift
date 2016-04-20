import Vocabulaire
import Mapper

extension NativeLexeme: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"lemma": lemma.structuredData,
			"meaning": StructuredData.from(meaning),
			"usage": StructuredData.from(usage.rawValue)
		]
		return data
	}
	public init(mapper: Mapper) throws {
        lemma = try mapper.map(from: "lemma")
		meaning = try mapper.map(from: "meaning")
		usage = try mapper.map(from: "usage")
	}
}

extension ForeignLexeme: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"lemma": lemma.structuredData,
			"forms": StructuredData.from(forms.map({ $0.structuredData })),
			"origin": origin.structuredData,
			"meaning": StructuredData.from(meaning),
			"permissibility": StructuredData.from(permissibility.rawValue)
		]
		return data
	}
	public init(mapper: Mapper) throws {
        lemma = try mapper.map(from: "lemma")
        forms = try mapper.map(arrayFrom: "forms")
        origin = try mapper.map(from: "origin")
        meaning = try mapper.map(from: "meaning")
        permissibility = try mapper.map(from: "permissibility")
	}
}