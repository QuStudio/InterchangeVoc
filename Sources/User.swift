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
			"status": status.interchangeData
		]
		return data
	}
	// public init?(interchangeData: InterchangeData) {
	// 	guard let id = interchangeData["id"]?.int,
	// 		username = interchangeData["username"]?.string,
	// 		status = interchangeData["status"].flatMap({ Status(interchangeData: $0) })
	// 		else { return nil }
	// 	self.id = id
	// 	self.username = username
	// 	self.status = status
	// }
	public init(map: Mapper) throws {
		try id = map.from("id")
		try username = map.from("username")
		try status = map.from("status")
	}
}