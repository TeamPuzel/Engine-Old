
public struct VStack<Content: View>: Primitive {
    internal let content: Content
    
    public init(@ViewBuilder body: () -> Content) {
        self.content = body()
    }
}

public struct HStack<Content: View>: Primitive {
    internal let content: Content
    
    public init(@ViewBuilder body: () -> Content) {
        self.content = body()
    }
}

public struct ZStack<Content: View>: Primitive {
    internal let content: Content
    
    public init(@ViewBuilder body: () -> Content) {
        self.content = body()
    }
}
