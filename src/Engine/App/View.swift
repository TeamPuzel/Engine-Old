
open class View {
    public final var foreground: Color? = .white
    public final var background: Color? = nil
    public final var border: Color? = nil
    public final var paddding: Int = 0
    public final var children: [View] = []
    public final var direction: Direction = .vertical
    
    public init() {}
    public convenience init(@ViewBuilder body: () -> [View]) {
        self.init()
        self.children = body()
    }
    
    internal func draw(_ renderer: inout Renderer, env: Environment) {
        let env = Environment(
            x: env.x + paddding, y: env.y + paddding, w: env.w - paddding * 2, h: env.h - paddding * 2
        )
        if let background {
            renderer.rectangle(
                x: env.x, y: env.y, w: env.w, h: env.h, color: background, fill: true
            )
        }
        if let border {
            renderer.rectangle(x: env.x, y: env.y, w: env.w, h: env.h, color: border)
        }
        if !children.isEmpty {
            switch direction {
                case .depth: for child in children { child.draw(&renderer, env: env) }
                case .horizontal:
                    let space = Int((Double(env.w) / Double(children.count)).rounded(.toNearestOrEven))
                    for (i, child) in children.enumerated() {
                        child.draw(
                            &renderer, 
                            env: .init(x: env.x + space * i, y: env.y, w: space, h: env.h)
                        )
                    }
                case .vertical:
                    let space = Int((Double(env.h) / Double(children.count)).rounded(.toNearestOrEven))
                    for (i, child) in children.enumerated() {
                        child.draw(
                            &renderer,
                            env: .init(x: env.x, y: env.y + space * i, w: env.w, h: space)
                        )
                    }
            }
        }
    }
    
    public enum Direction {
        case horizontal, vertical, depth
    }
    
    internal struct Environment { let x, y, w, h: Int }
}

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock(_ components: View...) -> [View] { components }
}
