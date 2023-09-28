
public protocol View {
    associatedtype Body
    @ViewBuilder var body: Body { get }
}

extension Never: View { public var body: Never { fatalError() } }
protocol Primitive: View where Body == Never {}
extension Primitive { public var body: Never { fatalError() } }

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock() -> Empty { Empty() }
    public static func buildBlock<V: View>(_ view: V) -> V { view }
    public static func buildBlock<each V: View>(_ views: repeat each V) -> TupleView<repeat each V> {
        .init(content: (repeat each views))
    }
}

public struct Empty: Primitive { public init() {} }

protocol AnyTupleView: Primitive {}

public struct TupleView<each Content: View>: Primitive, AnyTupleView {
    internal let content: (repeat each Content)
}

public struct VStack<V: View>: Primitive {
    internal let content: V
    
    public init(@ViewBuilder body: () -> V) {
        self.content = body()
    }
}

public struct HStack<V: View>: Primitive {
    internal let content: V
    
    public init(@ViewBuilder body: () -> V) {
        self.content = body()
    }
}

public struct ZStack<V: View>: Primitive {
    internal let content: V
    
    public init(@ViewBuilder body: () -> V) {
        self.content = body()
    }
}
