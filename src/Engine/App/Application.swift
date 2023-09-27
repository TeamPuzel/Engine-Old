
public protocol Application: Game {
    associatedtype Body: View
    @ViewBuilder var root: Body { get }
}

fileprivate var mx: Int = 0, my: Int = 0
fileprivate var cursor: Sprite = .cursor

public extension Application {
    mutating func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        renderer.sprite(from: cursor, x: mx, y: my)
    }
}
