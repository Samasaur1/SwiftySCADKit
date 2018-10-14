import Foundation

public protocol OpenSCAD {
    var SCADValue: String { get }
}

public struct Config {
    public var SPHERE_RESOLUTION: Double = 50
}

public var OPENSCAD_CONFIG: Config = Config()
