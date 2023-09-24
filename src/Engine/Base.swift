
import SDL

public protocol Game {
    init()
    mutating func update(input: Input)
    func draw(renderer: inout Renderer)
}

let pixelSize = 8
let windowMargin = pixelSize * 2
let windowSize = 512 + windowMargin

public extension Game {
    static func main() {
        SDL_Init(SDL_INIT_VIDEO)
        defer { SDL_Quit() }
        
        var instance = Self()
        let mirror = Mirror(reflecting: instance)
        let windowName = String(mirror.description.split(separator: " ").last!)
        
        if mirror.displayStyle == .class {
            fatalError(
                "Classes are not allowed to implement Game as they do not enforce self immutability required by draw."
            )
        }
        
        let window = SDL_CreateWindow(
            windowName,
            Int32(SDL_WINDOWPOS_CENTERED_MASK),
            Int32(SDL_WINDOWPOS_CENTERED_MASK),
            Int32(windowSize), Int32(windowSize),
            SDL_WINDOW_ALLOW_HIGHDPI.rawValue
        )
        defer { SDL_DestroyWindow(window) }
        
        let renderer = SDL_CreateRenderer(
            window, -1,
            SDL_RENDERER_ACCELERATED.rawValue |
            SDL_RENDERER_PRESENTVSYNC.rawValue
        )
        defer { SDL_DestroyRenderer(renderer) }
        
        SDL_ShowCursor(SDL_DISABLE)
        
        var api = Renderer()
        var event = SDL_Event()
        
        loop:
        while true {
            while SDL_PollEvent(&event) != 0 {
                switch event.type {
                    case SDL_QUIT.rawValue: break loop
                    default: break
                }
            }
            
            instance.update(input: Input())
            
            SDL_SetRenderDrawColor(renderer, 0, 0, 0, 1)
            SDL_RenderClear(renderer)
            instance.draw(renderer: &api)
            for (x, column) in api.display.enumerated() {
                for (y, pixel) in column.enumerated() {
                    let color = pixel.rgb
                    SDL_SetRenderDrawColor(renderer, color.r, color.g, color.b, 255)
                    var rect = SDL_Rect(
                        x: Int32(pixelSize * x + windowMargin),
                        y: Int32(pixelSize * y + windowMargin),
                        w: 8, h: 8
                    )
                    SDL_RenderFillRect(renderer, &rect)
                }
            }
            SDL_RenderPresent(renderer)
        }
        
    }
}

public struct Input {
    public let up, down, left, right, a, b: Bool
    public let mouse: (x: Int, y: Int, left: Bool, right: Bool)
    
    internal init() {
        var numKeys: Int32 = 0
        let keys = UnsafeBufferPointer(start: SDL_GetKeyboardState(&numKeys), count: Int(numKeys))
            .lazy.map { $0 == 1 }
        
        self.up    = keys[Int(SDL_SCANCODE_W.rawValue)] || keys[Int(SDL_SCANCODE_UP.rawValue)]
        self.down  = keys[Int(SDL_SCANCODE_S.rawValue)] || keys[Int(SDL_SCANCODE_DOWN.rawValue)]
        self.left  = keys[Int(SDL_SCANCODE_A.rawValue)] || keys[Int(SDL_SCANCODE_LEFT.rawValue)]
        self.right = keys[Int(SDL_SCANCODE_D.rawValue)] || keys[Int(SDL_SCANCODE_RIGHT.rawValue)]
        self.a     = keys[Int(SDL_SCANCODE_COMMA.rawValue)]
        self.b     = keys[Int(SDL_SCANCODE_PERIOD.rawValue)]
        
        var x: Int32 = 0
        var y: Int32 = 0
        let btns = SDL_GetMouseState(&x, &y)
        let left = btns & 1 != 0
        let right = btns & 3 != 0
        
        x /= Int32(pixelSize) / 2
        y /= Int32(pixelSize) / 2
        x -= 2
        y -= 2
        
        if x < 0 { x = 0 }
        if x > 127 { x = 127 }
        if y < 0 { y = 0 }
        if y > 127 { y = 127 }
        
        self.mouse = (Int(x), Int(y), left, right)
    }
}
