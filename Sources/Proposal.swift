import InterchangeData
import Vocabulaire
import Foundation

extension NativesProposal: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"main": main.interchangeData,
			"alternatives": { 
				if let alternativesData = alternatives?.map({ $0.interchangeData }) {
					return InterchangeData.from(alternativesData)
				}
				return InterchangeData.NullValue
			}()
		]
		return data
	}
	public init?(interchangeData: InterchangeData) {
		guard let main = interchangeData["main"].flatMap(Morpheme.init) else { return nil }
		self.main = main
		self.alternatives = interchangeData["alternatives"]?.array?.flatMap(Morpheme.init)
	}
}

extension ClientEntryProposal: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let data: InterchangeData = [
			"author": author.interchangeData,
			"foreign": foreign.interchangeData,
			"native": native.interchangeData,
			"rationale": InterchangeData.from(rationale),
			"posted-at": InterchangeData.from(postedAt.timeIntervalSince1970)
		]
		return data
	}
	public init?(interchangeData: InterchangeData) {
		guard let author = interchangeData["author"].flatMap(User.init),
			foreign = interchangeData["foreign"].flatMap(Morpheme.init),
			native = interchangeData["native"].flatMap(NativesProposal.init),
			rationale = interchangeData["rationale"]?.string,
			postedAt = interchangeData["posted-at"]?.double.flatMap({ NSDate(timeIntervalSince1970: $0) })
			else { return nil }
		self.author = author
		self.foreign = foreign
		self.native = native
		self.rationale = rationale
		self.postedAt = postedAt
	}

	private init(serverProposal: ServerEntryProposal) {
		self.author = serverProposal.author
		self.foreign = serverProposal.foreign
		self.native = serverProposal.native
		self.rationale = serverProposal.rationale
		self.postedAt = serverProposal.postedAt
	}
}

extension ServerEntryProposal.Status: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		func data(withStatus label: String) -> InterchangeData {
			let data: InterchangeData = [
				"status": InterchangeData.from(label)
			]
			return data
		}
		switch self {
		case .AcceptedWithChanges(let changes):
			let data: InterchangeData = [
				"status": InterchangeData.from("accepted-with-changes"),
				"changes": InterchangeData.from(changes)
			]
			return data
		case .Rejected(let rationale):
			let data: InterchangeData = [
				"status": InterchangeData.from("rejected"),
				"rationale": InterchangeData.from(rationale)
			]
			return data
		case .Implemented:
			return data(withStatus: "implemented")
		case .Accepted:
			return data(withStatus: "accepted")
		case .UnderReview:
			return data(withStatus: "under-review")
		case .Awaiting:
			return data(withStatus: "awaiting")
		}
	}
	public init?(interchangeData: InterchangeData) {
		guard let label = interchangeData["status"]?.string else { return nil }
		switch label {
		case "accepted-with-changes":
			guard let changes = interchangeData["changes"]?.string else { return nil }
			self = .AcceptedWithChanges(changes: changes)
		case "rejected":
			guard let rationale = interchangeData["rationale"]?.string else { return nil }
			self = .Rejected(rationale: rationale)
		case "implemented":
			self = .Implemented
		case "accepted":
			self = .Accepted
		case "under-review":
			self = .UnderReview
		case "awaiting":
			self = .Awaiting
		default:
			return nil
		}
	}
}

extension ServerEntryProposal: InterchangeDataRepresentable {
	public var interchangeData: InterchangeData {
		let baseData = ClientEntryProposal(serverProposal: self).interchangeData
		let extData: InterchangeData = [
			"base": baseData,
			"id": InterchangeData.from(id),
			"status": status.interchangeData
		]
		return extData
	}
	public init?(interchangeData: InterchangeData) {
		guard let clientProposal = interchangeData["base"].flatMap(ClientEntryProposal.init),
			id = interchangeData["id"]?.int,
			status = interchangeData["status"].flatMap(Status.init)
			else { return nil }
		self.init(clientProposal: clientProposal, id: id, status: status)
	}
}