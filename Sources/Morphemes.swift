import InterchangeData
import Vocabulaire

extension Morpheme.Kind: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		switch self {
		case .General:
			return InterchangeData.from("general")
		case .CaseSensitive:
			return InterchangeData.from("case-sensitive")
		}
	}
	public init?(interchangeData: InterchangeData) {
		guard let raw = interchangeData.string else { return nil }
		switch raw {
		case "general":
			self = .General
		case "case-sensitive":
			self = .CaseSensitive
		default:
			return nil
		}
	}
}

extension Morpheme: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"value": InterchangeData.from(view),
			"type": type.interchangeData
		]
		return data
	}
	public init?(interchangeData: InterchangeData) {
		guard let value = interchangeData["value"]?.string,
			type = interchangeData["type"].flatMap({ Kind(interchangeData: $0) })
			else { return nil }
		self.init(value, type: type)
	}
}