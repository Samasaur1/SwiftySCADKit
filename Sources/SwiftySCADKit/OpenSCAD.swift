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
    associatedtype Content: OpenSCAD

    var body: Self.Content { get }

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

public struct Cube: OpenSCAD {
    public var body: Never { fatalError() }
    let height: Double
    let width: Double
    let depth: Double
    let centered: Bool

    /// Creates a cube with the gievn side length.
    ///
    /// - Parameters:
    ///   - sideLength: The length of each side of the cube.
    ///   - centered: Whether or not the cube should be centered on the origin.
    public init(withSideLength sideLength: Double, centered: Bool) {
        self.init(height: sideLength, width: sideLength, depth: sideLength, centered: centered)
    }
    /// Creates a 'cube' (i.e. a rectangular prism) with the specified height, width, and depth.
    ///
    /// - Parameters:
    ///   - height: The height of the 'cube' (rectangular prism).
    ///   - width: The width of the 'cube' (rectangular prism).
    ///   - depth: The depth of the 'cube' (recangular prism).
    ///   - centered: Whether or not this object should be centered on the origin.
    public init(height: Double, width: Double, depth: Double, centered: Bool) {
        self.height = height
        self.width = width
        self.depth = depth
        self.centered = centered
    }

    public var scad: SCAD {
        .cube(height: height, width: width, depth: depth, centered: true)
    }
}
/// Creates a rectangular prism with the specified height, width, and depth.
///
/// - Parameters:
///   - height: The height of the rectangular prism.
///   - width: The width of the rectangular prism.
///   - depth: The depth of the recangular prism.
///   - centered: Whether or not this object should be centered on the origin.
/// - Returns: A rectangular prism with the specified dimensions.
public func RectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> some OpenSCAD {
    return Cube(height: height, width: width, depth: depth, centered: centered)
}

public struct Sphere: OpenSCAD {
    public var body: Never { fatalError() }
    let radius: Double

    /// Creates a sphere with the specified radius. It will be centered on the origin.
    ///
    /// - Parameter radius: The radius of the sphere.
    public init(radius: Double) {
        self.radius = radius
    }

    public var scad: SCAD {
        .sphere(radius)
    }
}

public struct Cylinder: OpenSCAD {
    public var body: Never { fatalError() }
    let height: Double
    let topRadius: Double
    let bottomRadius: Double
    let centered: Bool

    /// Creates a cylinder with the given height and top and bottom circles.
    ///
    /// If you want to make a nrmal cylinder, you should use the same value for `topRadius` and `bottomRadius`.
    /// However, if you want a tapered cylinder (like a beheaded cone) or even a cone, you can set one to be less than the other.
    ///
    /// For example, the following code makes a cone:
    ///
    ///     let cone = OpenSCAD.cylinder(height: 10, topRadius: 0, bottomRadius: 10, centered: true)
    ///
    /// - Parameters:
    ///   - height: The height of the cylinder.
    ///   - topRadius: The redius of the circle that makes up the top of the cylinder.
    ///   - bottomRadius: The radius of the circle that makes up the bottom of the cylinder.
    ///   - centered: Whether of not the cylinder is centered on the origin.
    public init(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) {
        self.height = height
        self.topRadius = topRadius
        self.bottomRadius = bottomRadius
        self.centered = centered
    }

    public var scad: SCAD {
        .cylinder(height: height, topRadius: topRadius, bottomRadius: bottomRadius, centered: centered)
    }
}

public struct Polyhedron: OpenSCAD {
    /// A representation of a point in 3D space.
    public struct Point: Hashable {
        /// The x value of the point.
        public var x: Double
        /// The y value of the point.
        public var y: Double
        /// The z value of the point.
        public var z: Double
        /// Creates a new Point with the specified coordinates. Has argument labels.
        ///
        /// - Parameters:
        ///   - x: The x coordinate.
        ///   - y: The y coordinate.
        ///   - z: The z coordinate.
        public init(x: Double, y: Double, z: Double) {
            self.x = x
            self.y = y
            self.z = z
        }
        /// Creates a new Point with the specified coordinates. Doesn't have argument labels.
        ///
        /// - Parameters:
        ///   - x: The x coordinate.
        ///   - y: The y coordinate.
        ///   - z: The z coordinate.
        public init(_ x: Double, _ y: Double, _ z: Double) {
            self.init(x: x, y: y, z: z)
        }
    }
    /// A representation of a face of a polyhedron.
    public struct Face: Hashable {
        public var points: [Point]
        public init(points: [Point]) {
            self.points = points
        }
        public init(points: Point...) {
            self.init(points: points)
        }
    }

    public var body: Never { fatalError() }
    let faces: [Face]

    /// Creates a polyhedron from an array of `Face`s that bound it.
    ///
    /// - Parameter faces: The faces of the polyhedron.
    public init(faces: [Face]) {
        self.faces = faces
    }
    /// Creates a polyhedron from a list of faces that bound it.
    ///
    /// - Parameter faces: The faces of the polyhedron.
    public init(faces: Face...) {
        self.init(faces: faces)
    }

    public var scad: SCAD {
        .polyhedron(faces: faces)
    }
}

/// Creates a triangular prism from the given faces.
///
/// This function accepts two tuples of three points each. Corresponding points are considered to be aobve/below each other. This knowledge allows you to create twisted triangular prisms.
///
/// Like with cylinders, you can make the top/bottom bigger/smaller than the other face. The results in a tapered triangular prism. If all the points in one side are in fact the same point, then you will recieve a triangular pyramid.
///
/// - Parameters:
///   - bottom: The bottom three points.
///   - top: The top three points.
/// - Returns: A triangular prism created from the given points.
public func TriangularPrism(bottom: (a: Polyhedron.Point, b: Polyhedron.Point, c: Polyhedron.Point), top: (a: Polyhedron.Point, b: Polyhedron.Point, c: Polyhedron.Point)) -> some OpenSCAD {
    return Polyhedron(faces: Polyhedron.Face(points: [bottom.a, bottom.c, bottom.b]), Polyhedron.Face(points: [top.a, top.b, top.c]), Polyhedron.Face(points: [top.b, top.a, bottom.a, bottom.b]), Polyhedron.Face(points: [top.a, top.c, bottom.c, bottom.a]), Polyhedron.Face(points: [top.c, top.b, bottom.b, bottom.c]))
}

/// Creates a hexahedron for the given faces.
///
/// This function accepts two tuples of four points each. Corresponding points are considered to be above/below each other. This knowledge allows you to create twisted hexahedrons.
///
/// Like with cylinders, you can make the top/bottom bigger/smaller than the other face. The results in a tapered hexahedron If all the points in one side are in fact the same point, then you will recieve a square pyramid.
///
/// - Parameters:
///   - bottom: The bottom four points.
///   - top: The top four points.
/// - Returns: A hexahedron created from the given points.
public func Hexahedron(bottom: (a: Polyhedron.Point, b: Polyhedron.Point, c: Polyhedron.Point, d: Polyhedron.Point), top: (a: Polyhedron.Point, b: Polyhedron.Point, c: Polyhedron.Point, d: Polyhedron.Point)) -> some OpenSCAD {
    return Polyhedron(faces: Polyhedron.Face(points: top.a, top.b, top.c, top.d), Polyhedron.Face(points: top.a, top.d, bottom.d, bottom.a), Polyhedron.Face(points: top.b, top.a, bottom.a, bottom.b), Polyhedron.Face(points: top.c, top.b, bottom.b, bottom.c), Polyhedron.Face(points: top.d, top.c, bottom.c, bottom.d), Polyhedron.Face(points: bottom.a, bottom.d, bottom.c, bottom.b))
}

public struct Union<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { return fatalError() }
    let content: Content

    public init(@SCADBuilder content: () -> Content) {
        self.content = content()
    }

    public var scad: SCAD {
        .union(content: content.scad)
    }
}

public struct Difference<ParentContent: OpenSCAD, ChildContent: OpenSCAD>: OpenSCAD {
    public var body: Never { return fatalError() }
    let parent: ParentContent
    let children: ChildContent

    public init(@SCADBuilder parent: () -> ParentContent, children: () -> ChildContent) {
        self.parent = parent()
        self.children = children()
    }

    public var scad: SCAD {
        .difference(parent: parent.scad, children: children.scad)
    }
}

public struct Intersection<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { return fatalError() }
    let content: Content

    public init(@SCADBuilder content: () -> Content) {
        self.content = content()
    }

    public var scad: SCAD {
        .intersection(content: content.scad)
    }
}

public struct Scale<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .scale(x: x, y: y, z: z, content: content.scad)
    }
}

public struct Resize<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(_ newx: Double, _ newy: Double, _ newz: Double, @SCADBuilder content: () -> Content) {
        x = newx
        y = newy
        z = newz
        self.content = content()
    }

    public var scad: SCAD {
        .resize(x: x, y: y, z: z, content: content.scad)
    }
}

public struct Rotate<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .rotate(x: x, y: y, z: z, content: content.scad)
    }
}

public struct Translate<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .translation(x: x, y: y, z: z, content: content.scad)
    }
}

public struct Mirror<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .mirror(x: x, y: y, z: z, content: content.scad)
    }
}

public struct Color<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let r: Double
    let g: Double
    let b: Double
    let a: Double

    public init(_ r: Double, _ g: Double, _ b: Double, _ a: Double, @SCADBuilder content: () -> Content) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.content = content()
    }

    public var scad: SCAD {
        .color(r: r, g: g, b: b, a: a, content: content.scad)
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
        .list(content: [value1.scad, value2.scad])
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
        .list(content: [value1.scad, value2.scad])
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
        .list(content: [value1.scad, value2.scad])
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

    public static func buildBlock(_ string: String) -> Literal {
        return Literal(string)
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

struct SomeSCAD: OpenSCAD {
    var body: some OpenSCAD {
        Union {
            Cube(withSideLength: 5, centered: true)
            Translate(10, 0, 0) {
                Sphere(radius: 5)
            }
        }
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

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
