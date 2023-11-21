
import Engine

@main
struct Editor: Application {
    var scene: Scene {
        Window(name: "Sprite Editor") {
            
        }
    }
}

//final class Canvas {
//    private var storage = Image(width: 8, height: 8, color: .black)
//    
//    public func draw(renderer: inout Renderer) {
//        for x in 0..<8 {
//            for y in 0..<8 {
//                renderer.rectangle(x: 2 + 8 * x, y: 9 + 8 * y, w: 8, h: 8, color: self.storage[x, y], fill: true)
//            }
//        }
//    }
//}

// Toolbar
//renderer.rectangle(x: 0, y: 0, w: 128, h: 7, color: .Strawberry.gray, fill: true)
//renderer.text("Sprite Editor", x: 1, y: 1)
