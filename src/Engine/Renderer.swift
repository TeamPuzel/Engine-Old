
public struct Renderer: ~Copyable {
    internal var display: Display = .init(repeating: .init(repeating: .black, count: 128), count: 128)
    
    public mutating func clear(with color: Color = .black) {
        self.display = .init(repeating: .init(repeating: color, count: 128), count: 128)
    }
    
    public mutating func pixel(x: Int, y: Int, color: Color = .white) {
        if x < 0 || y < 0 || x > 127 || y > 127 { return }
        self.display[x][y] = color
    }
    
    public mutating func sprite(from sprite: Sprite, x: Int, y: Int, transparency: Color? = .black) {
        for (sy, column) in sprite.data.enumerated() {
            for (sx, pixel) in column.enumerated() {
                if let t = transparency { if t == pixel { continue } }
                self.pixel(x: x + sx, y: y + sy, color: pixel)
            }
        }
    }
    
    public mutating func rectangle(x: Int, y: Int, w: Int, h: Int, color: Color = .white, fill: Bool = false) {
        for sx in 0..<w {
            for sy in 0..<h {
                if sx == x || sx == x + w - 1 || sy == y || sy == y + h - 1 || fill {
                    self.pixel(x: sx + x, y: sy + y, color: color)
                }
            }
        }
    }
    
    public mutating func text(_ string: Substring, x: Int, y: Int, foreground: Color = .white, background: Color? = nil, wrap: Bool = false) {
        let symbols = string.compactMap { char in Symbol(char) }
        for (off, sym) in symbols.enumerated() {
            if x + (4 * off) < 128 {
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
            self.rectangle(x: x - 1, y: y - 1, w: 4, h: 7, color: bgc, fill: true)
        }
        // Foreground
        for (sy, column) in sym.data.enumerated() {
            for (sx, flag) in column.enumerated() {
                if flag { self.pixel(x: x + sx, y: y + sy, color: foreground) }
            }
        }
    }
    
    public static let lineHeight = 6
}

internal typealias Display = [[Color]]

public enum Color: UInt8 {
    case black
    case darkBlue
    case darkPurple
    case darkGreen
    case brown
    case darkGray
    case lightGray
    case white
    case red
    case orange
    case yellow
    case green
    case blue
    case lavender
    case pink
    case peach
    
    internal var rgb: RGB {
        switch self {
            case .black:      RGB(r: 0,   g: 0,   b: 0  )
            case .darkBlue:   RGB(r: 29,  g: 43,  b: 83 )
            case .darkPurple: RGB(r: 126, g: 37,  b: 83 )
            case .darkGreen:  RGB(r: 0,   g: 135, b: 81 )
            case .brown:      RGB(r: 171, g: 82,  b: 53 )
            case .darkGray:   RGB(r: 95,  g: 87,  b: 79 )
            case .lightGray:  RGB(r: 194, g: 195, b: 199)
            case .white:      RGB(r: 255, g: 241, b: 232)
            case .red:        RGB(r: 255, g: 0,   b: 77 )
            case .orange:     RGB(r: 255, g: 163, b: 0  )
            case .yellow:     RGB(r: 255, g: 236, b: 39 )
            case .green:      RGB(r: 0,   g: 228, b: 54 )
            case .blue:       RGB(r: 41,  g: 173, b: 255)
            case .lavender:   RGB(r: 131, g: 118, b: 156)
            case .pink:       RGB(r: 255, g: 119, b: 168)
            case .peach:      RGB(r: 255, g: 204, b: 170)
        }
    }
}

internal struct RGB { var r, g, b: UInt8 }

public struct Sprite {
    internal let data: [[Color]]
}

extension Sprite: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = [Color]
    
    public init(arrayLiteral elements: [Color]...) {
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
            
            case "!": self = .exclamationMark
            case "?": self = .questionMark
            case "\"": self = .doubleQuote
            case "+": self = .plus
            case "-": self = .minus
            case "=": self = .equal
            case ".": self = .period
            case ",": self = .comma
            case ":": self = .colon
            case ";": self = .semicolon
            case "/": self = .slash
            case "%": self = .percentage
            case "(": self = .roundBracketLeft
            case ")": self = .roundBracketRight
            case "_": self = .underscore
            case " ": self = .space
            
            default: return nil
        }
    }
}