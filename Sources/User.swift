import InterchangeData
import Vocabulaire
import Topo

extension User.Status: RawRepresentable {
	public var rawValue: String {
		switch self {
		case .Regular:
			return "regular"
		case .BoardMember:
			return "board-member"
		}
	}
	public init?(rawValue: String) {
		switch rawValue {
		case "regular":
			self = .Regular
		case "board-member":
			self = .BoardMember
		default:
			return nil
		}
	}
}

extension User: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"id": InterchangeData.from(id),
			"username": InterchangeData.from(username),
			"status": InterchangeData.from(status.rawValue)
		]
		return data
	}
	public init(map: Mapper) throws {
		try id = map.from("id")
		try username = map.from("username")
		try status = map.from("status")
	}
}