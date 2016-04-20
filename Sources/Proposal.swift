import Vocabulaire
import Foundation
import Mapper

extension NativesProposal: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"main": main.structuredData,
			"alternatives": { 
				if let alternativesData = alternatives?.map({ $0.structuredData }) {
					return StructuredData.from(alternativesData)
				}
				return .nullValue
			}()
		]
		return data
	}
	public init(mapper: Mapper) throws {
        main = try mapper.map(from: "main")
        alternatives = mapper.map(optionalArrayFrom: "alternatives")
	}
}

extension ClientEntryProposal: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		let data: StructuredData = [
			"author": author.structuredData,
			"foreign": foreign.structuredData,
			"native": native.structuredData,
			"rationale": StructuredData.from(rationale),
			"posted-at": StructuredData.from(postedAt.timeIntervalSince1970)
		]
		return data
	}
	public init(mapper: Mapper) throws {
//		try author = map.from("author")
//		try foreign = map.from("foreign")
//		try native = map.from("native")
//		try rationale = map.from("rationale")
//		try postedAt = map.from("posted-at")
        author = try mapper.map(from: "author")
        foreign = try mapper.map(from: "foreign")
        native = try mapper.map(from: "native")
        rationale = try mapper.map(from: "rationale")
        postedAt = try mapper.map(from: "posted-at")
	}

	private init(proposal: EntryProposal) {
		self.author = proposal.author
		self.foreign = proposal.foreign
		self.native = proposal.native
		self.rationale = proposal.rationale
		self.postedAt = proposal.postedAt
	}
}

extension ServerEntryProposal.Status: StructuredDataRepresentable, Mappable {
	public var structuredData: StructuredData {
		func data(withStatus label: String) -> StructuredData {
			let data: StructuredData = [
				"status": StructuredData.from(label)
			]
			return data
		}
		switch self {
		case .AcceptedWithChanges(let changes):
			let data: StructuredData = [
				"status": StructuredData.from("accepted-with-changes"),
				"changes": StructuredData.from(changes)
			]
			return data
		case .Rejected(let rationale):
			let data: StructuredData = [
				"status": StructuredData.from("rejected"),
				"rationale": StructuredData.from(rationale)
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
	public init(mapper: Mapper) throws {
        let label: String = try mapper.map(from: "status")
		switch label {
		case "accepted-with-changes":
            let changes: String = try mapper.map(from: "changes")
			self = .AcceptedWithChanges(changes: changes)
		case "rejected":
			let rationale: String = try mapper.map(from: "rationale")
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
			throw Mapper.Error.cantInitFromRawValue
		}
	}
}

extension ServerEntryProposal: StructuredDataRepresentable {
	public var structuredData: StructuredData {
		let baseData = ClientEntryProposal(proposal: self).structuredData
		let extData: StructuredData = [
			"base": baseData,
			"id": StructuredData.from(id),
			"status": status.structuredData
		]
		return extData
	}
	public init(mapper: Mapper) throws {
		let clientProposal: ClientEntryProposal = try mapper.map(from: "base")
		let id: Int = try mapper.map(from: "id")
		let status: Status = try mapper.map(from: "status")
		self.init(clientProposal: clientProposal, id: id, status: status)	
	}
}