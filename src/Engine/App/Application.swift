
public protocol Application: Game {
    var root: View { get }
}

fileprivate var mx: Int = 0, my: Int = 0
fileprivate var cursor: Sprite = .cursor
fileprivate var cache: View!

public extension Application {
    mutating func update(input: Input) {
        if cache == nil { cache = root }
        mx = input.mouse.x
        my = input.mouse.y
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        cache.draw(&renderer, env: .init(x: 0, y: 0, w: Self.display.w, h: Self.display.h))
        renderer.sprite(from: cursor, x: mx, y: my)
    }
}
