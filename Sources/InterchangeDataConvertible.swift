import InterchangeData
import Topo

public protocol InterchangeDataConvertible {

	var interchangeData: InterchangeData { get }

}

public protocol InterchangeDataInitializable {

	init?(interchangeData: InterchangeData)

}

public protocol InterchangeDataRepresentable: InterchangeDataConvertible, Mappable { }

public enum UnwrapError: ErrorType {
	case UnwrappingNil
}

internal func unwrap<T>(optional: T?) throws -> T {
	if let strong = optional {
		return strong
	}
	throw UnwrapError.UnwrappingNil
}