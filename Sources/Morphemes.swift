import Vocabulaire
import Mapper

extension Morpheme.Kind: RawRepresentable {
	public var rawValue: String {
		switch self {
		case .general:
			return "general"
		case .caseSensitive:
			return "case-sensitive"
		}
	}
	public init?(rawValue: String) {
		switch rawValue {
		case "general":
			self = .general
		case "case-sensitive":
			self = .caseSensitive
		default:
			return nil
		}
	}
}

extension Morpheme: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"string": StructuredData.from(view),
			"type": StructuredData.from(type.rawValue)
		]
		return data
	}

	public init(mapper: Mapper) throws {
        let value: String = try mapper.map(from: "string")
        let type: Kind = mapper.map(optionalFrom: "type") ?? .general
		self.init(value, type: type)
	}
}