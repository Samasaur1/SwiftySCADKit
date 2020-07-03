import Foundation

public struct Scale<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(by dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .scale(x: x, y: y, z: z, content: content.scad)
    }
}

public extension OpenSCAD {
    func scaled(by dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Scale(by: dx, dy, dz, content: { self })
    }
}

public struct Resize<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(to newx: Double, _ newy: Double, _ newz: Double, @SCADBuilder content: () -> Content) {
        x = newx
        y = newy
        z = newz
        self.content = content()
    }

    public var scad: SCAD {
        .resize(x: x, y: y, z: z, content: content.scad)
    }
}

public extension OpenSCAD {
    func resized(to newx: Double, _ newy: Double, _ newz: Double) -> some OpenSCAD {
        Resize(to: newx, newy, newz, content: { self })
    }
}

public struct Rotate<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(by dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .rotate(x: x, y: y, z: z, content: content.scad)
    }
}

public extension OpenSCAD {
    func rotated(by dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Rotate(by: dx, dy, dz, content: { self })
    }
}

public struct Translate<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(by dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .translation(x: x, y: y, z: z, content: content.scad)
    }
}

public extension OpenSCAD {
    func translated(by dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Translate(by: dx, dy, dz, content: { self })
    }
}

public struct Mirror<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let x: Double
    let y: Double
    let z: Double

    public init(across dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> Content) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    public var scad: SCAD {
        .mirror(x: x, y: y, z: z, content: content.scad)
    }
}

public extension OpenSCAD {
    func mirrored(across dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Mirror(across: dx, dy, dz, content: { self })
    }
}

public struct Color<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { fatalError() }
    let content: Content
    let r: Double
    let g: Double
    let b: Double
    let a: Double

    public init(_ r: Double, _ g: Double, _ b: Double, _ a: Double, @SCADBuilder content: () -> Content) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.content = content()
    }

    public var scad: SCAD {
        .color(r: r, g: g, b: b, a: a, content: content.scad)
    }
}

public extension OpenSCAD {
    func colored(_ r: Double, _ g: Double, _ b: Double, _ a: Double) -> some OpenSCAD {
        Color(r, g, b, a, content: { self })
    }
}
