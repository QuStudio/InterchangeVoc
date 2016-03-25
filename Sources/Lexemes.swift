import Vocabulaire
import InterchangeData

extension NativeLexeme: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"lemma": lemma.interchangeData,
			"meaning": InterchangeData.from(meaning),
			"usage": InterchangeData.from(usage.rawValue)
		]
		return data
	}
	public init?(interchangeData: InterchangeData) {
		guard let lemma = interchangeData["lemma"].flatMap({ Morpheme(interchangeData: $0) }),
			meaning = interchangeData["meaning"]?.string,
			usage = interchangeData["usage"]?.int.flatMap({ Usage(rawValue: $0) })
			else { return nil }
		self.lemma = lemma
		self.meaning = meaning
		self.usage = usage
	}
}

extension ForeignLexeme: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"lemma": lemma.interchangeData,
			"forms": InterchangeData.from(forms.map({ $0.interchangeData }))
			"origin": origin.interchangeData,
			"meaning": InterchangeData.from(meaning),
			"permissibility": InterchangeData.from(permissibility.rawValue)
		]
	}
}