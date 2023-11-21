// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Engine",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(name: "Stars", dependencies: ["Engine"], path: "Examples/Stars"),
        .executableTarget(name: "SpriteEditor", dependencies: ["Engine"], path: "Tools/SpriteEditor"),
        
        .target(name: "Engine", dependencies: ["SDL"], path: "Engine"),
        
        .systemLibrary(name: "SDL", path: "System", pkgConfig: "sdl2")
    ]
)
