
public struct Window {
    
    
    public init(name: String = "Window", @ViewBuilder content: () -> [View]) {
        
    }
}

public typealias Scene = [Window]

@resultBuilder
public struct SceneBuilder {
    public static func buildBlock(_ components: Window...) -> [Window] { components }
}
