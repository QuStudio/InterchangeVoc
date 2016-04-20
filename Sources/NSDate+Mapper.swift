import Foundation
import Mapper

extension StructuredDataInitializable where Self: NSDate {
    public init(structuredData value: StructuredData) throws {
        switch value {
        case .numberValue(let number):
            self.init(timeIntervalSince1970: number)
        default:
            throw InitializableError.cantBindToNeededType
        }
    }
}
extension NSDate: StructuredDataInitializable { }