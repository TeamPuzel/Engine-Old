// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Engine",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(name: "Stars", dependencies: ["Engine"], path: "src/Stars"),
        .executableTarget(name: "Editor", dependencies: ["Engine", "UI"], path: "src/Editor"),
        
        .target(name: "Engine", dependencies: ["SDL"], path: "src/Engine/Core"),
        .target(name: "UI", dependencies: ["Engine"], path: "src/Engine/UI"),
        
        .systemLibrary(name: "SDL", path: "sys", pkgConfig: "sdl2")
    ]
)
