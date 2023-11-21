
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

@available(*, deprecated, message: "Temporary and unsafe development only feature")
extension Image: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = [Color]
    
    public init(arrayLiteral elements: [Color]...) {
        self.width = elements[0].count
        self.height = elements.count
        self.data = Array(elements.joined())
    }
}

public extension Image {
    enum UI {
        public static let cursor: Image = [
            [.clear, .black, .clear, .clear, .clear, .clear],
            [.black, .white, .black, .clear, .clear, .clear],
            [.black, .white, .white, .black, .clear, .clear],
            [.black, .white, .white, .white, .black, .clear],
            [.black, .white, .white, .white, .white, .black],
            [.black, .white, .white, .black, .black, .clear],
            [.clear, .black, .black, .white, .black, .clear]
        ]
    }
}
