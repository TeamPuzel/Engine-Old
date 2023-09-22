
public enum View {
    case container(Container)
    case primitive(Primitive)
}

public extension View {
    struct Container {
        let foreground: Color
        let background: Color?
        let direction: Direction
        let alignment: Alignment
        let children: [View]
        let maxWidth, maxHeight: Int?
        let margin: (left: Int, right: Int, up: Int, down: Int)
    }
    enum Primitive {
        case text(Text)
        case spacer(Spacer)
        case image(Image)
    }
}

public extension View.Primitive {
    struct Image {
        let data: [[Color]]
    }
    struct Spacer {
        let minSize, maxSize: Int?
    }
    struct Text {
        let content: String
    }
}

public extension View.Container {
    enum Alignment { case start, end, center }
    enum Direction { case horizontal, vertical, depth }
}

internal extension View {
    func draw(_ renderer: inout Renderer,
              x: Int, y: Int, w: Int, h: Int,
              isConstrained: Bool = false,
              // TODO! Move this and other environment state into a struct
              foreground: Color? = .white) -> ConstraintRequest? {
        
        switch self {
            // Draw the background if required
            case .container(let c) where c.background != nil:
                renderer.rectangle(x: x, y: y, w: w, h: h, color: c.background!, fill: true)
                fallthrough
            
            // Check if the branch is empty
            case .container(let c) where c.children.isEmpty: return nil
            
            case .container(let c) where c.direction == .vertical:
                let space = Int((Double(h) / Double(c.children.count)).rounded(.toNearestOrEven))
                c.children.enumerated()
                    .forEach { (i, child) in
                        if let constraint = child.draw(&renderer, x: x, y: y + (i * space), w: w, h: space, foreground: c.foreground) {
                            
                        }
                    }
                
            case .container(let c) where c.direction == .horizontal:
                let space = Int((Double(w) / Double(c.children.count)).rounded(.toNearestOrEven))
                c.children.enumerated()
                    .forEach { (i, child) in
                        if let constraint = child.draw(&renderer, x: x + (i * space), y: y, w: space, h: h, foreground: c.foreground) {
                            
                        }
                    }
                
                // This is the complicated part. If unconstrained the children will report
                // a new size and potentially adjust, for example text can be truncated
            case .primitive(let primitive):
                fatalError()
                switch primitive {
                    case .text(let text) where !isConstrained:
                        // For now text does not have wrapping.
                        // Implementation would be trivial to derive from the `Renderer.text`
                        return .strict(w: w, h: Symbol.symbolHeight)
//                    case .spacer(let spacer) where !isConstrained:
//                        return .directional(spacer.maxSize)
//                    case .image(let image) where !isConstrained:
//                        
//                    case .text(let text):
//                    case .spacer(let spacer):
//                    case .image(let image):
                    case _: break
                }
            
            // For now depth is unimplemented
            default:
                print("View not implemented: \(self)")
                return nil
        }
        return nil
    }
}

internal extension View {
    enum ConstraintRequest {
        case strict(w: Int, h: Int)
        case directional(Int)
    }
}
