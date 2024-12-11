/**
 * Copyright (c) 2022 Dustin Collins (Strega's Gate)
 * All Rights Reserved.
 * Licensed under MIT License
 *
 * http://stregasgate.com
 */

import RaylibC

public extension Image {    
    @inlinable
    var format: PixelFormat {
        get {
            return PixelFormat(rawValue: self._format)!
        }
        set {
            self._format = newValue.rawValue
        }
    }
}

#if canImport(Foundation)
import Foundation

public extension Image {
    @inlinable
    init(url: URL) {
        self = Raylib.loadImage(url.path)
    }
    
    @available(*, deprecated, renamed: "init(url:)")
    init(_ url: URL) {
        self.init(url: url)
    }
}
#endif

public extension Image {
    @inlinable
    init(fileName: String) {
        self = Raylib.loadImage(fileName)
    }
    
    /// Load image from RAW file data
    @inlinable
    init(fileName: String, width: Int32, height: Int32, format: PixelFormat, headerSize: Int32) {
        self = Raylib.loadImageRaw(fileName, width, height, format, headerSize)
    }
    
    /// Load image sequence from file (frames appended to image.data)
    @inlinable
    init(fileName: String, frames: inout Int32) {
        self = Raylib.loadImageAnim(fileName, &frames)
    }
    
    /// Load image from memory buffer, fileType refers to extension: i.e. ".png"
    @inlinable
    init(fileType: String, fileData: UnsafePointer<UInt8>!, dataSize: Int32) {
        self = Raylib.loadImageFromMemory(fileType, fileData, dataSize)
    }
}

public extension Image {
    /// Unload image from CPU memory (RAM)
    @inlinable
    func unload() {
        Raylib.unloadImage(self)
    }
}

public extension Image {
    /// Export image data to file, returns true on success
    @inlinable
    func export(to fileName: String) -> Bool {
        return Raylib.exportImage(self, fileName)
    }
    
    /// Export image as code file defining an array of bytes, returns true on success
    @inlinable
    func exportAsCode(to fileName: String) -> Bool {
        return Raylib.exportImageAsCode(self, fileName)
    }
}

//MARK: - Image generation functions
public extension Image {
    /// Generate image: plain color
    @inlinable
    init(color: Color, width: Int32, height: Int32) {
        self = Raylib.genImageColor(width, height, color)
    }
    
    /// Generate image: vertical gradient
    @inlinable
    init(gradientTop: Color, gradientBottom: Color, width: Int32, height: Int32) {
        self = Raylib.genImageGradientV(width, height, gradientTop, gradientBottom)
    }
    
    /// Generate image: horizontal gradient
    @inlinable
    init(gradientLeft: Color, gradientRight: Color, width: Int32, height: Int32) {
        self = Raylib.genImageGradientH(width, height, gradientLeft, gradientRight)
    }
    
    /// Generate image: radial gradient
    @inlinable
    init(gradientInner: Color, gradientOuter: Color, density: Float, width: Int32, height: Int32) {
        self = Raylib.genImageGradientRadial(width, height, density, gradientInner, gradientOuter)
    }
    
    /// Generate image: checked
    @inlinable
    init(checkerdXCount: Int32, checkerYCount: Int32, color1: Color, color2: Color, width: Int32, height: Int32) {
        self = Raylib.genImageChecked(width, height, checkerdXCount, checkerYCount, color1, color2)
    }
}

public extension Image {
    /// Generate image: white noise
    @inlinable
    init(whiteNoiseFactor factor: Float, width: Int32, height: Int32) {
        self = Raylib.genImageWhiteNoise(width, height, factor)
    }

    /// Generate image: cellular algorithm. Bigger tileSize means bigger cells
    @inlinable
    init(cellularWithTileSize tileSize: Int32, width: Int32, height: Int32) {
        self = Raylib.genImageCellular(width, height, tileSize)
    }
}
//
////MARK: - Image manipulation functions
//
///// Create an image duplicate (useful for transformations)
//@inlinable
//static func imageCopy(_ image: Image) -> Image {
//    return RaylibC.ImageCopy(image)
//}
//
///// Create an image from another image piece
//@inlinable
//static func imageFromImage(_ image: Image, _ rec: Rectangle) -> Image {
//    return RaylibC.ImageFromImage(image, rec)
//}
//
///// Create an image from text (default font)
//@inlinable
//static func imageText(_ text: String, _ fontSize: Int32, _ color: Color) -> Image {
//    return text.withCString { cString in
//        return RaylibC.ImageText(cString, fontSize, color)
//    }
//}
//
///// Create an image from text (custom sprite font)
//@inlinable
//static func imageTextEx(_ font: Font, _ text: String, _ fontSize: Float, _ spacing: Float, _ tint: Color) -> Image {
//    return text.withCString { cString in
//        return RaylibC.ImageTextEx(font, cString, fontSize, spacing, tint)
//    }
//}
//
///// Convert image data to desired format
//@inlinable
//static func imageFormat(_ image: inout Image, _ newFormat: PixelFormat) {
//    RaylibC.ImageFormat(&image, newFormat.rawValue)
//}
//
///// Convert image to POT (power-of-two)
//@inlinable
//static func imageToPOT(_ image: inout Image, _ fill: Color) {
//    RaylibC.ImageToPOT(&image, fill)
//}
//
///// Crop an image to a defined rectangle
//@inlinable
//static func imageCrop(_ image: inout Image, _ crop: Rectangle) {
//    RaylibC.ImageCrop(&image, crop)
//}
//
///// Crop image depending on alpha value
//@inlinable
//static func imageAlphaCrop(_ image: inout Image, _ threshold: Float) {
//    RaylibC.ImageAlphaCrop(&image, threshold)
//}
//
///// Clear alpha channel to desired color
//@inlinable
//static func imageAlphaClear(_ image: inout Image, _ color: Color, _ threshold: Float) {
//    RaylibC.ImageAlphaClear(&image, color, threshold)
//}
//
///// Apply alpha mask to image
//@inlinable
//static func imageAlphaMask(_ image: inout Image, _ alphaMask: Image) {
//    RaylibC.ImageAlphaMask(&image, alphaMask)
//}
//
///// Premultiply alpha channel
//@inlinable
//static func imageAlphaPremultiply(_ image: inout Image) {
//    RaylibC.ImageAlphaPremultiply(&image)
//}
//
///// Resize image (Bicubic scaling algorithm)
//@inlinable
//static func imageResize(_ image: inout Image, _ newWidth: Int32, _ newHeight: Int32) {
//    RaylibC.ImageResize(&image, newWidth, newHeight)
//}
//
///// Resize image (Nearest-Neighbor scaling algorithm)
//@inlinable
//static func imageResizeNN(_ image: inout Image, _ newWidth: Int32, _ newHeight: Int32) {
//    RaylibC.ImageResizeNN(&image, newWidth, newHeight)
//}
//
///// Resize canvas and fill with color
//@inlinable
//static func imageResizeCanvas(_ image: inout Image, _ newWidth: Int32, _ newHeight: Int32, _ offsetX: Int32, _ offsetY: Int32, _ fill: Color) {
//    RaylibC.ImageResizeCanvas(&image, newWidth, newHeight, offsetX, offsetY, fill)
//}
//
///// Generate all mipmap levels for a provided image
//@inlinable
//static func imageMipmaps(_ image: inout Image) {
//    RaylibC.ImageMipmaps(&image)
//}
//
///// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
//@inlinable
//static func imageDither(_ image: inout Image, _ rBpp: Int32, _ gBpp: Int32, _ bBpp: Int32, _ aBpp: Int32) {
//    RaylibC.ImageDither(&image, rBpp, gBpp, bBpp, aBpp)
//}
//
///// Flip image vertically
//@inlinable
//static func imageFlipVertical(_ image: inout Image) {
//    RaylibC.ImageFlipVertical(&image)
//}
//
///// Flip image horizontally
//@inlinable
//static func imageFlipHorizontal(_ image: inout Image) {
//    RaylibC.ImageFlipHorizontal(&image)
//}
//
///// Rotate image clockwise 90deg
//@inlinable
//static func imageRotateCW(_ image: inout Image) {
//    RaylibC.ImageRotateCW(&image)
//}
//
///// Rotate image counter-clockwise 90deg
//@inlinable
//static func imageRotateCCW(_ image: inout Image) {
//    RaylibC.ImageRotateCCW(&image)
//}
//
///// Modify image color: tint
//@inlinable
//static func imageColorTint(_ image: inout Image, _ color: Color) {
//    RaylibC.ImageColorTint(&image, color)
//}
//
///// Modify image color: invert
//@inlinable
//static func imageColorInvert(_ image: inout Image) {
//    RaylibC.ImageColorInvert(&image)
//}
//
///// Modify image color: grayscale
//@inlinable
//static func imageColorGrayscale(_ image: inout Image) {
//    RaylibC.ImageColorGrayscale(&image)
//}
//
///// Modify image color: contrast (-100 to 100)
//@inlinable
//static func imageColorContrast(_ image: inout Image, _ contrast: Float) {
//    RaylibC.ImageColorContrast(&image, contrast)
//}
//
///// Modify image color: brightness (-255 to 255)
//@inlinable
//static func imageColorBrightness(_ image: inout Image, _ brightness: Int32) {
//    RaylibC.ImageColorBrightness(&image, brightness)
//}
//
///// Modify image color: replace color
//@inlinable
//static func imageColorReplace(_ image: inout Image, _ color: Color, _ replace: Color) {
//    RaylibC.ImageColorReplace(&image, color, replace)
//}
//
///// Load color data from image as a Color array (RGBA - 32bit)
//@inlinable
//static func loadImageColors(_ image: Image) -> [Color] {
//    let count = image.width * image.height * 4
//    let result = RaylibC.LoadImageColors(image)
//    let buffer = UnsafeMutableBufferPointer(start: result, count: Int(count))
//    return Array(buffer)
//}
//
///// Load colors palette from image as a Color array (RGBA - 32bit)
//@inlinable
//static func loadImagePalette(_ image: Image, _ maxPaletteSize: Int32) -> [Color] {
//    var colorsCount: Int32 = 0
//    let result = RaylibC.LoadImagePalette(image, maxPaletteSize, &colorsCount)
//    let buffer = UnsafeMutableBufferPointer(start: result, count: Int(colorsCount))
//    return Array(buffer)
//}
//
///// Unload color data loaded with LoadImageColors()
//@inlinable @available(*, unavailable, message: "No need to do this in swift.")
//static func unloadImageColors(_ colors: [Color]) {
//    var _colors = colors
//    RaylibC.UnloadImageColors(&_colors)
//}
//
///// Unload colors palette loaded with LoadImagePalette()
//@inlinable @available(*, unavailable, message: "No need to do this in swift.")
//static func unloadImagePalette(_ colors: [Color]) {
//    var _colors = colors
//    RaylibC.UnloadImagePalette(&_colors)
//}
//
///// Get image alpha border rectangle
//@inlinable
//static func getImageAlphaBorder(_ image: Image, _ threshold: Float) -> Rectangle {
//    return RaylibC.GetImageAlphaBorder(image, threshold)
//}
//
////MARK: - Image drawing functions
//// NOTE: Image software-rendering functions (CPU)
//
///// Clear image background with given color
//@inlinable
//static func imageClearBackground(_ dst: inout Image, _ color: Color) {
//    RaylibC.ImageClearBackground(&dst, color)
//}
//
///// Draw pixel within an image
//@inlinable
//static func imageDrawPixel(_ dst: inout Image, _ posX: Int32, _ posY: Int32, _ color: Color) {
//    RaylibC.ImageDrawPixel(&dst, posX, posY, color)
//}
//
///// Draw pixel within an image (Vector version)
//@inlinable
//static func imageDrawPixelV(_ dst: inout Image, _ position: Vector2, _ color: Color) {
//    RaylibC.ImageDrawPixelV(&dst, position, color)
//}
//
///// Draw line within an image
//@inlinable
//static func imageDrawLine(_ dst: inout Image, _ startPosX: Int32, _ startPosY: Int32, _ endPosX: Int32, _ endPosY: Int32, _ color: Color) {
//    RaylibC.ImageDrawLine(&dst, startPosX, startPosY, endPosX, endPosY, color)
//}
//
///// Draw line within an image (Vector version)
//@inlinable
//static func imageDrawLineV(_ dst: inout Image, _ start: Vector2, _ end: Vector2, _ color: Color) {
//    RaylibC.ImageDrawLineV(&dst, start, end, color)
//}
//
///// Draw circle within an image
//@inlinable
//static func imageDrawCircle(_ dst: inout Image, _ centerX: Int32, _ centerY: Int32, _ radius: Int32, _ color: Color) {
//    RaylibC.ImageDrawCircle(&dst, centerX, centerY, radius, color)
//}
//
///// Draw circle within an image (Vector version)
//@inlinable
//static func imageDrawCircleV(_ dst: inout Image, _ center: Vector2, _ radius: Int32, _ color: Color) {
//    RaylibC.ImageDrawCircleV(&dst, center, radius, color)
//}
//
///// Draw rectangle within an image
//@inlinable
//static func imageDrawRectangle(_ dst: inout Image, _ posX: Int32, _ posY: Int32, _ width: Int32, _ height: Int32, _ color: Color) {
//    RaylibC.ImageDrawRectangle(&dst, posX, posY, width, height, color)
//}
//
///// Draw rectangle within an image (Vector version)
//@inlinable
//static func imageDrawRectangleV(_ dst: inout Image, _ position: Vector2, _ size: Vector2, _ color: Color) {
//    RaylibC.ImageDrawRectangleV(&dst, position, size, color)
//}
//
///// Draw rectangle within an image
//@inlinable
//static func imageDrawRectangleRec(_ dst: inout Image, _ rec: Rectangle, _ color: Color) {
//    RaylibC.ImageDrawRectangleRec(&dst, rec, color)
//}
//
///// Draw rectangle lines within an image
//@inlinable
//static func imageDrawRectangleLines(_ dst: inout Image, _ rec: Rectangle, _ thick: Int32, _ color: Color) {
//    RaylibC.ImageDrawRectangleLines(&dst, rec, thick, color)
//}
//
///// Draw a source image within a destination image (tint applied to source)
//@inlinable
//static func imageDraw(_ dst: inout Image, _ src: Image, _ srcRec: Rectangle, _ dstRec: Rectangle, _ tint: Color) {
//    RaylibC.ImageDraw(&dst, src, srcRec, dstRec, tint)
//}
//
///// Draw text (using default font) within an image (destination)
//@inlinable
//static func imageDrawText(_ dst: inout Image, _ text: String, _ posX: Int32, _ posY: Int32, _ fontSize: Int32, _ color: Color) {
//    text.withCString { cString in
//        RaylibC.ImageDrawText(&dst, cString, posX, posY, fontSize, color)
//    }
//}
//
///// Draw text (custom sprite font) within an image (destination)
//@inlinable
//static func imageDrawTextEx(_ dst: inout Image, _ font: Font, _ text: String, _ position: Vector2, _ fontSize: Float, _ spacing: Float, _ tint: Color) {
//    text.withCString { cString in
//        RaylibC.ImageDrawTextEx(&dst, font, cString, position, fontSize, spacing, tint)
//    }
//}
