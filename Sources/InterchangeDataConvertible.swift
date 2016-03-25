import InterchangeData

public protocol InterchangeDataConvertible {

	var interchangeData: InterchangeData { get }

}

public protocol InterchangeDataInitializable {

	init?(interchangeData: InterchangeData)

}

public protocol InterchangeDataRepresentable: InterchangeDataConvertible, InterchangeDataInitializable { }