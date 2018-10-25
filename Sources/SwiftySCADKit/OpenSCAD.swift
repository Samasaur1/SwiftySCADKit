import Foundation

public struct OpenSCAD {
    public var SCADValue: String = ""
    private init() {}
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
