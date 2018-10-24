//
//  Union.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Union

public extension OpenSCAD {
    public static func union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
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
    
    public static func + (lhs: OpenSCAD, rhs: OpenSCAD) -> OpenSCAD {
        return union(lhs, rhs)
    }
    
    public func unioned(with subjects: OpenSCAD...) -> OpenSCAD {
        return unioned(with: subjects)
    }
    public mutating func union(with subjects: OpenSCAD...) {
        self = self.unioned(with: subjects)
    }
    internal func unioned(with subjects: [OpenSCAD]) -> OpenSCAD {
        return OpenSCAD.union(self, subjects)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.union")
public func Union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.union(parent, children)
}

//MARK: - Union

public extension OpenSCAD {
    public static func difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
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
    
    public static func - (lhs: OpenSCAD, rhs: OpenSCAD) -> OpenSCAD {
        return difference(lhs, rhs)
    }
    
    public func differenced(from subject: OpenSCAD) -> OpenSCAD {
        return OpenSCAD.difference(subject, [self])
    }
    public mutating func difference(from subject: OpenSCAD) {
        self = self.differenced(from: subject)
    }
    public func subtracted(from subject: OpenSCAD) -> OpenSCAD {
        return differenced(from: subject)
    }
    public mutating func subtract(from subject: OpenSCAD) {
        difference(from: subject)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.difference")
public func Difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.difference(parent, children)
}

//MARK: - Intersection

public extension OpenSCAD {
    public static func intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
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
    
    public func intersectioned(with subjects: OpenSCAD...) -> OpenSCAD {
        return intersectioned(with: subjects)
    }
    public mutating func intersection(with subjects: OpenSCAD...) {
        self = self.intersectioned(with: subjects)
    }
    internal func intersectioned(with subjects: [OpenSCAD]) -> OpenSCAD {
        return OpenSCAD.intersection(self, subjects)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.intersection")
public func Intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.intersection(parent, children)
}
