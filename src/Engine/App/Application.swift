
public protocol Application: Game {
    associatedtype Body: View
    @ViewBuilder var body: Body { get }
}

fileprivate var mx: Int = 0, my: Int = 0
fileprivate var cursor: Sprite = .cursor

public extension Application {
    mutating func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
//        print(type(of: self.body))
        self.body.debugWalk()
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
//        self.root.draw(&renderer, env: .init(x: 0, y: 0, w: Self.display.w, h: Self.display.h))
        renderer.sprite(from: cursor, x: mx, y: my)
    }
}

extension View {
    func debugWalk() {
        if let p = self as? any Primitive {}
        else {
            
        }
    }
}
