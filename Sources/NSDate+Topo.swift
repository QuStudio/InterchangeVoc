import Foundation
import InterchangeData
import Topo

extension NSDate: Convertible {
	public static func from(customInterchangeData value: InterchangeData) -> NSDate? {
		switch value {
		case .NumberValue(let number):
			return NSDate(timeIntervalSince1970: number)
		default:
			return nil
		}
	}
}