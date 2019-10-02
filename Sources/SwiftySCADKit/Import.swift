import Foundation

public extension OpenSCAD {
    /// Imports an existing 3D model into OpenSCAD. Only use this for STL, OFF, or DXF files.
    ///
    /// - Parameter path: The path to the file to import. It can be relative or absolute, but must be be local (i.e. not online)
    /// - Returns: The model that was imported
    public static func `import`(_ path: String) -> OpenSCAD {
        #if swift(>=5)
        let url = URL(fileURLWithPath: path)
        return OpenSCAD(#"import("\#(url.standardized.path)");\#n"#)
        #else
        let url = URL(fileURLWithPath: path)
        return OpenSCAD("import(\"\(url.standardized.path)\");\n")
        #endif
    }
}
