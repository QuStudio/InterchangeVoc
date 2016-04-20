import Vocabulaire
import Mapper

extension User.Status: RawRepresentable {
	public var rawValue: String {
		switch self {
		case .regular:
			return "regular"
		case .boardMember:
			return "board-member"
		}
	}
	public init?(rawValue: String) {
		switch rawValue {
		case "regular":
			self = .regular
		case "board-member":
			self = .boardMember
		default:
			return nil
		}
	}
}

extension User: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"id": StructuredData.from(id),
			"username": StructuredData.from(username),
			"status": StructuredData.from(status.rawValue)
		]
		return data
	}
	public init(mapper: Mapper) throws {
        id = try mapper.map(from: "id")
        username = try mapper.map(from: "username")
        status = try mapper.map(from: "status")
	}
}