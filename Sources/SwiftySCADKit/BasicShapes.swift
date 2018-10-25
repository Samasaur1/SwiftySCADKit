//
//  BasicShapes.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Cube / Rectangular Prism

public extension OpenSCAD {
    public static func cube(withSideLength sideLength: Double, centered: Bool) -> OpenSCAD {
        return OpenSCAD("cube([\(sideLength), \(sideLength), \(sideLength)], \(centered));")
    }
    public static func cube(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
        return OpenSCAD("cube([\(width), \(depth), \(height)], \(centered));")
    }
    public static func rectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
        return cube(height:height, width:width, depth: depth, centered: centered)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.cube")
public func Cube(withSideLength sideLength: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cube(withSideLength: sideLength, centered: centered)
}
@available(*, deprecated, renamed: "OpenSCAD.cube")
public func Cube(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cube(height: height, width: width, depth: depth, centered: centered)
}
@available(*, deprecated, renamed: "OpenSCAD.rectangularPrism")
public func RectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cube(height: height, width: width, depth: depth, centered: centered)
}

//MARK: - Sphere

public extension OpenSCAD {
    public static func sphere(_ radius: Double) -> OpenSCAD {
        return OpenSCAD("sphere(\(radius), $fn=\(OPENSCAD_CONFIG.SPHERE_RESOLUTION));")
    }
}

@available(*, deprecated, renamed: "OpenSCAD.sphere")
public func Sphere(_ radius: Double) -> OpenSCAD {
    return OpenSCAD.sphere(radius)
}

//MARK: - Cylinder

public extension OpenSCAD {
    public static func cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> OpenSCAD {
        return OpenSCAD("cylinder($fn = \(OPENSCAD_CONFIG.SPHERE_RESOLUTION), \(height), \(bottomRadius), \(topRadius), \(centered));")
    }
}

@available(*, deprecated, renamed: "OpenSCAD.cylinder")
public func Cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> OpenSCAD {
    return OpenSCAD.cylinder(height: height, topRadius: topRadius, bottomRadius: bottomRadius, centered: centered)
}

//MARK: - Polyhedron

public extension OpenSCAD {
    public struct Point: Hashable {
        public var x: Double
        public var y: Double
        public var z: Double
        public init(x: Double, y: Double, z: Double) {
            self.x = x
            self.y = y
            self.z = z
        }
        public init(_ x: Double, _ y: Double, _ z: Double) {
            self.init(x: x, y: y, z: z)
        }
    }
    public struct Face: Hashable {
        public var points: [Point]
    }
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
    public static func polyhedron(faces: Face...) -> OpenSCAD {
        return polyhedron(faces: faces)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.polyhedron")
public func Polyhedron(faces: OpenSCAD.Face...) -> OpenSCAD {
    return OpenSCAD.polyhedron(faces: faces)
}
@available(*, deprecated, renamed: "OpenSCAD.polyhedron")
public func Polyhedron(faces: [OpenSCAD.Face]) -> OpenSCAD {
    return OpenSCAD.polyhedron(faces: faces)
}

//MARK: - Triangular Prism

public extension OpenSCAD {
    public static func triangularPrism(bottom: (a: Point, b: Point, c: Point), top: (a: Point, b: Point, c: Point)) -> OpenSCAD {
        return polyhedron(faces: Face(points: [bottom.a, bottom.c, bottom.b]), Face(points: [top.a, top.b, top.c]), Face(points: [top.b, top.a, bottom.a, bottom.b]), Face(points: [top.a, top.c, bottom.c, bottom.a]), Face(points: [top.c, top.b, bottom.b, bottom.c]))
    }
}

@available(*, deprecated, renamed: "OpenSCAD.triangularPrism")
public func TriangularPrism(bottom: (a: OpenSCAD.Point, b: OpenSCAD.Point, c: OpenSCAD.Point), top: (a: OpenSCAD.Point, b: OpenSCAD.Point, c: OpenSCAD.Point)) -> OpenSCAD {
    return OpenSCAD.triangularPrism(bottom: bottom, top: top)
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
