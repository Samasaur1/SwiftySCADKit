import Foundation

public struct Union<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { return fatalError() }
    let content: Content

    public init(@SCADBuilder content: () -> Content) {
        self.content = content()
    }

    public var scad: SCAD {
        .union(content: content.scad)
    }
}

public extension OpenSCAD {
    func unioned<Content: OpenSCAD>(@SCADBuilder with content: () -> Content) -> some OpenSCAD {
        Union {
            self
            content()
        }
    }
}

public struct Difference<ParentContent: OpenSCAD, ChildContent: OpenSCAD>: OpenSCAD {
    public var body: Never { return fatalError() }
    let parent: ParentContent
    let children: ChildContent

    public init(@SCADBuilder from parent: () -> ParentContent, children: () -> ChildContent) {
        self.parent = parent()
        self.children = children()
    }

    public var scad: SCAD {
        .difference(parent: parent.scad, children: children.scad)
    }
}

public extension OpenSCAD {
    func subtracted<Content: OpenSCAD>(@SCADBuilder from parent: () -> Content) -> some OpenSCAD {
        Difference(from: parent, children: { self })
    }
}

public struct Intersection<Content: OpenSCAD>: OpenSCAD {
    public var body: Never { return fatalError() }
    let content: Content

    public init(@SCADBuilder content: () -> Content) {
        self.content = content()
    }

    public var scad: SCAD {
        .intersection(content: content.scad)
    }
}

public extension OpenSCAD {
    func intersection<Content: OpenSCAD>(@SCADBuilder with content: () -> Content) -> some OpenSCAD {
        Intersection {
            self
            content()
        }
    }
}
