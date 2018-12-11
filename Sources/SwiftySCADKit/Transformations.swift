//
//  Transformations.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

//MARK: - Scale

public extension OpenSCAD {
    /// Creates a scaled version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The `x` value to scale by.
    ///   - dy: The `y` value to scale by.
    ///   - dz: The `z` value to scale by.
    ///   - subjects: The subjects to scale.
    /// - Returns: A scaled version of the given subjects.
    public static func scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return scale(dx, dy, dz, subjects: subjects)
    }
    /// Creates a scaled version of the passed subjects.
    ///
    /// - Parameters:
    ///   - subjects: The subjects to scale.
    ///   - dx: The `x` value to scale by.
    ///   - dy: The `y` value to scale by.
    ///   - dz: The `z` value to scale by.
    /// - Returns: A scaled version of the given subjects.
    public static func scale(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return scale(dx, dy, dz, subjects: subjects)
    }
    /// Creates a scaled version of the passed subject.
    ///
    /// - Parameters:
    ///   - dx: The `x` value to scale by.
    ///   - dy: The `y` value to scale by.
    ///   - dz: The `z` value to scale by.
    ///   - subjects: The subjects to scale.
    /// - Returns: A scaled version of the given subjects.
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
    
    /// Returns a scaled version of the caller.
    ///
    /// - Parameters:
    ///   - dx: The `x` value to scale by.
    ///   - dy: The `y` value to scale by.
    ///   - dz: The `z` value to scale by.
    /// - Returns: A scaled version of the caller.
    public func scaled(to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.scale(dx, dy, dz, subjects: [self])
    }
    /// Scales the caller by the given amounts.
    ///
    /// - Parameters:
    ///   - dx: The `x` value to scale by.
    ///   - dy: The `y` value to scale by.
    ///   - dz: The `z` value to scale by.
    public mutating func scale(to dx: Double, _ dy: Double, _ dz: Double) {
        self = self.scaled(to: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.scale")
/// Creates a scaled version of the passed subjects.
///
/// - Parameters:
///   - dx: The `x` value to scale by.
///   - dy: The `y` value to scale by.
///   - dz: The `z` value to scale by.
///   - subjects: The subjects to scale.
/// - Returns: A scaled version of the given subjects.
public func Scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.scale(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.scale")
/// Creates a scaled version of the passed subjects.
///
/// - Parameters:
///   - subjects: The subjects to scale.
///   - dx: The `x` value to scale by.
///   - dy: The `y` value to scale by.
///   - dz: The `z` value to scale by.
/// - Returns: A scaled version of the given subjects.
public func Scale(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.scale(dx, dy, dz, subjects: subjects)
}

//MARK: - Resize

public extension OpenSCAD {
    /// Creates a resized version of the passed subjects.
    ///
    /// - Parameters:
    ///   - newx: The new `x` length.
    ///   - newy: The new `y` length.
    ///   - newz: The new `z` length.
    ///   - subjects: The subjects to resize.
    /// - Returns: A resized version of the given subjects.
    public static func resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return resize(newx, newy, newz, subjects: subjects)
    }
    /// Creates a resized version of the passed subjects.
    ///
    /// - Parameters:
    ///   - subjects: The subjects to resize.
    ///   - newx: The new `x` length.
    ///   - newy: The new `y` length.
    ///   - newz: The new `z` length.
    /// - Returns: A resized version of the given subjects.
    public static func resize(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
        return resize(newx, newy, newz, subjects: subjects)
    }
    /// Creates a resized version of the passed subjects.
    ///
    /// - Parameters:
    ///   - newx: The new `x` length.
    ///   - newy: The new `y` length.
    ///   - newz: The new `z` length.
    ///   - subjects: The subjects to resize.
    /// - Returns: A resized version of the given subjects.
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
    
    /// Returns a resized version of the caller.
    ///
    /// - Parameters:
    ///   - newx: The new `x` length.
    ///   - newy: The new `y` length.
    ///   - newz: The new `z` length.
    /// - Returns: A resized version of the caller.
    public func resized(to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
        return OpenSCAD.resize(newx, newy, newz, subjects: [self])
    }
    /// Resizes the caller to the given lengths.
    ///
    /// - Parameters:
    ///   - newx: The new `x` length.
    ///   - newy: The new `y` length.
    ///   - newz: The new `z` length.
    public mutating func resize(to newx: Double, _ newy: Double, _ newz: Double) {
        self = self.resized(to: newx, newy, newz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.resize")
/// Creates a resized version of the passed subjects.
///
/// - Parameters:
///   - newx: The new `x` length.
///   - newy: The new `y` length.
///   - newz: The new `z` length.
///   - subjects: The subjects to resize.
/// - Returns: A resized version of the given subjects.
public func Resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.resize(newx, newy, newz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.resize")
/// Creates a resized version of the passed subjects.
///
/// - Parameters:
///   - subjects: The subjects to resize.
///   - newx: The new `x` length.
///   - newy: The new `y` length.
///   - newz: The new `z` length.
/// - Returns: A resized version of the given subjects.
public func Resize(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
    return OpenSCAD.resize(newx, newy, newz, subjects: subjects)
}

//Mark: - Rotate

public extension OpenSCAD {
    /// Creates a rotated version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The degrees to rotate around the `x` axis.
    ///   - dy: The degrees to rotate around the `y` axis.
    ///   - dz: The degrees to rotate around the `z` axis.
    ///   - subjects: The objects to rotate.
    /// - Returns: A rotated version of the given subjects.
    public static func rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return rotate(dx, dy, dz, subjects: subjects)
    }
    /// Creates a rotated version of the passed subjects.
    ///
    /// - Parameters:
    ///   - subjects: The objects to rotate.
    ///   - dx: The degrees to rotate around the `x` axis.
    ///   - dy: The degrees to rotate around the `y` axis.
    ///   - dz: The degrees to rotate around the `z` axis.
    /// - Returns: A rotated version of the given subjects.
    public static func rotate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return rotate(dx, dy, dz, subjects: subjects)
    }
    /// Creates a rotated version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The degrees to rotate around the `x` axis.
    ///   - dy: The degrees to rotate around the `y` axis.
    ///   - dz: The degrees to rotate around the `z` axis.
    ///   - subjects: The objects to rotate.
    /// - Returns: A rotated version of the given subjects.
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
    
    /// Returns a rotated version of the caller.
    ///
    /// - Parameters:
    ///   - dx: The degrees to rotate around the `x` axis.
    ///   - dy: The degrees to rotate around the `y` axis.
    ///   - dz: The degrees to rotate around the `z` axis.
    /// - Returns: A rotated version of the caller.
    public func rotated(by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.rotate(dx, dy, dz, subjects: [self])
    }
    /// Rotates the caller by the specified amounts.
    ///
    /// - Parameters:
    ///   - dx: The degrees to rotate around the `x` axis.
    ///   - dy: The degrees to rotate around the `y` axis.
    ///   - dz: The degrees to rotate around the `z` axis.
    public mutating func rotate(by dx: Double, _ dy: Double, _ dz: Double) {
        self = self.rotated(by: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.rotate")
/// Creates a rotated version of the passed subjects.
///
/// - Parameters:
///   - dx: The degrees to rotate around the `x` axis.
///   - dy: The degrees to rotate around the `y` axis.
///   - dz: The degrees to rotate around the `z` axis.
///   - subjects: The objects to rotate.
/// - Returns: A rotated version of the given subjects.
public func Rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.rotate(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.rotate")
/// Creates a rotated version of the passed subjects.
///
/// - Parameters:
///   - subjects: The objects to rotate.
///   - dx: The degrees to rotate around the `x` axis.
///   - dy: The degrees to rotate around the `y` axis.
///   - dz: The degrees to rotate around the `z` axis.
/// - Returns: A rotated version of the given subjects.
public func Rotate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.rotate(dx, dy, dz, subjects: subjects)
}

//MARK: - Translate

public extension OpenSCAD {
    /// Creates a translated version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The amount to move along the `x` axis.
    ///   - dy: The amount to move along the `y` axis.
    ///   - dz: The amount to move along the `z` axis.
    ///   - subjects: The objects to translate.
    /// - Returns: A translated version of the given subjects.
    public static func translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return translate(dx, dy, dz, subjects: subjects)
    }
    /// Creates a translated version of the passed subjects.
    ///
    /// - Parameters:
    ///   - subjects: The objects to translate.
    ///   - dx: The amount to move along the `x` axis.
    ///   - dy: The amount to move along the `y` axis.
    ///   - dz: The amount to move along the `z` axis.
    /// - Returns: A translated version of the given subjects.
    public static func translate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return translate(dx, dy, dz, subjects: subjects)
    }
    /// Creates a translated version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The amount to move along the `x` axis.
    ///   - dy: The amount to move along the `y` axis.
    ///   - dz: The amount to move along the `z` axis.
    ///   - subjects: The objects to translate.
    /// - Returns: A translated version of the given subjects.
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
    
    /// Returns a translated version of the caller
    ///
    /// - Parameters:
    ///   - dx: The amount to move along the `x` axis.
    ///   - dy: The amount to move along the `y` axis.
    ///   - dz: The amount to move along the `z` axis.
    /// - Returns: A translated version of the caller.
    public func translated(by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.translate(dx, dy, dz, subjects: [self])
    }
    /// Translates the caller by the specified amounts.
    ///
    /// - Parameters:
    ///   - dx: The amount to move along the `x` axis.
    ///   - dy: The amount to move along the `y` axis.
    ///   - dz: The amount to move along the `z` axis.
    public mutating func translate(by dx: Double, _ dy: Double, _ dz: Double) {
        self = self.translated(by: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.translate")
/// Creates a translated version of the passed subjects.
///
/// - Parameters:
///   - dx: The amount to move along the `x` axis.
///   - dy: The amount to move along the `y` axis.
///   - dz: The amount to move along the `z` axis.
///   - subjects: The objects to translate.
/// - Returns: A translated version of the given subjects.
public func Translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.translate(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.translate")
/// Creates a translated version of the passed subjects.
///
/// - Parameters:
///   - subjects: The objects to translate.
///   - dx: The amount to move along the `x` axis.
///   - dy: The amount to move along the `y` axis.
///   - dz: The amount to move along the `z` axis.
/// - Returns: A translated version of the given subjects.
public func Translate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.translate(dx, dy, dz, subjects: subjects)
}

//MARK: - Mirror

public extension OpenSCAD {
    /// Creates a mirrored version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The x component of the normal vector of the plane to mirror across.
    ///   - dy: The y component of the normal vector of the plane to mirror across.
    ///   - dz: The z component of the normal vector of the plane to mirror across.
    ///   - subjects: The objects to mirror.
    /// - Returns: A mirrored version of the given objects.
    public static func mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return mirror(dx, dy, dz, subjects: subjects)
    }
    /// Creates a mirrored version of the passed subjects.
    ///
    /// - Parameters:
    ///   - subjects: The objects to mirror.
    ///   - dx: The x component of the normal vector of the plane to mirror across.
    ///   - dy: The y component of the normal vector of the plane to mirror across.
    ///   - dz: The z component of the normal vector of the plane to mirror across.
    /// - Returns: A mirrored version of the given objects.
    public static func mirror(_ subjects: OpenSCAD..., across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return mirror(dx, dy, dz, subjects: subjects)
    }
    /// Creates a mirrored version of the passed subjects.
    ///
    /// - Parameters:
    ///   - dx: The x component of the normal vector of the plane to mirror across.
    ///   - dy: The y component of the normal vector of the plane to mirror across.
    ///   - dz: The z component of the normal vector of the plane to mirror across.
    ///   - subjects: The objects to mirror.
    /// - Returns: A mirrored version of the given objects.
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
    
    /// Returns a mirrored version of the caller.
    ///
    /// - Parameters:
    ///   - dx: The x component of the normal vector of the plane to mirror across.
    ///   - dy: The y component of the normal vector of the plane to mirror across.
    ///   - dz: The z component of the normal vector of the plane to mirror across.
    /// - Returns: A mirrored version of the caller.
    public func mirrored(across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
        return OpenSCAD.mirror(dx, dy, dz, subjects: [self])
    }
    /// Mirrors the caller across the specified plane.
    ///
    /// - Parameters:
    ///   - dx: The x component of the normal vector of the plane to mirror across.
    ///   - dy: The y component of the normal vector of the plane to mirror across.
    ///   - dz: The z component of the normal vector of the plane to mirror across.
    public mutating func mirror(across dx: Double, _ dy: Double, _ dz: Double) {
        self = self.mirrored(across: dx, dy, dz)
    }
}

@available(*, deprecated, renamed: "OpenSCAD.mirror")
/// Creates a mirrored version of the passed subjects.
///
/// - Parameters:
///   - dx: The x component of the normal vector of the plane to mirror across.
///   - dy: The y component of the normal vector of the plane to mirror across.
///   - dz: The z component of the normal vector of the plane to mirror across.
///   - subjects: The objects to mirror.
/// - Returns: A mirrored version of the given objects.
public func Mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.mirror(dx, dy, dz, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.mirror")
/// Creates a mirrored version of the passed subjects.
///
/// - Parameters:
///   - subjects: The objects to mirror.
///   - dx: The x component of the normal vector of the plane to mirror across.
///   - dy: The y component of the normal vector of the plane to mirror across.
///   - dz: The z component of the normal vector of the plane to mirror across.
/// - Returns: A mirrored version of the given objects.
public func Mirror(_ subjects: OpenSCAD..., across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
    return OpenSCAD.mirror(dx, dy, dz, subjects: subjects)
}

//MARK: - Color

public extension OpenSCAD {
    /// Creates a colored version of the passed subjects.
    ///
    /// - Parameters:
    ///   - r: The red component of the color.
    ///   - g: The green component of the color.
    ///   - b: The blue component of the color.
    ///   - a: The alpha component of the color.
    ///   - subjects: The objects to color
    /// - Returns: A colored version of the given objects.
    public static func color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) -> OpenSCAD {
        return color(r, g, b, a, subjects: subjects)
    }
    /// Creates a colored version of the passed subjects.
    ///
    /// - Parameters:
    ///   - subjects: The objects to color
    ///   - r: The red component of the color.
    ///   - g: The green component of the color.
    ///   - b: The blue component of the color.
    ///   - a: The alpha component of the color.
    /// - Returns: A colored version of the given objects.
    public static func color(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
        return color(r, g, b, a, subjects: subjects)
    }
    /// Creates a colored version of the passed subjects.
    ///
    /// - Parameters:
    ///   - r: The red component of the color.
    ///   - g: The green component of the color.
    ///   - b: The blue component of the color.
    ///   - a: The alpha component of the color.
    ///   - subjects: The objects to color
    /// - Returns: A colored version of the given objects.
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
    
    /// Returns a colored version of the caller.
    ///
    /// - Parameters:
    ///   - r: The red component of the color.
    ///   - g: The green component of the color.
    ///   - b: The blue component of the color.
    ///   - a: The alpha component of the color.
    /// - Returns: A colored version of the caller.
    public func colored(to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
        return OpenSCAD.color(r, g, b, a, subjects: [self])
    }
    /// Colors the caller to the specified color.
    ///
    /// - Parameters:
    ///   - r: The red component of the color.
    ///   - g: The green component of the color.
    ///   - b: The blue component of the color.
    ///   - a: The alpha component of the color.
    public mutating func color(to r: Double, _ g: Double, _ b: Double, _ a: Double) {
        self = self.colored(to: r, g, b, a)
    }
}


@available(*, deprecated, renamed: "OpenSCAD.color")
/// Creates a colored version of the passed subjects.
///
/// - Parameters:
///   - r: The red component of the color.
///   - g: The green component of the color.
///   - b: The blue component of the color.
///   - a: The alpha component of the color.
///   - subjects: The objects to color
/// - Returns: A colored version of the given objects.
public func Color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) -> OpenSCAD {
    return OpenSCAD.color(r, g, b, a, subjects: subjects)
}
@available(*, deprecated, renamed: "OpenSCAD.color")
/// Creates a colored version of the passed subjects.
///
/// - Parameters:
///   - subjects: The objects to color
///   - r: The red component of the color.
///   - g: The green component of the color.
///   - b: The blue component of the color.
///   - a: The alpha component of the color.
/// - Returns: A colored version of the given objects.
public func Color(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
    return OpenSCAD.color(r, g, b, a, subjects: subjects)
}
