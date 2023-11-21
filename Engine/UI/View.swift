
open class View {
    public init() {}
}

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock(_ components: View...) -> [View] {
        components
    }
}
