
import Engine

public struct Toolbar: View {
    public func draw(renderer: inout Renderer, input: Input) {
        renderer.rectangle(x: 0, y: 0, w: 128, h: 7, color: .Strawberry.gray, fill: true)
        renderer.text("Sprite Mode", x: 1, y: 1)
    }
    
    public init() {}
}
