import InterchangeData
import Vocabulaire

struct MorphemeType {
	static let general = "general"
	static let caseSensitive = "case-sensitive"
}

extension GeneralMorpheme: InterchangeDataRepresentable {

	public var interchangeData: InterchangeData {
		let interchange: InterchangeData = [
			"value": InterchangeData.from(view),
			"type": InterchangeData.from(MorphemeType.general)
		]
		return interchange
	}

	public init?(interchangeData: InterchangeData) {
		guard let value = interchangeData["value"]?.string,
			type = interchangeData["type"]?.string where type == MorphemeType.general
			else { return nil }
		self.init(value)
	}

}

extension CaseSensitiveMorpheme: InterchangeDataRepresentable {

	public var interchangeData: InterchangeData {
		let interchange: InterchangeData = [
			"value": InterchangeData.from(view),
			"type": InterchangeData.from(MorphemeType.caseSensitive)
		]
		return interchange
	}

	public init?(interchangeData: InterchangeData) {
		guard let value = interchangeData["value"]?.string,
			type = interchangeData["type"]?.string where type == MorphemeType.caseSensitive
			else { return nil }
		self.init(value)
	}

}