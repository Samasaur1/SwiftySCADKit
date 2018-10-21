//
//  Union.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

extension OpenSCAD {
    static func union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
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
    
extension OpenSCAD {
    static func difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
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

extension OpenSCAD {
    static func intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
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
