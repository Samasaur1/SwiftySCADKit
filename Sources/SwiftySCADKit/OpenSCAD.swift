import Foundation

indirect enum SCAD {
    case literal(literal: String)
    case list(content: [SCAD])

    // Basic Shapes
    static func cube(height: Double, width: Double, depth: Double, centered: Bool) -> SCAD {
        .literal(literal: "cube([\(width), \(depth), \(height)], \(centered));")
    }
    static func rectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> SCAD {
        return cube(height: height, width: width, depth: depth, centered: centered)
    }
    static func sphere(_ radius: Double) -> SCAD {
        return .literal(literal: "sphere(\(radius), $fn=\(OPENSCAD_CONFIG.SPHERE_RESOLUTION));")
    }
    static func cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> SCAD {
        return .literal(literal: "cylinder($fn = \(OPENSCAD_CONFIG.SPHERE_RESOLUTION), \(height), \(bottomRadius), \(topRadius), \(centered));")
    }
    static func polyhedron(faces: [Polyhedron.Face]) -> SCAD {
        var points: [Polyhedron.Point] = []
        for face in faces {
            for point in face.points {
                points.append(point)
            }
        }
        points.removeDuplicates()

        let c: () -> String = {
            var str = "polyhedron(\n    points = [\n        "
            for p in points {
                str += "[\(p.x), \(p.y), \(p.z)], "
            }
            str = String(str.dropLast(2))
            str += "\n    ],\n    faces = [\n        "
            for f in faces {
                str += "["
                for p in f.points {
                    str += "\(Int(points.firstIndex(of: p)!)), "
                }
                str = String(str.dropLast(2)) + "], "
            }
            str = String(str.dropLast(2))
            str += "\n    ],\nconvexity = 10);"
            return str
        }
        return .literal(literal: c())
    }

    // Boolean operators
    case union(content: SCAD)
    case difference(parent: SCAD, children: SCAD)
    case intersection(content: SCAD)

    static func `import`(path: String) -> SCAD {
        let url = URL(fileURLWithPath: path)
        return .literal(literal: #"import("\#(url.standardized.path)");\#n"#)
    }

    // Transformations
    case scale(x: Double, y: Double, z: Double, content: SCAD)
    case resize(x: Double, y: Double, z: Double, content: SCAD)
    case rotate(x: Double, y: Double, z: Double, content: SCAD)
    case translation(x: Double, y: Double, z: Double, content: SCAD)
    case mirror(x: Double, y: Double, z: Double, content: SCAD)
    case color(r: Double, g: Double, b: Double, a: Double, content: SCAD)
}

func parse(scad: SCAD) -> String {
    switch scad {
    case .literal(let str): return str
    case .list(let content):
        return content.map { parse(scad: $0) }.joined(separator: "\n")
    case .union(let content):
        return """
        union() {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case .difference(let parent, let children):
        return """
        difference() {
        \(parse(scad: parent).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        \(parse(scad: children).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case .intersection(let content):
        return """
        intersection() {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case let .scale(x, y, z, content):
        return """
        scale([\(x), \(y), \(z)]) {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case let .resize(x, y, z, content):
        return """
        resize([\(x), \(y), \(z)]) {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case let .rotate(x, y, z, content):
        return """
        rotate([\(x), \(y), \(z)]) {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case let .translation(x, y, z, content):
        return """
        translate([\(x), \(y), \(z)]) {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case let .mirror(x, y, z, content):
        return """
        mirror([\(x), \(y), \(z)]) {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    case let .color(r, g, b, a, content):
        return """
        color([\(r), \(g), \(b), \(a)]) {
        \(parse(scad: content).split(separator: "\n").map { "    " + $0 }.joined(separator: "\n"))
        }
        """
    }
}

public func parse(scad s: OpenSCAD) -> String {
    return parse(scad: skad(of: s))
}

public protocol OpenSCAD {
    var body: OpenSCAD { get }
}
protocol BaseOpenSCAD {
    var scad: SCAD { get }
}
func skad(of scad: OpenSCAD) -> SCAD {
    if let s = scad as? BaseOpenSCAD {
        return s.scad
    } else {
        return skad(of: scad.body)
    }
}

extension Never: OpenSCAD {
    public var body: OpenSCAD {
        fatalError()
    }
}

public struct SCADLiteral: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let literal: String

    /// Creates a new OpenSCAD literal with the specified raw value.
    /// **NOTE**: This raw value is **UNCHECKED**! If it is wrong, ALL YOUR OPENSCAD WON'T WORK!
    ///
    /// - Parameter SCAD: The raw value of this OpenSCAD struct.
    public init(_ SCAD: String) {
        self.literal = SCAD
    }

    var scad: SCAD {
        .literal(literal: literal)
    }
}

public struct SCADList: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let list: [OpenSCAD]

    var scad: SCAD {
        .list(content: list.map(skad(of:)))
    }
}

@_functionBuilder
public struct SCADBuilder {
    public static func buildBlock() -> SCADLiteral {
        return SCADLiteral("")
    }

    public static func buildBlock<Content: OpenSCAD>(_ content: Content) -> Content {
        return content
    }

    public static func buildBlock(_ list: OpenSCAD...) -> SCADList {
        return SCADList(list: list)
    }
}

/// A structure that represents configuration options.
public struct Config {
    /// The resolution of spheres (and other circular objects).
    public var SPHERE_RESOLUTION: Double = 50
    public var IMPORT_CONVEXITY: Int = 5
}

/// The configuration for SwiftySCADKit.
public var OPENSCAD_CONFIG: Config = Config()

public func OPENSCAD_copyToClipboard(_ scad: OpenSCAD) {
    let pipe = Pipe()
    let echo = Process()
    echo.launchPath = "/bin/echo"
    echo.arguments = ["-n", "\(parse(scad: scad))"]
    echo.standardOutput = pipe
    echo.launch()
    let pbcopy = Process()
    pbcopy.launchPath = "/usr/bin/pbcopy"
    pbcopy.standardInput = pipe
    pbcopy.launch()
    pbcopy.waitUntilExit()
}
public func OPENSCAD_print(_ scad: OpenSCAD) {
    print(parse(scad: scad))
}
#if os(macOS)
public func OPENSCAD_openInEditor(_ scad: OpenSCAD) {
    OPENSCAD_copyToClipboard(scad)
    NSAppleScript(source: """
tell application "OpenSCAD" to activate
delay 1
tell application "System Events"
    keystroke "n" using command down
    delay 0.3
    keystroke "a" using command down
    delay 0.1
    keystroke "v" using command down
    delay 0.1
    key code 96
end tell
""")!.executeAndReturnError(nil)
}
#endif
