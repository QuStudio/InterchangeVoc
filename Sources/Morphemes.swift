import InterchangeData
import Vocabulaire
import Topo

extension Morpheme.Kind: RawRepresentable {
	public var rawValue: String {
		switch self {
		case .General:
			return "general"
		case .CaseSensitive:
			return "case-sensitive"
		}
	}
	public init?(rawValue: String) {
		switch rawValue {
		case "general":
			self = .General
		case "case-sensitive":
			self = .CaseSensitive
		default:
			return nil
		}
	}
}

// extension Morpheme.Kind: InterchangeDataConvertible {
// 	public var interchangeData: InterchangeData {
// 		switch self {
// 		case .General:
// 			return InterchangeData.from("general")
// 		case .CaseSensitive:
// 			return InterchangeData.from("case-sensitive")
// 		}
// 	}
// 	// public init
// }

extension Morpheme: InterchangeDataConvertible, Mappable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"value": InterchangeData.from(view),
			"type": InterchangeData.from(type.rawValue)
		]
		return data
	}
	// public init?(interchangeData: InterchangeData) {
	// 	guard let value = interchangeData["value"]?.string,
	// 		type = interchangeData["type"].flatMap({ Kind(interchangeData: $0) })
	// 		else { return nil }
	// 	self.init(value, type: type)
	// }
	public init(map: Mapper) throws {
		let value: String = try map.from("value")
		let type: Kind = try map.from("type")
		self.init(value, type: type)
	}
}