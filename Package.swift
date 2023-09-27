// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Engine",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(name: "Stars", dependencies: ["Engine"], path: "src/Stars"),
        .executableTarget(name: "Editor", dependencies: ["Engine"], path: "src/Editor"),
        
        .target(name: "Engine", dependencies: ["SDL"], path: "src/Engine"),
        .systemLibrary(name: "SDL", path: "sys", pkgConfig: "sdl2")
    ]
)
