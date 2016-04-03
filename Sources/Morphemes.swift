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

extension Morpheme: InterchangeDataConvertible, Mappable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"string": InterchangeData.from(view),
			"type": InterchangeData.from(type.rawValue)
		]
		return data
	}

	public init(map: Mapper) throws {
		let value: String = try map.from("string")
		let type: Kind = map.optionalFrom("type") ?? .General
		self.init(value, type: type)
	}
}