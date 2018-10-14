//
//  Transformations.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

public protocol Transformation: OpenSCAD {
    var subjects: [OpenSCAD] { get }
}

public struct Scale: Transformation {
    public let dx: Double
    public let dy: Double
    public let dz: Double
    public let subjects: [OpenSCAD]
    
    public init(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    public init(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    
    public var SCADValue: String {
        let base = "scale([\(dx), \(dy), \(dz)]) {\n"
        let end = "};"
        var mid = ""
        for subject in subjects {
            mid += "    \(subject.SCADValue)\n"
        }
        return base + mid + end
    }
}

public struct Resize: Transformation {
    public let newx: Double
    public let newy: Double
    public let newz: Double
    public let subjects: [OpenSCAD]
    
    public init(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) {
        self.newx = newx
        self.newy = newy
        self.newz = newz
        self.subjects = subjects
    }
    public init(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) {
        self.newx = newx
        self.newy = newy
        self.newz = newz
        self.subjects = subjects
    }
    
    public var SCADValue: String {
        let base = "resize([\(newx), \(newy), \(newz)]) {\n"
        let end = "};"
        var mid = ""
        for subject in subjects {
            mid += "    \(subject.SCADValue)\n"
        }
        return base + mid + end
    }
}

public struct Rotate: Transformation {
    public let dx: Double
    public let dy: Double
    public let dz: Double
    public let subjects: [OpenSCAD]
    
    public init(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    public init(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    
    public var SCADValue: String {
        let base = "rotate([\(dx), \(dy), \(dz)]) {\n"
        let end = "};"
        var mid = ""
        for subject in subjects {
            mid += "    \(subject.SCADValue)\n"
        }
        return base + mid + end
    }
}

public struct Translate: Transformation {
    public let dx: Double
    public let dy: Double
    public let dz: Double
    public let subjects: [OpenSCAD]
    
    public init(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    public init(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    
    public var SCADValue: String {
        let base = "translate([\(dx), \(dy), \(dz)]) {\n"
        let end = "};"
        var mid = ""
        for subject in subjects {
            mid += "    \(subject.SCADValue)\n"
        }
        return base + mid + end
    }
}

public struct Mirror: Transformation {
    public let dx: Double
    public let dy: Double
    public let dz: Double
    public let subjects: [OpenSCAD]
    
    public init(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    public init(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.subjects = subjects
    }
    
    public var SCADValue: String {
        let base = "translate([\(dx), \(dy), \(dz)]) {\n"
        let end = "};"
        var mid = ""
        for subject in subjects {
            mid += "    \(subject.SCADValue)\n"
        }
        return base + mid + end
    }
}

public struct Color: Transformation {
    public let r: Double
    public let g: Double
    public let b: Double
    public let a: Double
    public let subjects: [OpenSCAD]
    
    public init(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.subjects = subjects
    }
    public init(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.subjects = subjects
    }
    
    public var SCADValue: String {
        let base = "translate([\(r), \(g), \(b), \(a)]) {\n"
        let end = "};"
        var mid = ""
        for subject in subjects {
            mid += "    \(subject.SCADValue)\n"
        }
        return base + mid + end
    }
}

