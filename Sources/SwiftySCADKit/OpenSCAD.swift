import Foundation

/// A representation of an OpenSCAD object.
///
/// The recommended way to create an OpenSCAD object is by using one of these static functions:
/// - cube(withSideLength:centered:)
/// - cube(height:width:depth:centered:)
/// - sphere(_:)
/// - cylinder(height:topRadius:bottomRadius:centered:)
/// - polyhedron(faces:)
/// - triangularPrism(bottom:top:)
public struct OpenSCAD {
    /// The raw OpenSCAD value of this object.
    public var SCADValue: String = ""
    /// This initializer is private so that it cannot be used.
    private init() {}
    /// Creates a new OpenSCAD struct with the specified OpenSCAD raw value.
    /// **NOTE**: This raw value is **UNCHECKED**! If it is wrong, ALL YOUR OPENSCAD WON'T WORK!
    ///
    /// - Parameter SCAD: The raw value of this OpenSCAD struct.
    public init(_ SCAD: String) {
        SCADValue = SCAD
    }
}

/// A structure that represents configuration options.
public struct Config {
    /// The resolution of spheres (and other circular objects).
    public var SPHERE_RESOLUTION: Double = 50
}

/// The configuration for SwiftySCADKit.
public var OPENSCAD_CONFIG: Config = Config()
