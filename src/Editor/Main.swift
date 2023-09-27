
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

final class ColorView: View {
    convenience init(_ color: Color) {
        self.init()
        self.background = color
    }
}
