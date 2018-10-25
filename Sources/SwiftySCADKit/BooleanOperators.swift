//
//  Union.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Union

public extension OpenSCAD {
    /// Creates a union of the parent and all the children.
    ///
    /// - Parameters:
    ///   - parent: The first object in the union.
    ///   - children: Any other objects in the union.
    /// - Returns: A union of all passed OpenSCAD objects.
    public static func union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
        return union(parent, children)
    }
    
    /// Creates a union of the parent and all the children.
    ///
    /// - Parameters:
    ///   - parent: The first object in the union.
    ///   - children: Any other objects in the union.
    /// - Returns: A union of all passed OpenSCAD objects.
    internal static func union(_ parent: OpenSCAD, _ children: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "union() {\n    \(parent.SCADValue)\n"
            let end = "};"
            var mid = ""
            for child in children {
                mid += "    \(child.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    /// Creates a union of the two OpenSCAD objects.
    ///
    /// - Parameters:
    ///   - lhs: The first object in the union.
    ///   - rhs: The other object in the union.
    /// - Returns: A union of the two OpenSCAD objects.
    public static func + (lhs: OpenSCAD, rhs: OpenSCAD) -> OpenSCAD {
        return union(lhs, rhs)
    }
    
    /// Returns the result of a union of the caller and the passed objects.
    ///
    /// - Parameter subjects: The objects to be unioned with.
    /// - Returns: A union of the caller and all passed objects.
    public func unioned(with subjects: OpenSCAD...) -> OpenSCAD {
        return unioned(with: subjects)
    }
    /// Unions this object with the passed objects.
    ///
    /// - Parameter subjects: The objects to union with.
    public mutating func union(with subjects: OpenSCAD...) {
        self = self.unioned(with: subjects)
    }
    /// Returns the result of a union of the caller and the passed objects.
    ///
    /// - Parameter subjects: The objects to be unioned with.
    /// - Returns: A union of the caller and all passed objects.
    internal func unioned(with subjects: [OpenSCAD]) -> OpenSCAD {
        return OpenSCAD.union(self, subjects)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.union")
/// **DEPRECATED**: Use `OpenSCAD.union(_:_:)` instead.
/// Creates a union of the parent and all the children.
///
/// - Parameters:
///   - parent: The first object in the union.
///   - children: Any other objects in the union.
/// - Returns: A union of all passed OpenSCAD objects.
public func Union(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.union(parent, children)
}

//MARK: - Difference

public extension OpenSCAD {
    /// Creates a difference between the parent and the subject objects.
    ///
    /// - Parameters:
    ///   - parent: The 'base' object in the difference.
    ///   - children: The objects to subtract from the parent.
    /// - Returns: A difference made by subtracting the children from the parents.
    public static func difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
        return difference(parent, children)
    }
    
    /// Creates a difference between the parent and the subject objects.
    ///
    /// - Parameters:
    ///   - parent: The 'base' object in the difference.
    ///   - children: The objects to subtract from the parent.
    /// - Returns: A difference made by subtracting the children from the parents.
    internal static func difference(_ parent: OpenSCAD, _ children: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "difference() {\n    \(parent.SCADValue)\n"
            let end = "};"
            var mid = ""
            for child in children {
                mid += "    \(child.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    /// Creates a difference between the left and the right objects.
    ///
    /// - Parameters:
    ///   - lhs: The 'base' object in the difference.
    ///   - rhs: The object to subtract from the base.
    /// - Returns: A difference made by subtracting the right object from the left.
    public static func - (lhs: OpenSCAD, rhs: OpenSCAD) -> OpenSCAD {
        return difference(lhs, rhs)
    }
    
    /// Returns the result of a difference of the caller and the passed object.
    ///
    /// - Parameter subjects: The object to be subtracted.
    /// - Returns: A difference formed by subtracting the subject from the caller.
    public func differenced(from subject: OpenSCAD) -> OpenSCAD {
        return OpenSCAD.difference(subject, [self])
    }
    /// Subtracts the subject from the caller.
    ///
    /// - Parameter subject: The object to subtract from the caller.
    public mutating func difference(from subject: OpenSCAD) {
        self = self.differenced(from: subject)
    }
    /// Returns the result of a difference of the caller and the passed object.
    ///
    /// - Parameter subjects: The object to be subtracted.
    /// - Returns: A difference formed by subtracting the subject from the caller.
    public func subtracted(from subject: OpenSCAD) -> OpenSCAD {
        return differenced(from: subject)
    }
    /// Subtracts the subject from the caller.
    ///
    /// - Parameter subject: The object to subtract from the caller.
    public mutating func subtract(from subject: OpenSCAD) {
        difference(from: subject)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.difference")
/// **DEPRECATED**: Use `OpenSCAD.difference(_:_:)` instead.
/// Creates a difference between the parent and the subject objects.
///
/// - Parameters:
///   - parent: The 'base' object in the difference.
///   - children: The objects to subtract from the parent.
/// - Returns: A difference made by subtracting the children from the parents.
public func Difference(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.difference(parent, children)
}

//MARK: - Intersection

public extension OpenSCAD {
    /// Creates an intersection of the parent and the subject objects.
    ///
    /// - Parameters:
    ///   - parent: The first object in the intersection.
    ///   - children: Any other objects in the intersection.
    /// - Returns: A union of all passed OpenSCAD objects.
    public static func intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
        return intersection(parent, children)
    }
    
    /// Creates an intersection of the parent and the subject objects.
    ///
    /// - Parameters:
    ///   - parent: The first object in the intersection.
    ///   - children: Any other objects in the intersection.
    /// - Returns: A union of all passed OpenSCAD objects.
    internal static func intersection(_ parent: OpenSCAD, _ children: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "intersection() {\n    \(parent.SCADValue)\n"
            let end = "};"
            var mid = ""
            for child in children {
                mid += "    \(child.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    /// Returns the result of an intersection of the caller and the passed objects.
    ///
    /// - Parameter subjects: The objects to be intersected with.
    /// - Returns: An intersection of the caller and all passed objects.
    public func intersectioned(with subjects: OpenSCAD...) -> OpenSCAD {
        return intersectioned(with: subjects)
    }
    /// Intersects this object with the passed objects.
    ///
    /// - Parameter subjects: The objects to intersect with.
    public mutating func intersection(with subjects: OpenSCAD...) {
        self = self.intersectioned(with: subjects)
    }
    /// Returns the result of an intersection of the caller and the passed objects.
    ///
    /// - Parameter subjects: The objects to be intersected with.
    /// - Returns: An intersection of the caller and all passed objects.
    internal func intersectioned(with subjects: [OpenSCAD]) -> OpenSCAD {
        return OpenSCAD.intersection(self, subjects)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.intersection")
/// **DEPRECATED**: Use `OpenSCAD.intersection(_:_:)` instead.
/// Creates an intersection of the parent and the subject objects.
///
/// - Parameters:
///   - parent: The first object in the intersection.
///   - children: Any other objects in the intersection.
/// - Returns: A union of all passed OpenSCAD objects.
public func Intersection(_ parent: OpenSCAD, _ children: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.intersection(parent, children)
}
