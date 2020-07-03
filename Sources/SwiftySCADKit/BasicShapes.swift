import Foundation

public struct Cube: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
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

    var scad: SCAD {
        .cube(height: height, width: width, depth: depth, centered: centered)
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

public struct Sphere: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let radius: Double

    /// Creates a sphere with the specified radius. It will be centered on the origin.
    ///
    /// - Parameter radius: The radius of the sphere.
    public init(radius: Double) {
        self.radius = radius
    }

    var scad: SCAD {
        .sphere(radius)
    }
}

public struct Cylinder: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
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

    var scad: SCAD {
        .cylinder(height: height, topRadius: topRadius, bottomRadius: bottomRadius, centered: centered)
    }
}

public struct Polyhedron: OpenSCAD, BaseOpenSCAD {
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

    public var body: OpenSCAD { fatalError() }
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

    var scad: SCAD {
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
