
import Engine

@main
struct Dungeons: Game {
    var x: Int = 16, y: Int = 16
    
    mutating func update(input: Input) {
        if input.right { self.x += 1 }
        if input.left { self.x -= 1 }
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        renderer.sprite(from: slime, x: self.x, y: self.y)
    }
}