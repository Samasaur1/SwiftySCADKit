//
//  Transformations.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Scale

public extension OpenSCAD {
    public static func scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return scale(dx, dy, dz, subjects: subjects)
    }
    public static func scale(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return scale(dx, dy, dz, subjects: subjects)
    }
    internal static func scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "scale([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    public func scaled(to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.scale(dx, dy, dz, subjects: [self])
    }
    public mutating func scale(to dx: Double, _ dy: Double, _ dz: Double) {
        self = self.scaled(to: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.scale")
public func Scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.scale(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.scale")
public func Scale(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.scale(dx, dy, dz, subjects: subjects)
}

//MARK: - Resize

public extension OpenSCAD {
    public static func resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return resize(newx, newy, newz, subjects: subjects)
    }
    public static func resize(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
        return resize(newx, newy, newz, subjects: subjects)
    }
    internal static func resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "resize([\(newx), \(newy), \(newz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    public func resized(to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
        return OpenSCAD.resize(newx, newy, newz, subjects: [self])
    }
    public mutating func resize(to newx: Double, _ newy: Double, _ newz: Double) {
        self = self.resized(to: newx, newy, newz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.resize")
public func Resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.resize(newx, newy, newz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.resize")
public func Resize(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
    return OpenSCAD.resize(newx, newy, newz, subjects: subjects)
}

//Mark: - Rotate

public extension OpenSCAD {
    public static func rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return rotate(dx, dy, dz, subjects: subjects)
    }
    public static func rotate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return rotate(dx, dy, dz, subjects: subjects)
    }
    internal static func rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "rotate([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    public func rotated(by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.rotate(dx, dy, dz, subjects: [self])
    }
    public mutating func rotate(by dx: Double, _ dy: Double, _ dz: Double) {
        self = self.rotated(by: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.rotate")
public func Rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.rotate(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.rotate")
public func Rotate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.rotate(dx, dy, dz, subjects: subjects)
}

//MARK: - Translate

public extension OpenSCAD {
    public static func translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return translate(dx, dy, dz, subjects: subjects)
    }
    public static func translate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return translate(dx, dy, dz, subjects: subjects)
    }
    internal static func translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "translate([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    public func translated(by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.translate(dx, dy, dz, subjects: [self])
    }
    public mutating func translate(by dx: Double, _ dy: Double, _ dz: Double) {
        self = self.translated(by: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.translate")
public func Translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.translate(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.translate")
public func Translate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.translate(dx, dy, dz, subjects: subjects)
}

//MARK: - Mirror

public extension OpenSCAD {
    public static func mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return mirror(dx, dy, dz, subjects: subjects)
    }
    public static func mirror(_ subjects: OpenSCAD..., across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return mirror(dx, dy, dz, subjects: subjects)
    }
    internal static func mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "mirror([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    public func mirrored(across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.mirror(dx, dy, dz, subjects: [self])
    }
    public mutating func mirror(across dx: Double, _ dy: Double, _ dz: Double) {
        self = self.mirrored(across: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.mirror")
public func Mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.mirror(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.mirror")
public func Mirror(_ subjects: OpenSCAD..., across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.mirror(dx, dy, dz, subjects: subjects)
}

//MARK: - Color

public extension OpenSCAD {
    public static func color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return color(r, g, b, a, subjects: subjects)
    }
    public static func color(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
        return color(r, g, b, a, subjects: subjects)
    }
    internal static func color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        let SCADClosure: () -> String = {
            let base = "color([\(r), \(g), \(b), \(a)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        return OpenSCAD(SCADClosure())
    }
    
    public func colored(to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
        return OpenSCAD.color(r, g, b, a, subjects: [self])
    }
    public mutating func color(to r: Double, _ g: Double, _ b: Double, _ a: Double) {
        self = self.colored(to: r, g, b, a)
    }
}


@available(*, deprecated, renamed: "OpenSCAD.color")
public func Color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.color(r, g, b, a, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.color")
public func Color(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
    return OpenSCAD.color(r, g, b, a, subjects: subjects)
}
