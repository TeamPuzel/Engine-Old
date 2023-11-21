// NOTE: Renderer can't be a protocol as that would disallow default arguments.

/// Safe, non-escapeable 2D software renderer.
public struct Renderer: ~Copyable {
    internal var display: Image
    
    internal init(width: Int, height: Int) {
        self.display = .init(width: width, height: height)
    }
    
    public mutating func clear(with color: Color = .black) {
        self.display = .init(width: self.display.width, height: self.display.height, color: color)
    }
    
    public mutating func pixel(x: Int, y: Int, color: Color = .white) {
        if x < 0 || y < 0 || x >= display.width || y >= display.height { return }
        self.display[x, y] = color
    }
    
    public mutating func sprite(from sprite: Sprite, x: Int, y: Int) {
        for (iy, column) in sprite.data.enumerated() {
            for (ix, pixel) in column.enumerated() {
                if let pixel {
                    self.pixel(x: x + ix, y: y + iy, color: pixel)
                }
            }
        }
    }
    
    public mutating func rectangle(x: Int, y: Int, w: Int, h: Int, color: Color = .white, fill: Bool = false) {
        for ix in 0..<w {
            for iy in 0..<h {
                if ix + x == x || ix + x == x + w - 1 || iy + y == y || iy + y == y + h - 1 || fill {
                    self.pixel(x: ix + x, y: iy + y, color: color)
                }
            }
        }
    }
    
    public mutating func circle(x: Int, y: Int, r: Int, color: Color = .white, fill: Bool = false) {
        guard r >= 0 else { return }
        for ix in (x - r)..<(x + r + 1) {
            for iy in (y - r)..<(y + r + 1) {
                let distance = Int(Double(((ix - x) * (ix - x)) + ((iy - y) * (iy - y))).squareRoot().rounded())
                if fill {
                    if distance <= r { pixel(x: ix, y: iy, color: color) }
                } else {
                    if distance == r { pixel(x: ix, y: iy, color: color) }
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
        for (iy, column) in sym.data.enumerated() {
            for (ix, flag) in column.enumerated() {
                if flag { self.pixel(x: x + ix, y: y + iy, color: foreground) }
            }
        }
    }
}
