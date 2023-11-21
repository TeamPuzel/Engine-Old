
import Engine

public protocol Application: Game {
    
}

public extension Application {
    func frame(renderer: inout Renderer, input: Input) {
        renderer.clear()
        renderer.sprite(from: .cursor, x: input.mouse.x, y: input.mouse.y)
    }
}
