
import Engine

@main
struct Editor: Application {
    var canvas = Canvas()
    
    mutating func frame(renderer: inout Renderer, input: Input) {
        renderer.clear(with: .Strawberry.dark)
        
        // Toolbar
        renderer.rectangle(x: 0, y: 0, w: 128, h: 7, color: .Strawberry.gray, fill: true)
        renderer.text("Sprite Editor", x: 1, y: 1)
        
        canvas.draw(renderer: &renderer)
        
        renderer.image(.UI.cursor, x: input.mouse.x, y: input.mouse.y)
    }
}

final class Canvas {
    private var storage = Image(width: 8, height: 8, color: .black)
    
    public func draw(renderer: inout Renderer) {
        for x in 0..<8 {
            for y in 0..<8 {
                renderer.rectangle(x: 2 + 8 * x, y: 9 + 8 * y, w: 8, h: 8, color: self.storage[x, y], fill: true)
            }
        }
    }
}
