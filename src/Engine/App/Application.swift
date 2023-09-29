
public protocol Application: Game {
    
}

fileprivate var mx: Int = 0, my: Int = 0
fileprivate var cursor: Sprite = .cursor
fileprivate var surfaces: [Surface] = [
    Toolbar(),
    Content()
]

public extension Application {
    static var display: (w: Int, h: Int) { (w: 480, h: 300) }
    static var windowBorder: Bool { false }
    static var windowMargin: Int { 0 }
    static var pixelSize: Int { 6 }
    
    mutating func setup() {
        
    }
    
    mutating func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
        
        if mx >= 6 && mx < 6 + 5 && my >= 6 && my < 6 + 5 && input.mouse.left {
            self.quit()
        }
        if mx >= 6 + 9 && mx < 6 + 5 + 9 && my >= 6 && my < 6 + 5 && input.mouse.left {
            self.minimize()
        }
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        
        for surface in surfaces {
            surface.draw(&renderer, env: .init(
                x: 2, y: 2, w: Self.display.w - 2, h: Self.display.h - 2,
                windowIsFocused: self.windowIsFocused
            ))
        }
        // Window border
        renderer.rectangle(x: 0, y: 0, w: Self.display.w, h: Self.display.h, color: .Strawberry.black)
        renderer.rectangle(x: 1, y: 1, w: Self.display.w - 2, h: Self.display.h - 2, color: .Strawberry.gray)
        
        // Window controls
        if windowIsFocused {
            renderer.rectangle(x: 6, y: 6, w: 5, h: 5, color: .Strawberry.red - 20, fill: true)
            renderer.rectangle(x: 6, y: 6, w: 5, h: 5, color: .Strawberry.red)
            
            renderer.rectangle(x: 6 + 9, y: 6, w: 5, h: 5, color: .Strawberry.banana - 30, fill: true)
            renderer.rectangle(x: 6 + 9, y: 6, w: 5, h: 5, color: .Strawberry.banana)
            
            renderer.rectangle(x: 6 + 9 * 2, y: 6, w: 5, h: 5, color: .Strawberry.lime - 30, fill: true)
            renderer.rectangle(x: 6 + 9 * 2, y: 6, w: 5, h: 5, color: .Strawberry.lime)
        } else {
            renderer.rectangle(x: 6, y: 6, w: 5, h: 5, color: .Strawberry.gray, fill: true)
            renderer.rectangle(x: 6, y: 6, w: 5, h: 5, color: .Strawberry.gray + 20)
            
            renderer.rectangle(x: 6 + 9, y: 6, w: 5, h: 5, color: .Strawberry.gray, fill: true)
            renderer.rectangle(x: 6 + 9, y: 6, w: 5, h: 5, color: .Strawberry.gray + 20)
            
            renderer.rectangle(x: 6 + 9 * 2, y: 6, w: 5, h: 5, color: .Strawberry.gray, fill: true)
            renderer.rectangle(x: 6 + 9 * 2, y: 6, w: 5, h: 5, color: .Strawberry.gray + 20)
        }
        
        if windowIsFocused { renderer.sprite(from: cursor, x: mx, y: my) }
    }
    
    fileprivate func drawToolbar(_ renderer: inout Renderer) {
        
    }
}
