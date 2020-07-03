import Foundation

public struct Union: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD

    public init(@SCADBuilder content: () -> OpenSCAD) {
        self.content = content()
    }

    fileprivate init(content: OpenSCAD) {
        self.content = content
    }

    var scad: SCAD {
        .union(content: skad(of: content))
    }
}

public extension OpenSCAD {
    func unioned(@SCADBuilder with content: () -> OpenSCAD) -> some OpenSCAD {
        unioned(with: content())
    }

    func unioned(with content: OpenSCAD) -> some OpenSCAD {
//        Union {
//            self
//            content
//        }
        Union(content: SCADList(list: [self, content]))
    }
}

public struct Difference: OpenSCAD, BaseOpenSCAD {
    internal init(parent: OpenSCAD, children: OpenSCAD) {
        self.parent = parent
        self.children = children
    }
    
    public var body: OpenSCAD { fatalError() }
    let parent: OpenSCAD
    let children: OpenSCAD

    public init(@SCADBuilder from parent: () -> OpenSCAD, children: () -> OpenSCAD) {
        self.parent = parent()
        self.children = children()
    }

    fileprivate init(from parent: OpenSCAD, children: OpenSCAD) {
        self.parent = parent
        self.children = children
    }

    var scad: SCAD {
        .difference(parent: skad(of: parent), children: skad(of: children))
    }
}

public extension OpenSCAD {
    func subtracted(@SCADBuilder from parent: () -> OpenSCAD) -> some OpenSCAD {
        subtracted(from: parent())
    }

    func subtracted(from parent: OpenSCAD) -> some OpenSCAD {
        Difference(from: parent, children: self)
    }
}

public struct Intersection: OpenSCAD, BaseOpenSCAD {
    public var body: OpenSCAD { fatalError() }
    let content: OpenSCAD

    public init(@SCADBuilder content: () -> OpenSCAD) {
        self.content = content()
    }

    fileprivate init(content: OpenSCAD) {
        self.content = content
    }

    var scad: SCAD {
        .intersection(content: skad(of: content))
    }
}

public extension OpenSCAD {
    func intersection(@SCADBuilder with content: () -> OpenSCAD) -> some OpenSCAD {
        intersection(with: content())
    }

    func intersection(with content: OpenSCAD) -> some OpenSCAD {
        Intersection(content: SCADList(list: [self, content]))
    }
}
