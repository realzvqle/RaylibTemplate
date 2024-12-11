// The Swift Programming Language
// https://docs.swift.org/swift-book

import Raylib
main()




func main()  {
    Raylib.setTraceLogLevel(TraceLogLevel.fatal)
    Raylib.initWindow(1600, 900, "Hello World!")
    while !Raylib.windowShouldClose {
        Raylib.beginDrawing()
        Raylib.clearBackground(Color.lime)
        Raylib.endDrawing()
    }
}