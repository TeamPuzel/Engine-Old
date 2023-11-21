
import Engine

public extension Color {
    enum UI {
        public static let primary = Color.white
        public static let secondary = UI.primary - 20
        public static let tertiary = UI.secondary - 20
        public static let quaternary = UI.tertiary - 20
        public static let background = Color(white: 15)
    }
}
