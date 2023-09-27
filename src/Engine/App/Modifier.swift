
protocol Modifier: Primitive {}

public struct Background<Content: View>: Modifier {
    internal let content: Content
    internal let color: Color?
}

public extension View {
    func background(_ color: Color? = nil) -> Background<Self> {
        Background(content: self, color: color)
    }
}
