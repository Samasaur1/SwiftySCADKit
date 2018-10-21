//
//  BasicShapes.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

extension OpenSCAD {
    static func cube(withSideLength sideLength: Double, centered: Bool) -> OpenSCAD {
        var s = OpenSCAD()
        s.SCADValue = "cube([\(sideLength), \(sideLength), \(sideLength)], \(centered));"
        return s
    }
    static func cube(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
        var s = OpenSCAD()
        s.SCADValue = "cube([\(width), \(depth), \(height)], \(centered));"
        return s
    }
    static func rectangularPrism(height: Double, width: Double, depth: Double, centered: Bool) -> OpenSCAD {
        return cube(height:height, width:width, depth: depth, centered: centered)
    }
}

extension OpenSCAD {
    static func sphere(_ radius: Double) -> OpenSCAD {
        var s = OpenSCAD()
        s.SCADValue = "sphere(\(radius), $fn=\(OPENSCAD_CONFIG.SPHERE_RESOLUTION));"
        return s
    }
}

extension OpenSCAD {
    static func cylinder(height: Double, topRadius: Double, bottomRadius: Double, centered: Bool) -> OpenSCAD {
        var s = OpenSCAD()
        s.SCADValue = "cylinder($fn = \(OPENSCAD_CONFIG.SPHERE_RESOLUTION), \(height), \(bottomRadius), \(topRadius), \(centered));"
        return s
    }
}

extension OpenSCAD {
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
    static func polyhedron(faces: [Face]) -> OpenSCAD {
        var points: [Point] = []
        for face in faces {
            for point in face.points {
                points.append(point)
            }
        }
        points.removeDuplicates()
        
        var s = OpenSCAD()
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
        s.SCADValue = SCADClosure()
        return s
    }
    static func polyhedron(faces: Face...) -> OpenSCAD {
        return polyhedron(faces: faces)
    }
}

extension OpenSCAD {
    static func triangularPrism(bottom: (a: Point, b: Point, c: Point), top: (a: Point, b: Point, c: Point)) -> OpenSCAD {
        return polyhedron(faces: Face(points: [bottom.a, bottom.c, bottom.b]), Face(points: [top.a, top.b, top.c]), Face(points: [top.b, top.a, bottom.a, bottom.b]), Face(points: [top.a, top.c, bottom.c, bottom.a]), Face(points: [top.c, top.b, bottom.b, bottom.c]))
    }
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
