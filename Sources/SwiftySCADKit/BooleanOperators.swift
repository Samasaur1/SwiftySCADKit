//
//  Union.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

public protocol BooleanOperator: OpenSCAD {
    var parent: OpenSCAD { get }
    var children: [OpenSCAD] { get }
    init(_ parent: OpenSCAD, _ children: OpenSCAD...)
}

public struct Union: BooleanOperator {
    public let parent: OpenSCAD
    public let children: [OpenSCAD]
    
    public init(_ parent: OpenSCAD, _ children: OpenSCAD...) {
        self.parent = parent
        self.children = children
    }
    
    public var SCADValue: String {
        let base = "union() {\n    \(parent.SCADValue)\n"
        let end = "};"
        var mid = ""
        for child in children {
            mid += "    \(child.SCADValue)\n"
        }
        return base + mid + end
    }
}

public func + (lhs: OpenSCAD, rhs: OpenSCAD) -> Union {
    return Union(lhs, rhs)
}

public struct Difference: BooleanOperator {
    public let parent: OpenSCAD
    public let children: [OpenSCAD]
    
    public init(_ parent: OpenSCAD, _ children: OpenSCAD...) {
        self.parent = parent
        self.children = children
    }
    
    public var SCADValue: String {
        let base = "difference() {\n    \(parent.SCADValue)\n"
        let end = "};"
        var mid = ""
        for child in children {
            mid += "    \(child.SCADValue)\n"
        }
        return base + mid + end
    }
}

public func - (lhs: OpenSCAD, rhs: OpenSCAD) -> Difference {
    return Difference(lhs, rhs)
}

public struct Intersection: BooleanOperator {
    public let parent: OpenSCAD
    public let children: [OpenSCAD]
    
    public init(_ parent: OpenSCAD, _ children: OpenSCAD...) {
        self.parent = parent
        self.children = children
    }
    
    public var SCADValue: String {
        let base = "intersection() {\n    \(parent.SCADValue)\n"
        let end = "};"
        var mid = ""
        for child in children {
            mid += "    \(child.SCADValue)\n"
        }
        return base + mid + end
    }
}
