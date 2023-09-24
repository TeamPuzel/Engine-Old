
import Engine

@main
struct Editor: Application {
    var root: View = VStack {
        ColorView(.red)
        ColorView(.green)
        ColorView(.blue)
        HStack {
            ColorView(.yellow)
            ColorView(.darkBlue)
        }
        Text("Hello")
    }
}

final class HStack: View {
    override init() {
        super.init()
        self.direction = .horizontal
    }
}

final class VStack: View {
    override init() {
        super.init()
        self.direction = .vertical
    }
}

final class ZStack: View {
    override init() {
        super.init()
        self.direction = .depth
    }
}

final class ColorView: View {
    convenience init(_ color: Color) {
        self.init()
        self.background = color
    }
}

