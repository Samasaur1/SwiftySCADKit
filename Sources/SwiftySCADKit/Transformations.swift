//
//  Transformations.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Scale

extension OpenSCAD {
    static func scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return scale(dx, dy, dz, subjects: subjects)
    }
    static func scale(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return scale(dx, dy, dz, subjects: subjects)
    }
    internal static func scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "scale([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
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

extension OpenSCAD {
    static func resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return resize(newx, newy, newz, subjects: subjects)
    }
    static func resize(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
        return resize(newx, newy, newz, subjects: subjects)
    }
    internal static func resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "resize([\(newx), \(newy), \(newz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
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

extension OpenSCAD {
    static func rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return rotate(dx, dy, dz, subjects: subjects)
    }
    static func rotate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return rotate(dx, dy, dz, subjects: subjects)
    }
    internal static func rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "rotate([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
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

extension OpenSCAD {
    static func translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return translate(dx, dy, dz, subjects: subjects)
    }
    static func translate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return translate(dx, dy, dz, subjects: subjects)
    }
    internal static func translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "translate([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
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

extension OpenSCAD {
    static func mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return mirror(dx, dy, dz, subjects: subjects)
    }
    static func mirror(_ subjects: OpenSCAD..., across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return mirror(dx, dy, dz, subjects: subjects)
    }
    internal static func mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "mirror([\(dx), \(dy), \(dz)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
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

extension OpenSCAD {
    static func color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return color(r, g, b, a, subjects: subjects)
    }
    static func color(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
        return color(r, g, b, a, subjects: subjects)
    }
    internal static func color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: [OpenSCAD]) -> OpenSCAD {
        var s = OpenSCAD()
        let SCADClosure: () -> String = {
            let base = "color([\(r), \(g), \(b), \(a)]) {\n"
            let end = "};"
            var mid = ""
            for subject in subjects {
                mid += "    \(subject.SCADValue)\n"
            }
            return base + mid + end
        }
        s.SCADValue = SCADClosure()
        return s
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
