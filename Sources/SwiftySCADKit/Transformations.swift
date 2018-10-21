//
//  Transformations.swift
//  SwiftySCADKit
//
//  Created by Sam Gauck on 10/6/18.
//

import Foundation

extension OpenSCAD {
    static func scale(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
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
    static func scale(_ subjects: OpenSCAD..., to dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
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

extension OpenSCAD {
    static func resize(_ newx: Double, _ newy: Double, _ newz: Double, subjects: OpenSCAD...) -> OpenSCAD {
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
    static func resize(_ subjects: OpenSCAD..., to newx: Double, _ newy: Double, _ newz: Double) -> OpenSCAD {
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

extension OpenSCAD {
    static func rotate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
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
    static func rotate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
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

extension OpenSCAD {
    static func translate(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
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
    static func translate(_ subjects: OpenSCAD..., by dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
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

extension OpenSCAD {
    static func mirror(_ dx: Double, _ dy: Double, _ dz: Double, subjects: OpenSCAD...) -> OpenSCAD {
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
    static func mirror(_ subjects: OpenSCAD..., across dx: Double, _ dy: Double, _ dz: Double) -> OpenSCAD {
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

extension OpenSCAD {
    static func color(_ r: Double, _ g: Double, _ b: Double, _ a: Double, subjects: OpenSCAD...) -> OpenSCAD {
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
    static func color(_ subjects: OpenSCAD..., to r: Double, _ g: Double, _ b: Double, _ a: Double) -> OpenSCAD {
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
