import Foundation

public struct Scale: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD
    let x: Double
    let y: Double
    let z: Double

    public init(by dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    fileprivate init(by dx: Double, _ dy: Double, _ dz: Double, content: OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content
    }

    var scad: SCAD {
        .scale(x: x, y: y, z: z, content: skad(of: content))
    }
}

public extension OpenSCAD {
    func scaled(by dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Scale(by: dx, dy, dz, content: self)
    }
}

public struct Resize: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD
    let x: Double
    let y: Double
    let z: Double

    public init(to newx: Double, _ newy: Double, _ newz: Double, @SCADBuilder content: () -> OpenSCAD) {
        x = newx
        y = newy
        z = newz
        self.content = content()
    }

    fileprivate init(to newx: Double, _ newy: Double, _ newz: Double, content: OpenSCAD) {
        x = newx
        y = newy
        z = newz
        self.content = content
    }

    var scad: SCAD {
        .resize(x: x, y: y, z: z, content: skad(of: content))
    }
}

public extension OpenSCAD {
    func resized(to newx: Double, _ newy: Double, _ newz: Double) -> some OpenSCAD {
        Resize(to: newx, newy, newz, content: self)
    }
}

public struct Rotate: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD
    let x: Double
    let y: Double
    let z: Double

    public init(by dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    fileprivate init(by dx: Double, _ dy: Double, _ dz: Double, content: OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content
    }

    var scad: SCAD {
        .rotate(x: x, y: y, z: z, content: skad(of: content))
    }
}

public extension OpenSCAD {
    func rotated(by dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Rotate(by: dx, dy, dz, content: self)
    }
}

public struct Translate: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD
    let x: Double
    let y: Double
    let z: Double

    public init(by dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    fileprivate init(by dx: Double, _ dy: Double, _ dz: Double, content: OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content
    }

    var scad: SCAD {
        .translation(x: x, y: y, z: z, content: skad(of: content))
    }
}

public extension OpenSCAD {
    func translated(by dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Translate(by: dx, dy, dz, content: self)
    }
}

public struct Mirror: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD
    let x: Double
    let y: Double
    let z: Double

    public init(across dx: Double, _ dy: Double, _ dz: Double, @SCADBuilder content: () -> OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content()
    }

    fileprivate init(across dx: Double, _ dy: Double, _ dz: Double, content: OpenSCAD) {
        x = dx
        y = dy
        z = dz
        self.content = content
    }

    var scad: SCAD {
        .mirror(x: x, y: y, z: z, content: skad(of: content))
    }
}

public extension OpenSCAD {
    func mirrored(across dx: Double, _ dy: Double, _ dz: Double) -> some OpenSCAD {
        Mirror(across: dx, dy, dz, content: self)
    }
}

public struct Color: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD
    let r: Double
    let g: Double
    let b: Double
    let a: Double

    public init(_ r: Double, _ g: Double, _ b: Double, _ a: Double, @SCADBuilder content: () -> OpenSCAD) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.content = content()
    }

    fileprivate init(_ r: Double, _ g: Double, _ b: Double, _ a: Double, content: OpenSCAD) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.content = content
    }

    var scad: SCAD {
        .color(r: r, g: g, b: b, a: a, content: skad(of: content))
    }
}

public extension OpenSCAD {
    func colored(_ r: Double, _ g: Double, _ b: Double, _ a: Double) -> some OpenSCAD {
        Color(r, g, b, a, content: self)
    }
}
