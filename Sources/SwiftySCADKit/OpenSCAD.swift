import Foundation

public struct OpenSCAD {
    public var SCADValue: String = ""
    private init() {}
    public init(_ SCAD: String) {
        SCADValue = SCAD
    }
}

public struct Config {
    public var SPHERE_RESOLUTION: Double = 50
}

public var OPENSCAD_CONFIG: Config = Config()
