
public protocol Application: Game {
    var root: View { get }
}

fileprivate var mx: Int = 0, my: Int = 0
fileprivate var cursor: Sprite = .cursor
fileprivate var cache: View!

public extension Application {
    init() {
        self.init()
        cache = self.root
    }
    
    mutating func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        root.draw(&renderer, env: .init(x: 0, y: 0, w: 128, h: 128))
        renderer.sprite(from: cursor, x: mx, y: my)
    }
}
