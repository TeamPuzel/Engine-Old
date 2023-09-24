
import Engine

@main
struct Editor: Game {
    var mx: Int = 0, my: Int = 0
    
    mutating func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
    }
    
    func draw(renderer: inout Renderer) {
        renderer.clear(with: .darkGray)
        drawToolbars(&renderer)
        drawCanvas(&renderer)
        drawPalette(&renderer)
        renderer.sprite(from: .cursor, x: mx, y: my)
    }
}

let toolbarHeight = 9

extension Editor {
    func drawToolbars(_ renderer: inout Renderer) {
        renderer.rectangle(x: 0, y: 0, w: 128, h: toolbarHeight, color: .red, fill: true)
        renderer.rectangle(x: 0, y: 128 - toolbarHeight, w: 128, h: toolbarHeight, color: .red, fill: true)
        
        renderer.text("sprite editor", x: 2, y: 2)
    }

    func drawCanvas(_ renderer: inout Renderer) {
        renderer.rectangle(x: 3, y: toolbarHeight + 3, w: 8 * 8, h: 8 * 8, color: .black, fill: true)
    }

    func drawPalette(_ renderer: inout Renderer) {
        let origin = (x: 8 * 8 + 6, y: toolbarHeight + 3)
        let elSize = 8
        renderer.rectangle(
            x: origin.x, y: origin.y,
            w: elSize * 4 + 2, h: elSize * 4 + 2,
            color: .black, fill: true
        )
        
        var color = 0
        for y in 0...3 {
            for x in 0...3 {
                renderer.rectangle(
                    x: origin.x + x * elSize + 1,
                    y: origin.y + y * elSize + 1,
                    w: elSize, h: elSize,
                    color: Color(rawValue: UInt8(color))!,
                    fill: true
                )
                color += 1
            }
        }
    }
}
