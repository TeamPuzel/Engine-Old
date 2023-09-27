
import Engine

@main
struct Editor: Application {
    static let display = (w: 320, h: 200)
    
    var root: some View {
        VStack {
            Empty().background(.red)
            Empty().background(.blue)
        }
    }
}
