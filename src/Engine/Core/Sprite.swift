
public struct Sprite {
    internal let data: [[Color?]]
}

extension Sprite: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = [Color?]
    
    public init(arrayLiteral elements: [Color?]...) {
        precondition(elements.count == 8 && elements.allSatisfy { $0.count == 8 })
        self.data = elements
    }
}

public extension Sprite {
    static let cursor: Sprite = [
        [nil, .black, nil, nil, nil, nil, nil, nil],
        [.black, .white, .black, nil, nil, nil, nil, nil],
        [.black, .white, .white, .black, nil, nil, nil, nil],
        [.black, .white, .white, .white, .black, nil, nil, nil],
        [.black, .white, .white, .white, .white, .black, nil, nil],
        [.black, .white, .white, .black, .black, nil, nil, nil],
        [nil, .black, .black, .white, .black, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
    ]
//    static let cursor: Sprite = [
//        [nil, .white, nil, nil, nil, nil, nil, nil],
//        [.white, .black, .white, nil, nil, nil, nil, nil],
//        [.white, .black, .black, .white, nil, nil, nil, nil],
//        [.white, .black, .black, .black, .white, nil, nil, nil],
//        [.white, .black, .black, .black, .black, .white, nil, nil],
//        [.white, .black, .black, .white, .white, nil, nil, nil],
//        [nil, .white, .white, .black, .white, nil, nil, nil],
//        [nil, nil, nil, nil, nil, nil, nil, nil]
//    ]
}
