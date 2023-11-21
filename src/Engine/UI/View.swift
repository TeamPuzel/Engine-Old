
import Engine

public protocol View {
    var x: Int { get }
    var y: Int { get }
    var width: Int { get }
    var height: Int { get }
    
    func draw(renderer: inout Renderer, input: Input)
}

public extension View {
    var x: Int { 0 }
    var y: Int { 0 }
    var width: Int { 0 }
    var height: Int { 0 }
    
    func draw(renderer: inout Engine.Renderer, input: Engine.Input) {}
}

public struct Empty: View {}

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock() -> Empty { .init() }
    public static func buildBlock(_ components: any View...) -> [any View] { components }
}
