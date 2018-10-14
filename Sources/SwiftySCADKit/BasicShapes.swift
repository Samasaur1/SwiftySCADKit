//
//  BasicShapes.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

public protocol BasicShape: OpenSCAD {}

public struct Cube: BasicShape {
    public let height: Double
    public let width: Double
    public let depth: Double
    public let centered: Bool

    public init(withSideLength sideLength: Double, centered: Bool) {
        self.height = sideLength
        self.width = sideLength
        self.depth = sideLength
        self.centered = centered
    }
    public init(height: Double, width: Double, depth: Double, centered: Bool) {
        self.height = height
        self.width = width
        self.depth = depth
        self.centered = centered
    }
    
    public var SCADValue: String {
        return "cube([\(width), \(depth), \(height)], \(centered));"
    }
}
public typealias RectangularPrism = Cube

public struct Sphere: BasicShape {
    public let radius: Double
    
    public init(_ radius: Double) {
        self.radius = radius
    }
    
    public var SCADValue: String {
        return "sphere(\(radius), $fn=\(OPENSCAD_CONFIG.SPHERE_RESOLUTION));"
    }
}

public struct Cylinder: BasicShape {
    public let height: Double
    public let topRadius: Double
    public let bottomRadius: Double
    public let centered: Bool
    
    public init(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) {
        self.height = height
        self.topRadius = topRadius
        self.bottomRadius = bottomRadius
        self.centered = centered
    }
    
    public var SCADValue: String {
        return "cylinder($fn = \(OPENSCAD_CONFIG.SPHERE_RESOLUTION), \(height), \(bottomRadius), \(topRadius), \(centered));"
    }
}

public struct Polyhedron: BasicShape {
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
    public let points: [Point]
    public struct Face: Hashable {
        public var points: [Point]
    }
    public let faces: [Face]
    
    public init(faces: [Face]) {
        self.faces = faces
        var points: [Point] = []
        for face in faces {
            for point in face.points {
                points.append(point)
            }
        }
        points.removeDuplicates()
        self.points = points
    }
    public init(faces: Face...) {
        self.init(faces: faces)
    }
    
    public var SCADValue: String {
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
}

public func TriangularPrism(bottom: (a: Polyhedron.Point, b: Polyhedron.Point, c: Polyhedron.Point), top: (a: Polyhedron.Point, b: Polyhedron.Point, c: Polyhedron.Point)) -> BasicShape {
    return Polyhedron(faces: Polyhedron.Face(points: [bottom.a, bottom.c, bottom.b]), Polyhedron.Face(points: [top.a, top.b, top.c]), Polyhedron.Face(points: [top.b, top.a, bottom.a, bottom.b]), Polyhedron.Face(points: [top.a, top.c, bottom.c, bottom.a]), Polyhedron.Face(points: [top.c, top.b, bottom.b, bottom.c]))
}

//TODO: Global constructor functions that return polyhedrons.

extension Array where Element: Equatable {
    func removingDuplicates() -> [Element] {
        var buffer: [Iterator.Element] = []
        
        for element in self {
            guard !buffer.contains(element) else { continue }
            
            buffer.append(element)
        }
        
        return buffer
    }
    mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var buffer: [Iterator.Element] = []
        var lookup = Set<Iterator.Element>()
        
        for element in self {
            guard !lookup.contains(element) else { continue }
            
            buffer.append(element)
            lookup.insert(element)
        }
        
        return buffer
    }
    
    mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
