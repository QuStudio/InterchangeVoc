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
	// public init?(interchangeData: InterchangeData) {
	// 	guard let lemma = interchangeData["lemma"].flatMap({ Morpheme(interchangeData: $0) }),
	// 		meaning = interchangeData["meaning"]?.string,
	// 		usage = interchangeData["usage"]?.int.flatMap({ Usage(rawValue: $0) })
	// 		else { return nil }
	// 	self.lemma = lemma
	// 	self.meaning = meaning
	// 	self.usage = usage
	// }
	public init(map: Mapper) throws {
		try self.lemma = map.from("lemma")
		try self.meaning = map.from("meaning")
		let rawUsage: Int = try map.from("usage")
		try self.usage = unwrap(Usage(rawValue: rawUsage))
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
	// public init?(interchangeData: InterchangeData) {
	// 	guard let lemma = interchangeData["lemma"].flatMap(Morpheme.init),
	// 		forms = interchangeData["forms"]?.array?.flatMap(Morpheme.init),
	// 		origin = interchangeData["origin"].flatMap(Morpheme.init),
	// 		meaning = interchangeData["meaning"]?.string,
	// 		permissibility = interchangeData["permissibility"]?.int.flatMap({ Permissibility(rawValue: $0) })
	// 		else { return nil }
	// 	self.lemma = lemma
	// 	self.forms = forms
	// 	self.origin = origin
	// 	self.meaning = meaning
	// 	self.permissibility = permissibility
	// }
	public init(map: Mapper) throws {
		try lemma = map.from("lemma")
		try forms = map.fromArray("forms")
		try origin = map.from("origin")
		try meaning = map.from("meaning")
		let rawPermissibility: Int = try map.from("permissibility")
		try permissibility = unwrap(Permissibility(rawValue: rawPermissibility))
	}
}