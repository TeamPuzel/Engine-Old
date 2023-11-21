
public struct Image {
    public private(set) var data: [Color]
    public let width, height: Int
    
    public init(width: Int, height: Int, color: Color = .clear) {
        self.width = width
        self.height = height
        self.data = .init(repeating: color, count: width * height)
    }
    
    public subscript(x: Int, y: Int) -> Color {
        get { data[x + y * width] }
        set { data[x + y * width] = newValue }
    }
}
