import Vocabulaire
import InterchangeData
import Topo

extension NativeLexeme: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"lemma": lemma.interchangeData,
			"meaning": InterchangeData.from(meaning),
			"usage": InterchangeData.from(usage.rawValue)
		]
		return data
	}
	public init(map: Mapper) throws {
		try lemma = map.from("lemma")
		try meaning = map.from("meaning")
		try usage = map.from("usage")
	}
}

extension ForeignLexeme: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"lemma": lemma.interchangeData,
			"forms": InterchangeData.from(forms.map({ $0.interchangeData })),
			"origin": origin.interchangeData,
			"meaning": InterchangeData.from(meaning),
			"permissibility": InterchangeData.from(permissibility.rawValue)
		]
		return data
	}
	public init(map: Mapper) throws {
		try lemma = map.from("lemma")
		try forms = map.fromArray("forms")
		try origin = map.from("origin")
		try meaning = map.from("meaning")
		try permissibility = map.from("permissibility")
	}
}