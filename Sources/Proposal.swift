import InterchangeData
import Vocabulaire

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