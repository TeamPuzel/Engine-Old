
struct Environment {
    let x, y, w, h: Int
    let windowIsFocused: Bool
}

protocol Surface {
    func draw(_ renderer: inout Renderer, env: Environment)
}

struct Toolbar: Surface {
    func draw(_ renderer: inout Renderer, env: Environment) {
        renderer.rectangle(
            x: 0, y: 0, w: env.w, h: 15, color: .Strawberry.gray - (env.windowIsFocused ? 15 : 20), fill: true
        )
        renderer.rectangle(x: 0, y: 15, w: env.w, h: 1, color: .Strawberry.gray, fill: true)
        renderer.rectangle(x: 0, y: 16, w: env.w, h: 1, color: .Strawberry.black, fill: true)
    }
}

struct Content: Surface {
    func draw(_ renderer: inout Renderer, env: Environment) {
        renderer.rectangle(x: 0, y: 17, w: env.w, h: env.h - 11, color: .Strawberry.gray - 30, fill: true)
    }
}
