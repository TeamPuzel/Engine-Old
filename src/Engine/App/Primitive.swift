
extension Never: View {
    public var body: UnitView<Never> { fatalError() }
}

protocol Primitive: View {}
extension Primitive {
    public var body: Never { fatalError() }
}

public struct Empty: Primitive {
    public init() {}
}

public struct UnitView<Content: View>: Primitive {
    internal let content: Content
}

public struct TupleView<each Content: View>: Primitive {
    internal let content: (repeat each Content)
}
