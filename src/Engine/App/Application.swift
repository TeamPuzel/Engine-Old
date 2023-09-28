
public protocol Application: Game {
    
}

fileprivate var mx: Int = 0, my: Int = 0
fileprivate var cursor: Sprite = .cursor
fileprivate var surfaces: [Surface] = [
    Toolbar(),
    Content()
]

public extension Application {
    static var display: (w: Int, h: Int) { (w: 640, h: 400) }
    static var windowBorder: Bool { false }
    static var windowMargin: Int { 0 }
    static var pixelSize: Int { 4 }
    
    mutating func setup() {
        
    }
    
    mutating func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        
        for surface in surfaces {
            surface.draw(&renderer, env: .init(x: 2, y: 2, w: Self.display.w - 2, h: Self.display.h - 2))
        }
        // Window border
        renderer.rectangle(x: 0, y: 0, w: Self.display.w, h: Self.display.h, color: .Strawberry.black)
        renderer.rectangle(x: 1, y: 1, w: Self.display.w - 2, h: Self.display.h - 2, color: .Strawberry.gray)
        
        // Window controls
        renderer.rectangle(x: 6, y: 6, w: 5, h: 5, color: .Strawberry.red - 20, fill: true)
        renderer.rectangle(x: 6, y: 6, w: 5, h: 5, color: .Strawberry.red)
        
        renderer.rectangle(x: 6 + 9, y: 6, w: 5, h: 5, color: .Strawberry.banana - 20, fill: true)
        renderer.rectangle(x: 6 + 9, y: 6, w: 5, h: 5, color: .Strawberry.banana)
        
        renderer.rectangle(x: 6 + 9 * 2, y: 6, w: 5, h: 5, color: .Strawberry.lime - 20, fill: true)
        renderer.rectangle(x: 6 + 9 * 2, y: 6, w: 5, h: 5, color: .Strawberry.lime)
        
        renderer.sprite(from: cursor, x: mx, y: my)
    }
    
    fileprivate func drawToolbar(_ renderer: inout Renderer) {
        
    }
}
