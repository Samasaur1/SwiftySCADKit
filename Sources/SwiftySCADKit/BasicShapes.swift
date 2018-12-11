//
//  BasicShapes.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Cube / Rectangular Prism

public extension OpenSCAD {
    /// Creates a cube with the gievn side length.
    ///
    /// - Parameters:
    ///   - sideLength: The length of each side of the cube.
    ///   - centered: Whether or not the cube should be centered on the origin.
    /// - Returns: A cube with the specified side length.
    public static func cube(withSideLength sideLength: Double, centered: Bool) -> OpenSCAD {
        return OpenSCAD("cube([\(sideLength), \(sideLength), \(sideLength)], \(centered));")
    }
    /// Creates a 'cube' (i.e. a rectangular prism) with the specified height, width, and depth.
    ///
    /// - Parameters:
    ///   - height: The height of the 'cube' (rectangular prism).
    ///   - width: The width of the 'cube' (rectangular prism).
    ///   - depth: The depth of the 'cube' (recangular prism).
    ///   - centered: Whether or not this object should be centered on the origin.
    /// - Returns: A 'cube' (rectangular prism) with the specified dimensions.
    public static func cube(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
        return OpenSCAD("cube([\(width), \(depth), \(height)], \(centered));")
    }
    /// Creates a rectangular prism with the specified height, width, and depth.
    ///
    /// - Parameters:
    ///   - height: The height of the rectangular prism.
    ///   - width: The width of the rectangular prism.
    ///   - depth: The depth of the recangular prism.
    ///   - centered: Whether or not this object should be centered on the origin.
    /// - Returns: A rectangular prism with the specified dimensions.
    public static func rectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
        return cube(height:height, width:width, depth: depth, centered: centered)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.cube")
/// **DEPRECATED**: Use `OpenSCAD.cube(withSideLength:centered:)` instead.
/// Creates a cube with the gievn side length.
///
/// - Parameters:
///   - sideLength: The length of each side of the cube.
///   - centered: Whether or not the cube should be centered on the origin.
/// - Returns: A cube with the specified side length.
public func Cube(withSideLength sideLength: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cube(withSideLength: sideLength, centered: centered)
}
/// **DEPRECATED**: Use `OpenSCAD.cube(height:width:depth:centered:)` instead.
/// Creates a 'cube' (i.e. a rectangular prism) with the specified height, width, and depth.
///
/// - Parameters:
///   - height: The height of the 'cube' (rectangular prism).
///   - width: The width of the 'cube' (rectangular prism).
///   - depth: The depth of the 'cube' (recangular prism).
///   - centered: Whether or not this object should be centered on the origin.
/// - Returns: A 'cube' (rectangular prism) with the specified dimensions.
@available(*, deprecated, renamed: "OpenSCAD.cube")
public func Cube(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cube(height: height, width: width, depth: depth, centered: centered)
}
/// **DEPRECATED**: Use `OpenSCAD.rectangularPrism(height:width:depth:centered)` instead.
/// Creates a rectangular prism with the specified height, width, and depth.
///
/// - Parameters:
///   - height: The height of the rectangular prism.
///   - width: The width of the rectangular prism.
///   - depth: The depth of the recangular prism.
///   - centered: Whether or not this object should be centered on the origin.
/// - Returns: A rectangular prism with the specified dimensions.
@available(*, deprecated, renamed: "OpenSCAD.rectangularPrism")
public func RectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cube(height: height, width: width, depth: depth, centered: centered)
}

//MARK: - Sphere

public extension OpenSCAD {
    /// Creates a sphere with the specified radius. It will be centered on the origin.
    ///
    /// - Parameter radius: The radius of the sphere.
    /// - Returns: A sphere with the specified radius.
    public static func sphere(_ radius: Double) -> OpenSCAD {
        return OpenSCAD("sphere(\(radius), $fn=\(OPENSCAD_CONFIG.SPHERE_RESOLUTION));")
    }
}

@available(*, deprecated, renamed: "OpenSCAD.sphere")
/// **DEPRECATED**: Use `OpenSCAD.sphere(_:)` instead.
/// Creates a sphere with the specified radius. It will be centered on the origin.
///
/// - Parameter radius: The radius of the sphere.
/// - Returns: A sphere with the specified radius.
public func Sphere(_ radius: Double) -> OpenSCAD {
    return OpenSCAD.sphere(radius)
}

//MARK: - Cylinder

public extension OpenSCAD {
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
    /// - Returns: A cylinder with the specified dimensions.
    public static func cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> OpenSCAD {
        return OpenSCAD("cylinder($fn = \(OPENSCAD_CONFIG.SPHERE_RESOLUTION), \(height), \(bottomRadius), \(topRadius), \(centered));")
    }
}

@available(*, deprecated, renamed: "OpenSCAD.cylinder")
/// Creates a cylinder with the given height and top and bottom circles.
///
/// If you want to make a nrmal cylinder, you should use the same value for `topRadius` and `bottomRadius`.
/// However, if you want a tapered cylinder (like a beheaded cone) or even a cone, you can set one to be less than the other.
///
/// For example, the following code makes a cone:
///
///     let cone = Cylinder(height: 10, topRadius: 0, bottomRadius: 10, centered: true)
///
/// - Parameters:
///   - height: The height of the cylinder.
///   - topRadius: The redius of the circle that makes up the top of the cylinder.
///   - bottomRadius: The radius of the circle that makes up the bottom of the cylinder.
///   - centered: Whether of not the cylinder is centered on the origin.
/// - Returns: A cylinder with the specified dimensions.
public func Cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cylinder(height: height, topRadius: topRadius, bottomRadius: bottomRadius, centered: centered)
}

//MARK: - Polyhedron

public extension OpenSCAD {
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
    /// Creates a polyhedron from an array of `Face`s that bound it.
    ///
    /// - Parameter faces: The faces of the polyhedron.
    /// - Returns: A polyhedron with the given faces.
    public static func polyhedron(faces: [Face]) -> OpenSCAD {
        var points: [Point] = []
        for face in faces {
            for point in face.points {
                points.append(point)
            }
        }
        points.removeDuplicates()
        
        let SCADClosure: () -> String = {
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
        return OpenSCAD(SCADClosure())
    }
    /// Creates a polyhedron from a list of faces that bound it.
    ///
    /// - Parameter faces: The faces of the polyhedron.
    /// - Returns: A polyhedron with the given faces.
    public static func polyhedron(faces: Face...) -> OpenSCAD {
        return polyhedron(faces: faces)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.polyhedron")
/// **DEPRECATED**: `Use OpenSCAD.polyhedron(faces:)` instead.
/// Creates a polyhedron from a list of faces that bound it.
///
/// - Parameter faces: The faces of the polyhedron.
/// - Returns: A polyhedron with the given faces.
public func Polyhedron(faces: OpenSCAD.Face...) -> OpenSCAD {
    return OpenSCAD.polyhedron(faces: faces)
}
@available(*, deprecated, renamed: "OpenSCAD.polyhedron")
/// **DEPRECATED**: `Use OpenSCAD.polyhedron(faces:)` instead.
/// Creates a polyhedron from an array of `Face`s that bound it.
///
/// - Parameter faces: The faces of the polyhedron.
/// - Returns: A polyhedron with the given faces.
public func Polyhedron(faces: [OpenSCAD.Face]) -> OpenSCAD {
    return OpenSCAD.polyhedron(faces: faces)
}

//MARK: - Triangular Prism

public extension OpenSCAD {
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
    public static func triangularPrism(bottom: (a: Point, b: Point, c: Point), top: (a: Point, b: Point, c: Point)) -> OpenSCAD {
        return polyhedron(faces: Face(points: [bottom.a, bottom.c, bottom.b]), Face(points: [top.a, top.b, top.c]), Face(points: [top.b, top.a, bottom.a, bottom.b]), Face(points: [top.a, top.c, bottom.c, bottom.a]), Face(points: [top.c, top.b, bottom.b, bottom.c]))
    }
}

@available(*, deprecated, renamed: "OpenSCAD.triangularPrism")
/// **DEPRECATED**: Use `OpenSCAD.triangularPrism(bottom:top:)` instead.
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
public func TriangularPrism(bottom: (a: OpenSCAD.Point, b: OpenSCAD.Point, c: OpenSCAD.Point), top: (a: OpenSCAD.Point, b: OpenSCAD.Point, c: OpenSCAD.Point)) -> OpenSCAD {
    return OpenSCAD.triangularPrism(bottom: bottom, top: top)
}

public extension OpenSCAD {
    public static func hexahedron(bottom: (a: Point, b: Point, c: Point, d: Point), top: (a: Point, b: Point, c: Point, d: Point)) -> OpenSCAD {
        return polyhedron(faces: Face(points: top.a, top.b, top.c, top.d), Face(points: top.a, top.d, bottom.d, bottom.a), Face(points: top.b, top.a, bottom.a, bottom.b), Face(points: top.c, top.b, bottom.b, bottom.c), Face(points: top.d, top.c, bottom.c, bottom.d), Face(points: bottom.a, bottom.d, bottom.c, bottom.b))
    }
}

//TODO: Global constructor functions that return polyhedrons.

internal extension Array where Element: Equatable {
    internal func removingDuplicates() -> [Element] {
        var buffer: [Iterator.Element] = []
        
        for element in self {
            guard !buffer.contains(element) else { continue }
            
            buffer.append(element)
        }
        
        return buffer
    }
    internal mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
internal extension Array where Element: Hashable {
    internal func removingDuplicates() -> [Element] {
        var buffer: [Iterator.Element] = []
        var lookup = Set<Iterator.Element>()
        
        for element in self {
            guard !lookup.contains(element) else { continue }
            
            buffer.append(element)
            lookup.insert(element)
        }
        
        return buffer
    }
    internal mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
