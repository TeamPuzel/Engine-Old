
public struct Renderer: ~Copyable {
    internal var display: Display
    
    init(width: Int, height: Int) {
        self.display = .init(width: width, height: height)
    }
    
    public mutating func clear(with color: Color = .black) {
        self.display.clear(with: color)
    }
    
    public mutating func pixel(x: Int, y: Int, color: Color = .white) {
        if x < 0 || y < 0 || x >= display.width || y >= display.height { return }
        self.display[x, y] = color
    }
    
    public mutating func sprite(from sprite: Sprite, x: Int, y: Int) {
        for (sy, column) in sprite.data.enumerated() {
            for (sx, pixel) in column.enumerated() {
                if let pixel {
                    self.pixel(x: x + sx, y: y + sy, color: pixel)
                }
            }
        }
    }
    
    public mutating func rectangle(x: Int, y: Int, w: Int, h: Int, color: Color = .white, fill: Bool = false) {
        for sx in 0..<w {
            for sy in 0..<h {
                if sx + x == x || sx + x == x + w - 1 || sy + y == y || sy + y == y + h - 1 || fill {
                    self.pixel(x: sx + x, y: sy + y, color: color)
                }
            }
        }
    }
    
    public mutating func circle(x: Int, y: Int, r: Int, color: Color = .white, fill: Bool = false) {
        guard r >= 0 else { return }
        for sx in (x - r)..<(x + r + 1) {
            for sy in (y - r)..<(y + r + 1) {
                let distance = Int(Double(((sx - x) * (sx - x)) + ((sy - y) * (sy - y))).squareRoot().rounded())
                if fill {
                    if distance <= r { pixel(x: sx, y: sy, color: color) }
                } else {
                    if distance == r { pixel(x: sx, y: sy, color: color) }
                }
            }
        }
    }
    
    public mutating func text(_ string: some StringProtocol, x: Int, y: Int, foreground: Color = .white, background: Color? = nil, wrap: Bool = false) {
        let symbols = string.compactMap { char in Symbol(char) }
        for (off, sym) in symbols.enumerated() {
            if x + (4 * off) < display.width {
                self.symbol(sym, x: x + (off * 4), y: y, foreground: foreground, background: background)
            } else if wrap {
                self.text(
                    string.suffix(from: string.index(string.startIndex, offsetBy: off)),
                    x: 1, y: y + 6, foreground: foreground, background: background, wrap: wrap
                )
                break
            } else {
                break
            }
        }
    }
    
    private mutating func symbol(_ sym: Symbol, x: Int, y: Int, foreground: Color, background: Color?) {
        // Background
        if let bgc = background {
            self.rectangle(x: x - 1, y: y - 1, w: 5, h: 7, color: bgc, fill: true)
        }
        // Foreground
        for (sy, column) in sym.data.enumerated() {
            for (sx, flag) in column.enumerated() {
                if flag { self.pixel(x: x + sx, y: y + sy, color: foreground) }
            }
        }
    }
}

internal struct Display {
    internal var data: [Color]
    internal let width, height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.data = .init(repeating: .black, count: width * height)
    }
    
    subscript(x: Int, y: Int) -> Color {
        get { data[x + y * width] }
        set { data[x + y * width] = newValue }
    }
    
    mutating func clear(with color: Color = .black) {
        self.data = .init(repeating: color, count: width * height)
    }
}

public struct Color: Equatable {
    public let r, g, b: UInt8
    
    public init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    public init(white: UInt8) {
        self.r = white
        self.g = white
        self.b = white
    }
    
    public static let black      = Self(r: 0,   g: 0,   b: 0  )
    public static let darkBlue   = Self(r: 29,  g: 43,  b: 83 )
    public static let darkPurple = Self(r: 126, g: 37,  b: 83 )
    public static let darkGreen  = Self(r: 0,   g: 135, b: 81 )
    public static let brown      = Self(r: 171, g: 82,  b: 53 )
    public static let darkGray   = Self(r: 95,  g: 87,  b: 79 )
    public static let lightGray  = Self(r: 194, g: 195, b: 199)
    public static let white      = Self(r: 255, g: 241, b: 232)
    public static let red        = Self(r: 255, g: 0,   b: 77 )
    public static let orange     = Self(r: 255, g: 163, b: 0  )
    public static let yellow     = Self(r: 255, g: 236, b: 39 )
    public static let green      = Self(r: 0,   g: 228, b: 54 )
    public static let blue       = Self(r: 41,  g: 173, b: 255)
    public static let lavender   = Self(r: 131, g: 118, b: 156)
    public static let pink       = Self(r: 255, g: 119, b: 168)
    public static let peach      = Self(r: 255, g: 204, b: 170)
}

public extension Color {
    enum Strawberry {
        public static let red    = Color(r: 214, g: 95,  b: 118)
        public static let banana = Color(r: 230, g: 192, b: 130)
        public static let apple  = Color(r: 205, g: 220, b: 146)
        public static let lime   = Color(r: 177, g: 219, b: 159)
        public static let sky    = Color(r: 129, g: 171, b: 201)
        public static let lemon  = Color(r: 240, g: 202, b: 101)
        public static let orange = Color(r: 227, g: 140, b: 113)
        
        public static let white = Color(r: 224, g: 224, b: 224)
        public static let light = Color(r: 128, g: 128, b: 128)
        public static let gray  = Color(r: 59,  g: 59,  b: 59 )
        public static let dark  = Color(r: 28,  g: 28,  b: 28 )
        public static let black = Color(r: 15,  g: 15,  b: 15 )
    }
}

extension Color {
    public static func + (lhs: Color, rhs: Color) -> Color {
        .init(r: lhs.r + rhs.r, g: lhs.g + rhs.g, b: lhs.b + rhs.b)
    }
    public static func - (lhs: Color, rhs: Color) -> Color {
        .init(r: lhs.r - rhs.r, g: lhs.g - rhs.g, b: lhs.b - rhs.b)
    }
    public static func + (lhs: Color, rhs: UInt8) -> Color {
        .init(r: lhs.r + rhs, g: lhs.g + rhs, b: lhs.b + rhs)
    }
    public static func - (lhs: Color, rhs: UInt8) -> Color {
        .init(r: lhs.r - rhs, g: lhs.g - rhs, b: lhs.b - rhs)
    }
}

public struct Sprite {
    internal let data: [[Color?]]
}

public struct Image {
    public private(set) var data: [Color]
    public let width, height: Int
    
    public init(width: Int, height: Int, color: Color = .black) {
        self.width = width
        self.height = height
        self.data = .init(repeating: color, count: width * height)
    }
    
    public subscript(x: Int, y: Int) -> Color {
        get { data[x + y * width] }
        set { data[x + y * width] = newValue }
    }
}

extension Sprite: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = [Color?]
    
    public init(arrayLiteral elements: [Color?]...) {
        precondition(elements.count == 8 && elements.allSatisfy { $0.count == 8 })
        self.data = elements
    }
}

internal struct Symbol {
    internal let data: [[Bool]]
}

extension Symbol: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = [Bool]
    
    public init(arrayLiteral elements: [Bool]...) {
        precondition(elements.count == 5 && elements.allSatisfy { $0.count == 3 })
        self.data = elements
    }
    
    public static let lineStride = 6
    public static let symbolStride = 4
    public static let symbolHeight = 5
    public static let symbolWidth = 3
}

extension Symbol {
    init?(_ from: Character) {
        switch from {
            case "0": self = .digit0
            case "1": self = .digit1
            case "2": self = .digit2
            case "3": self = .digit3
            case "4": self = .digit4
            case "5": self = .digit5
            case "6": self = .digit6
            case "7": self = .digit7
            case "8": self = .digit8
            case "9": self = .digit9
            
            case "a", "A": self = .charA
            case "b", "B": self = .charB
            case "c", "C": self = .charC
            case "d", "D": self = .charD
            case "e", "E": self = .charE
            case "f", "F": self = .charF
            case "g", "G": self = .charG
            case "h", "H": self = .charH
            case "i", "I": self = .charI
            case "j", "J": self = .charJ
            case "k", "K": self = .charK
            case "l", "L": self = .charL
            case "m", "M": self = .charM
            case "n", "N": self = .charN
            case "o", "O": self = .charO
            case "p", "P": self = .charP
            case "q", "Q": self = .charQ
            case "r", "R": self = .charR
            case "s", "S": self = .charS
            case "t", "T": self = .charT
            case "u", "U": self = .charU
            case "v", "V": self = .charV
            case "w", "W": self = .charW
            case "x", "X": self = .charX
            case "y", "Y": self = .charY
            case "z", "Z": self = .charZ
            
            case "!":  self = .exclamationMark
            case "?":  self = .questionMark
            case "\"": self = .doubleQuote
            case "'":  self = .singleQuote
            case "+":  self = .plus
            case "-":  self = .minus
            case "=":  self = .equal
            case ".":  self = .period
            case ",":  self = .comma
            case ":":  self = .colon
            case ";":  self = .semicolon
            case "/":  self = .slash
            case "%":  self = .percentage
            case "(":  self = .roundBracketLeft
            case ")":  self = .roundBracketRight
            case "_":  self = .underscore
            case " ":  self = .space
            
            case _: return nil
        }
    }
}
