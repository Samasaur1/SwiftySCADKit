import Foundation

public indirect enum SCAD {
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

public func parse<T: OpenSCAD>(scad: T) -> String {
    return parse(scad: scad.scad)
}

public protocol OpenSCAD {
    associatedtype Body: OpenSCAD

    var body: Self.Body { get }

    var scad: SCAD { get }
}

extension Never: OpenSCAD {
    public var body: Never {
        return fatalError()
    }

    public var scad: SCAD {
        .literal(literal: "")
    }
}

public extension OpenSCAD {
    var scad: SCAD {
        return body.scad
    }
}

public struct Literal: OpenSCAD {
    public var body: Never { return fatalError() }
    let literal: String

    /// Creates a new OpenSCAD literal with the specified raw value.
    /// **NOTE**: This raw value is **UNCHECKED**! If it is wrong, ALL YOUR OPENSCAD WON'T WORK!
    ///
    /// - Parameter SCAD: The raw value of this OpenSCAD struct.
    public init(_ SCAD: String) {
        self.literal = SCAD
    }

    public var scad: SCAD {
        .literal(literal: literal)
    }
}

public protocol TupleSCAD: OpenSCAD {}
public struct TupleSCAD2<T1: OpenSCAD, T2: OpenSCAD>: TupleSCAD {
    public var body: Never { return fatalError() }

    let value1: T1
    let value2: T2

    init(_ v1: T1, _ v2: T2) {
        value1 = v1
        value2 = v2
    }

    public var scad: SCAD {
        .list(content: [value1.scad, value2.scad])
    }
}
public struct TupleSCAD3<T1: OpenSCAD, T2: OpenSCAD, T3: OpenSCAD>: TupleSCAD {
    public var body: Never { return fatalError() }

    let value1: T1
    let value2: T2
    let value3: T3

    init(_ v1: T1, _ v2: T2, _ v3: T3) {
        value1 = v1
        value2 = v2
        value3 = v3
    }

    public var scad: SCAD {
        .list(content: [value1.scad, value2.scad, value3.scad])
    }
}
public struct TupleSCAD4<T1: OpenSCAD, T2: OpenSCAD, T3: OpenSCAD, T4: OpenSCAD>: TupleSCAD {
    public var body: Never { return fatalError() }

    let value1: T1
    let value2: T2
    let value3: T3
    let value4: T4

    init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4) {
        value1 = v1
        value2 = v2
        value3 = v3
        value4 = v4
    }

    public var scad: SCAD {
        .list(content: [value1.scad, value2.scad, value3.scad, value4.scad])
    }
}
public struct TupleSCAD5<T1: OpenSCAD, T2: OpenSCAD, T3: OpenSCAD, T4: OpenSCAD, T5: OpenSCAD>: TupleSCAD {
    public var body: Never { return fatalError() }

    let value1: T1
    let value2: T2
    let value3: T3
    let value4: T4
    let value5: T5

    init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5) {
        value1 = v1
        value2 = v2
        value3 = v3
        value4 = v4
        value5 = v5
    }

    public var scad: SCAD {
        .list(content: [value1.scad, value2.scad, value3.scad, value4.scad, value5.scad])
    }
}

@_functionBuilder
public struct SCADBuilder {
    public static func buildBlock() -> Literal {
        return Literal("")
    }

    public static func buildBlock<Content: OpenSCAD>(_ content: Content) -> Content {
        return content
    }

    public static func buildBlock<C0: OpenSCAD, C1: OpenSCAD>(_ c0: C0, _ c1: C1) -> TupleSCAD2<C0, C1> {
        return TupleSCAD2(c0, c1)
    }

    public static func buildBlock<C0: OpenSCAD, C1: OpenSCAD, C2: OpenSCAD>(_ c0: C0, _ c1: C1, _ c2: C2) -> TupleSCAD3<C0, C1, C2> {
        return TupleSCAD3(c0, c1, c2)
    }

    public static func buildBlock<C0: OpenSCAD, C1: OpenSCAD, C2: OpenSCAD, C3: OpenSCAD>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleSCAD4<C0, C1, C2, C3> {
        return TupleSCAD4(c0, c1, c2, c3)
    }

    public static func buildBlock<C0: OpenSCAD, C1: OpenSCAD, C2: OpenSCAD, C3: OpenSCAD, C4: OpenSCAD>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleSCAD5<C0, C1, C2, C3, C4> {
        return TupleSCAD5(c0, c1, c2, c3, c4)
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

public func OPENSCAD_copyToClipboard<T: OpenSCAD>(_ scad: T) {
    let pipe = Pipe()
    let echo = Process()
    echo.launchPath = "/bin/echo"
    echo.arguments = ["-n", "\(parse(scad: scad.scad))"]
    echo.standardOutput = pipe
    echo.launch()
    let pbcopy = Process()
    pbcopy.launchPath = "/usr/bin/pbcopy"
    pbcopy.standardInput = pipe
    pbcopy.launch()
    pbcopy.waitUntilExit()
}
public func OPENSCAD_print<T: OpenSCAD>(_ scad: T) {
    print(parse(scad: scad.scad))
}
#if os(macOS)
public func OPENSCAD_openInEditor<T: OpenSCAD>(_ scad: T) {
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
