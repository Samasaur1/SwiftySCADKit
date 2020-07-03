import Foundation

/// A representation of an OpenSCAD object.
///
/// The recommended way to create an OpenSCAD object is by using one of these static functions:
/// - cube(withSideLength:centered:)
/// - cube(height:width:depth:centered:)
/// - sphere(_:)
/// - cylinder(height:topRadius:bottomRadius:centered:)
/// - polyhedron(faces:)
/// - triangularPrism(bottom:top:)
public struct OpenSCAD {
    /// The raw OpenSCAD value of this object.
    public var SCADValue: String = ""
    /// This initializer is private so that it cannot be used.
    private init() {}
    /// Creates a new OpenSCAD struct with the specified OpenSCAD raw value.
    /// **NOTE**: This raw value is **UNCHECKED**! If it is wrong, ALL YOUR OPENSCAD WON'T WORK!
    ///
    /// - Parameter SCAD: The raw value of this OpenSCAD struct.
    public init(_ SCAD: String) {
        SCADValue = SCAD
    }
}


indirect enum SKAD {
    case literal(literal: String)
    case list(content: [SKAD])

    // Basic Shapes
    static func cube(height: Double, width: Double, depth: Double, centered: Bool) -> SKAD {
        .literal(literal: "cube([\(width), \(depth), \(height)], \(centered));")
    }
    /// Creates a rectangular prism with the specified height, width, and depth.
    ///
    /// - Parameters:
    ///   - height: The height of the rectangular prism.
    ///   - width: The width of the rectangular prism.
    ///   - depth: The depth of the recangular prism.
    ///   - centered: Whether or not this object should be centered on the origin.
    /// - Returns: A rectangular prism with the specified dimensions.
    static func rectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> SKAD {
        return cube(height: height, width: width, depth: depth, centered: centered)
    }
    static func sphere(_ radius: Double) -> SKAD {
        return .literal(literal: "sphere(\(radius), $fn=\(OPENSCAD_CONFIG.SPHERE_RESOLUTION));")
    }
    static func cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> SKAD {
        return .literal(literal: "cylinder($fn = \(OPENSCAD_CONFIG.SPHERE_RESOLUTION), \(height), \(bottomRadius), \(topRadius), \(centered));")
    }
    static func polyhedron(faces: [__Polyhedron.Face]) -> SKAD {
        var points: [__Polyhedron.Point] = []
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
    case union(content: SKAD)
    case difference(parent: SKAD, children: SKAD)
    case intersection(content: SKAD)

    static func `import`(path: String) -> SKAD {
        let url = URL(fileURLWithPath: path)
        return .literal(literal: #"import("\#(url.standardized.path)");\#n"#)
    }

    // Transformations
    case scale(x: Double, y: Double, z: Double, content: SKAD)
    case resize(x: Double, y: Double, z: Double, content: SKAD)
    case rotate(x: Double, y: Double, z: Double, content: SKAD)
    case translation(x: Double, y: Double, z: Double, content: SKAD)
    case mirror(x: Double, y: Double, z: Double, content: SKAD)
    case color(r: Double, g: Double, b: Double, a: Double, content: SKAD)
}

protocol SCAD {
    associatedtype Content: SCAD

    var body: Self.Content { get }

    var skad: SKAD { get }
}

extension Never: SCAD {
    var body: Never {
        return fatalError()
    }

    var skad: SKAD {
        .literal(literal: "")
    }
}

extension SCAD {
    var skad: SKAD {
        return body.skad
    }
}

struct Literal: SCAD {
    var body: Never { return fatalError() }
    let literal: String

    var skad: SKAD {
        .literal(literal: literal)
    }
}

struct __Cube: SCAD {
    var body: Never { fatalError() }
    let height: Double
    let width: Double
    let depth: Double
    let centered: Bool

    /// Creates a cube with the gievn side length.
    ///
    /// - Parameters:
    ///   - sideLength: The length of each side of the cube.
    ///   - centered: Whether or not the cube should be centered on the origin.
    init(withSideLength sideLength: Double, centered: Bool) {
        self.init(height: sideLength, width: sideLength, depth: sideLength, centered: centered)
    }
    /// Creates a 'cube' (i.e. a rectangular prism) with the specified height, width, and depth.
    ///
    /// - Parameters:
    ///   - height: The height of the 'cube' (rectangular prism).
    ///   - width: The width of the 'cube' (rectangular prism).
    ///   - depth: The depth of the 'cube' (recangular prism).
    ///   - centered: Whether or not this object should be centered on the origin.
    init(height: Double, width: Double, depth: Double, centered: Bool) {
        self.height = height
        self.width = width
        self.depth = depth
        self.centered = centered
    }

    var skad: SKAD {
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
func __RectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> some SCAD {
    return __Cube(height: height, width: width, depth: depth, centered: centered)
}

struct __Sphere: SCAD {
    var body: Never { fatalError() }
    let radius: Double

    /// Creates a sphere with the specified radius. It will be centered on the origin.
    ///
    /// - Parameter radius: The radius of the sphere.
    init(radius: Double) {
        self.radius = radius
    }

    var skad: SKAD {
        .sphere(radius)
    }
}

struct __Cylinder: SCAD {
    var body: Never { fatalError() }
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
    init(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) {
        self.height = height
        self.topRadius = topRadius
        self.bottomRadius = bottomRadius
        self.centered = centered
    }
}

struct __Polyhedron: SCAD {
    /// A representation of a point in 3D space.
    struct Point: Hashable {
        /// The x value of the point.
        var x: Double
        /// The y value of the point.
        var y: Double
        /// The z value of the point.
        var z: Double
        /// Creates a new Point with the specified coordinates. Has argument labels.
        ///
        /// - Parameters:
        ///   - x: The x coordinate.
        ///   - y: The y coordinate.
        ///   - z: The z coordinate.
        init(x: Double, y: Double, z: Double) {
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
        init(_ x: Double, _ y: Double, _ z: Double) {
            self.init(x: x, y: y, z: z)
        }
    }
    /// A representation of a face of a polyhedron.
    struct Face: Hashable {
        var points: [Point]
        init(points: [Point]) {
            self.points = points
        }
        init(points: Point...) {
            self.init(points: points)
        }
    }

    var body: Never { fatalError() }
    let faces: [Face]

    /// Creates a polyhedron from an array of `Face`s that bound it.
    ///
    /// - Parameter faces: The faces of the polyhedron.
    init(faces: [Face]) {
        self.faces = faces
    }
    /// Creates a polyhedron from a list of faces that bound it.
    ///
    /// - Parameter faces: The faces of the polyhedron.
    init(faces: Face...) {
        self.init(faces: faces)
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
func __TriangularPrism(bottom: (a: __Polyhedron.Point, b: __Polyhedron.Point, c: __Polyhedron.Point), top: (a: __Polyhedron.Point, b: __Polyhedron.Point, c: __Polyhedron.Point)) -> some SCAD {
    return __Polyhedron(faces: __Polyhedron.Face(points: [bottom.a, bottom.c, bottom.b]), __Polyhedron.Face(points: [top.a, top.b, top.c]), __Polyhedron.Face(points: [top.b, top.a, bottom.a, bottom.b]), __Polyhedron.Face(points: [top.a, top.c, bottom.c, bottom.a]), __Polyhedron.Face(points: [top.c, top.b, bottom.b, bottom.c]))
}

struct __Union<Content: SCAD>: SCAD {
    var body: Never { return fatalError() }
    let content: Content

    init(@SCADBuilder content: () -> Content) {
        self.content = content()
    }

    var skad: SKAD {
        .union(content: content.skad)
    }
}

struct __Difference<Content: SCAD>: SCAD {
    var body: Never { return fatalError() }
    let parent: Content
    let children: Content

    init(@SCADBuilder parent: () -> Content, children: () -> Content) {
        self.parent = parent()
        self.children = children()
    }

    var skad: SKAD {
        .difference(parent: parent.skad, children: children.skad)
    }
}

struct __Intersection<Content: SCAD>: SCAD {
    var body: Never { return fatalError() }
    let content: Content

    init(@SCADBuilder content: () -> Content) {
        self.content = content()
    }

    var skad: SKAD {
        .intersection(content: content.skad)
    }
}

struct __Scale<Content: SCAD>: SCAD {
    var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    var skad: SKAD {
        .scale(x: x, y: y, z: z, content: content.skad)
    }
}

struct __Resize<Content: SCAD>: SCAD {
    var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    init(_ newx: Double, _ newy: Double, _ newz: Double, @SCADBuilder content: () -> Content) {
        x = newx
        y = newy
        z = newz
        self.content = content()
    }

    var skad: SKAD {
        .resize(x: x, y: y, z: z, content: content.skad)
    }
}

struct __Rotate<Content: SCAD>: SCAD {
    var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    var skad: SKAD {
        .rotate(x: x, y: y, z: z, content: content.skad)
    }
}

struct __Translate<Content: SCAD>: SCAD {
    var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    var skad: SKAD {
        .translation(x: x, y: y, z: z, content: content.skad)
    }
}

struct __Mirror<Content: SCAD>: SCAD {
    var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    init(_ dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    var skad: SKAD {
        .mirror(x: x, y: y, z: z, content: content.skad)
    }
}

struct __Color<Content: SCAD>: SCAD {
    var body: Never { fatalError() }
    let content: Content
    let r: Double
    let g: Double
    let b: Double
    let a: Double

    init(_ r: Double, _ g: Double, _ b: Double, _ a: Double, @SCADBuilder content: () -> Content) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.content = content()
    }

    var skad: SKAD {
        .color(r: r, g: g, b: b, a: a, content: content.skad)
    }
}

protocol TupleSCAD: SCAD {}
struct TupleSCAD2<T1: SCAD, T2: SCAD>: TupleSCAD {
    var body: Never { return fatalError() }

    let value1: T1
    let value2: T2
    init(_ value1: T1, _ value2: T2) {
      self.value1 = value1
      self.value2 = value2
    }

    var skad: SKAD {
        .list(content: [value1.skad, value2.skad])
    }
}

@_functionBuilder
struct SCADBuilder {
    static func buildBlock() -> Literal {
        return Literal(literal: "")
    }

    static func buildBlock<Content: SCAD>(_ content: Content) -> Content {
        return content
    }

    static func buildBlock<C0: SCAD, C1: SCAD>(_ c0: C0, _ c1: C1) -> TupleSCAD2<C0, C1> {
        return TupleSCAD2(c0, c1)
    }

//    static func buildExpression(_ string: String) -> OpenSCAD {
//        return OpenSCAD(string)
//    }
//
//    static func buildExpression(_ scad: OpenSCAD) -> OpenSCAD {
//        return scad
//    }
//
//    static func buildBlock(_ scad: OpenSCAD...) -> OpenSCAD {
//        return OpenSCAD.union(<#T##parent: OpenSCAD##OpenSCAD#>, <#T##children: [OpenSCAD]##[OpenSCAD]#>)
//    }
//
//    static func buildExpression(_ scad: [OpenSCAD]) -> OpenSCAD {
//
//    }
}

struct SomeSCAD: SCAD {
    var body: some SCAD {
        __Union {
            __Cube(withSideLength: 5, centered: true)
            __Translate(10, 0, 0) {
                __Sphere(radius: 5)
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

public func OPENSCAD_copyToClipboard(_ scad: OpenSCAD) {
    let pipe = Pipe()
    let echo = Process()
    echo.launchPath = "/bin/echo"
    echo.arguments = ["-n", "\(scad.SCADValue)"]
    echo.standardOutput = pipe
    echo.launch()
    let pbcopy = Process()
    pbcopy.launchPath = "/usr/bin/pbcopy"
    pbcopy.standardInput = pipe
    pbcopy.launch()
    pbcopy.waitUntilExit()
}
public func OPENSCAD_print(_ scad: OpenSCAD) {
    print(scad.SCADValue)
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
