
open class Application: Game {
    public required init() { unsafeAllowMainClass = true }
    
    private final var mx: Int = 0, my: Int = 0
    private var color = Color.black
    private var tick = 0
    
//    private let layout: View = .vertical(align: .center, children: [
//        .horizontal(align: .center, children: [
//            .color(of: .red),
//            .color(of: .darkBlue)
//        ]),
//        .color(of: .darkPurple)
//    ])
    
    private let layout: View = .vertical(children: [
        .horizontal(children: [ .color(of: .darkGreen), .color(of: .green) ]),
        .color(of: .red),
        .color(of: .darkBlue)
    ])
    
    public final func update(input: Input) {
        mx = input.mouse.x
        my = input.mouse.y
        if tick % 20 == 0 { color = Color(rawValue: color.rawValue + 1) ?? .black }
        tick += 1
    }
    
    public final func draw(renderer: inout Renderer) {
        renderer.clear()
        drawView(renderer: &renderer, view: layout, x: 0, y: 0, w: 128, h: 128)
        renderer.sprite(from: .cursor, x: mx, y: my)
    }
}

func drawView(renderer: inout Renderer, view: View, x: Int, y: Int, w: Int, h: Int) {
    switch view {
        case .horizontal(let children):
            for (i, child) in children.enumerated() {
                let space = Int((Double(w) / Double(children.count)).rounded(.toNearestOrEven))
                drawView(renderer: &renderer,
                         view: child,
                         x: x + (space * i),
                         y: y,
                         w: space, 
                         h: h)
            }
        case .vertical(let children):
            for (i, child) in children.enumerated() {
                let space = Int((Double(h) / Double(children.count)).rounded(.toNearestOrEven))
                drawView(renderer: &renderer,
                         view: child,
                         x: x,
                         y: y + (space * i),
                         w: w,
                         h: space)
            }
        case .depth(_): break
        case .color(let color): renderer.rectangle(x: x, y: y, w: w, h: h, color: color, fill: true)
    }
}
