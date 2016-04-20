public enum UnwrapError: ErrorProtocol {
	case unwrappingNil
}

internal func unwrap<T>(optional: T?) throws -> T {
	if let strong = optional {
		return strong
	}
	throw UnwrapError.unwrappingNil
}
