
public enum View {
    case horizontal(children: [View])
    case vertical(children: [View])
    case depth(children: [View])
    case color(of: Color)
}

public extension View {
    enum Alignment { case start, end, center }
}
