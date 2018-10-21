//
//  Union.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Union

extension OpenSCAD {
    static func union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
        return union(parent, children)
    }
    
    internal static func union(_ parent: OpenSCAD, _ children: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "union() {\n    \(parent.SCADValue)\n"
            let end = "};"
            var mid = ""
            for child in children {
                mid += "    \(child.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
    }
    
    static func + (lhs: OpenSCAD, rhs: OpenSCAD) -> OpenSCAD {
        return union(lhs, rhs)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.union")
public func Union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.union(parent, children)
}

//MARK: - Union

extension OpenSCAD {
    static func difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
        return difference(parent, children)
    }
    
    internal static func difference(_ parent: OpenSCAD, _ children: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "difference() {\n    \(parent.SCADValue)\n"
            let end = "};"
            var mid = ""
            for child in children {
                mid += "    \(child.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
    }
    
    static func - (lhs: OpenSCAD, rhs: OpenSCAD) -> OpenSCAD {
        return difference(lhs, rhs)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.difference")
public func Difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.difference(parent, children)
}

//MARK: - Intersection

extension OpenSCAD {
    static func intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
        return intersection(parent, children)
    }
    
    internal static func intersection(_ parent: OpenSCAD, _ children: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "intersection() {\n    \(parent.SCADValue)\n"
            let end = "};"
            var mid = ""
            for child in children {
                mid += "    \(child.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
    }
}

@available(*, deprecated, renamed: "OpenSCAD.intersection")
public func Intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.intersection(parent, children)
}
