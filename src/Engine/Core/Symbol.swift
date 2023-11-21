
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


internal extension Symbol {
    static let digit0: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, true, true]
    ]

    static let digit1: Symbol = [
        [true, true, false],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [true, true, true]
    ]

    static let digit2: Symbol = [
        [true, true, true],
        [false, false, true],
        [true, true, true],
        [true, false, false],
        [true, true, true]
    ]

    static let digit3: Symbol = [
        [true, true, true],
        [false, false, true],
        [false, true, true],
        [false, false, true],
        [true, true, true]
    ]

    static let digit4: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, true, true],
        [false, false, true],
        [false, false, true]
    ]

    static let digit5: Symbol = [
        [true, true, true],
        [true, false, false],
        [true, true, true],
        [false, false, true],
        [true, true, true]
    ]

    static let digit6: Symbol = [
        [true, false, false],
        [true, false, false],
        [true, true, true],
        [true, false, true],
        [true, true, true]
    ]

    static let digit7: Symbol = [
        [true, true, true],
        [false, false, true],
        [false, false, true],
        [false, false, true],
        [false, false, true]
    ]

    static let digit8: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, true, true],
        [true, false, true],
        [true, true, true]
    ]

    static let digit9: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, true, true],
        [false, false, true],
        [false, false, true]
    ]

    static let charA: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, true, true],
        [true, false, true],
        [true, false, true]
    ]

    static let charB: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, true, false],
        [true, false, true],
        [true, true, true]
    ]

    static let charC: Symbol = [
        [false, true, true],
        [true, false, false],
        [true, false, false],
        [true, false, false],
        [false, true, true]
    ]

    static let charD: Symbol = [
        [true, true, false],
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, true, true]
    ]

    static let charE: Symbol = [
        [true, true, true],
        [true, false, false],
        [true, true, false],
        [true, false, false],
        [true, true, true]
    ]

    static let charF: Symbol = [
        [true, true, true],
        [true, false, false],
        [true, true, false],
        [true, false, false],
        [true, false, false]
    ]

    static let charG: Symbol = [
        [false, true, true],
        [true, false, false],
        [true, false, false],
        [true, false, true],
        [true, true, true]
    ]

    static let charH: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, true, true],
        [true, false, true],
        [true, false, true]
    ]

    static let charI: Symbol = [
        [true, true, true],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [true, true, true]
    ]

    static let charJ: Symbol = [
        [true, true, true],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [true, true, false]
    ]

    static let charK: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, true, false],
        [true, false, true],
        [true, false, true]
    ]

    static let charL: Symbol = [
        [true, false, false],
        [true, false, false],
        [true, false, false],
        [true, false, false],
        [true, true, true]
    ]

    static let charM: Symbol = [
        [true, true, true],
        [true, true, true],
        [true, false, true],
        [true, false, true],
        [true, false, true]
    ]

    static let charN: Symbol = [
        [true, true, false],
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, false, true]
    ]

    static let charO: Symbol = [
        [false, true, true],
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, true, false]
    ]

    static let charP: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, true, true],
        [true, false, false],
        [true, false, false]
    ]

    static let charQ: Symbol = [
        [false, true, false],
        [true, false, true],
        [true, false, true],
        [true, true, false],
        [false, true, true]
    ]

    static let charR: Symbol = [
        [true, true, true],
        [true, false, true],
        [true, true, false],
        [true, false, true],
        [true, false, true]
    ]

    static let charS: Symbol = [
        [false, true, true],
        [true, false, false],
        [true, true, true],
        [false, false, true],
        [true, true, false]
    ]

    static let charT: Symbol = [
        [true, true, true],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [false, true, false]
    ]

    static let charU: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [false, true, true]
    ]

    static let charV: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, true, true],
        [false, true, false]
    ]

    static let charW: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, false, true],
        [true, true, true],
        [true, true, true]
    ]

    static let charX: Symbol = [
        [true, false, true],
        [true, false, true],
        [false, true, false],
        [true, false, true],
        [true, false, true]
    ]

    static let charY: Symbol = [
        [true, false, true],
        [true, false, true],
        [true, true, true],
        [false, false, true],
        [true, true, true]
    ]

    static let charZ: Symbol = [
        [true, true, true],
        [false, false, true],
        [false, true, false],
        [true, false, false],
        [true, true, true]
    ]

    static let exclamationMark: Symbol = [
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [false, false, false],
        [false, true, false]
    ]

    static let questionMark: Symbol = [
        [true, true, true],
        [false, false, true],
        [false, true, true],
        [false, false, false],
        [false, true, false]
    ]

    static let doubleQuote: Symbol = [
        [true, false, true],
        [true, false, true],
        [false, false, false],
        [false, false, false],
        [false, false, false]
    ]
    
    static let singleQuote: Symbol = [
        [false, true, false],
        [false, true, false],
        [false, false, false],
        [false, false, false],
        [false, false, false]
    ]

    static let plus: Symbol = [
        [false, false, false],
        [false, true, false],
        [true, true, true],
        [false, true, false],
        [false, false, false]
    ]

    static let minus: Symbol = [
        [false, false, false],
        [false, false, false],
        [true, true, true],
        [false, false, false],
        [false, false, false]
    ]

    static let equal: Symbol = [
        [false, false, false],
        [true, true, true],
        [false, false, false],
        [true, true, true],
        [false, false, false]
    ]

    static let period: Symbol = [
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [false, true, false]
    ]

    static let comma: Symbol = [
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [false, true, false],
        [true, false, false]
    ]

    static let colon: Symbol = [
        [false, false, false],
        [false, true, false],
        [false, false, false],
        [false, true, false],
        [false, false, false]
    ]

    static let semicolon: Symbol = [
        [false, false, false],
        [false, true, false],
        [false, false, false],
        [false, true, false],
        [true, false, false]
    ]

    static let slash: Symbol = [
        [false, false, true],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [true, false, false]
    ]

    static let percentage: Symbol = [
        [true, false, true],
        [false, false, true],
        [false, true, false],
        [true, false, false],
        [true, false, true]
    ]

    static let roundBracketLeft: Symbol = [
        [false, true, false],
        [true, false, false],
        [true, false, false],
        [true, false, false],
        [false, true, false]
    ]

    static let roundBracketRight: Symbol = [
        [false, true, false],
        [false, false, true],
        [false, false, true],
        [false, false, true],
        [false, true, false]
    ]

    static let underscore: Symbol = [
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [true, true, true]
    ]

    static let space: Symbol = [
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [false, false, false],
        [false, false, false]
    ]

}
