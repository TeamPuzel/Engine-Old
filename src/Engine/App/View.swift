
public protocol View<Body> {
    associatedtype Body: View
    @ViewBuilder var body: Body { get }
}

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock() -> Empty { Empty() }
    public static func buildBlock<Content: View>(_ view: Content) -> UnitView<Content> {
        .init(content: view)
    }
    public static func buildBlock<each Content: View>(_ views: repeat each Content) -> TupleView<repeat each Content> {
        .init(content: (repeat each views))
    }
}
