
import Engine

@main
struct Stars: Game {
    static let display = (w: 320, h: 200)
    
    var x: Int = 16, y: Int = 16
    
    var layer1: [Star] = .init(computing: 1024, by: layer1Speed, display: display)
    var layer2: [Star] = .init(computing: 1024, by: layer2Speed, display: display)
    var layer3: [Star] = .init(computing: 1024, by: layer3Speed, display: display)
    
    static let layer1Speed = 0.75 / 2
    static let layer2Speed = 0.5 / 2
    static let layer3Speed = 0.25 / 2
    
    mutating func update(input: Input) {
        let mouse = input.mouse
        self.x = mouse.x
        self.y = mouse.y
        
        layer1.advance(by: Self.layer1Speed, display: Self.display)
        layer2.advance(by: Self.layer2Speed, display: Self.display)
        layer3.advance(by: Self.layer3Speed, display: Self.display)
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear()
        
        layer1.draw(using: &renderer, with: .white)
        layer2.draw(using: &renderer, with: .blue)
        layer3.draw(using: &renderer, with: .darkBlue)
        
        renderer.sprite(from: .cursor, x: self.x, y: self.y)
    }
}

typealias Star = (x: Double, y: Double)

extension [Star] {
    init(computing count: Int, by distance: Double, display: (w: Int, h: Int)) {
        self = []
        for _ in 1...count { self.advance(by: distance, display: display) }
    }
    mutating func advance(by distance: Double, display: (w: Int, h: Int)) {
        let h = Double(display.h)
        
        self.append((x: .random(in: 0..<Double(display.w)), y: 0))
        
        var toRemove: Int?
        for i in 0..<self.underestimatedCount {
            self[i].y += distance
            if self[i].y >= h {
                toRemove = i
            }
        }
        if let toRemove { self.remove(at: toRemove) }
    }
    
    func draw(using renderer: inout Renderer, with color: Color) {
        for star in self {
            renderer.pixel(x: Int(star.x), y: Int(star.y), color: color)
        }
    }
}
