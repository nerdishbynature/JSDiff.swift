import Foundation

#if os(OSX)
    public typealias Color = NSColor
#else
    public typealias Color = UIColor
#endif
