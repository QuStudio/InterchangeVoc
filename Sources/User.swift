import InterchangeData
import Vocabulaire

extension User.Status: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		switch self {
		case .Regular:
			return InterchangeData.from("regular")
		case .BoardMember:
			return InterchangeData.from("board-member")
		}
	}
	public init?(interchangeData: InterchangeData) {
		guard let raw = interchangeData.string else { return nil }
		switch raw {
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
	public init?(interchangeData: InterchangeData) {
		guard let id = interchangeData["id"]?.int,
			username = interchangeData["username"]?.string,
			status = interchangeData["status"].flatMap({ Status(interchangeData: $0) })
			else { return nil }
		self.id = id
		self.username = username
		self.status = status
	}
}