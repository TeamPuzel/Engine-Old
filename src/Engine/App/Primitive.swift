
open class Text: View {
    public final var text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    final override func draw(_ renderer: inout Renderer, env: View.Environment) {
        renderer.text(text[...], x: env.x, y: env.y)
    }
}

public final class HStack: View {
    public override init() {
        super.init()
        self.direction = .horizontal
    }
}

public final class VStack: View {
    public override init() {
        super.init()
        self.direction = .vertical
    }
}

public final class ZStack: View {
    public override init() {
        super.init()
        self.direction = .depth
    }
}
