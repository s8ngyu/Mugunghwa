//
//  Attributes.swift
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

import Foundation


// MARK: - Attributes Lookup Table
// Conversion between attribute identifier no. and identifier display name
// Based on CoreUI v.609.4 / CoreThemeDefinition v.446.1 / Xcode 11.4 (11E146)


struct Attributes {
    
    // MARK: - Rendition Key Attributes (Part 1)
                                                                                            /// **  ThemeSize  **
    static let Size                 = [0: "Regular",                                        // 0 = kCoreThemeSizeRegular
                                       1: "Small",                                          // 1 = kCoreThemeSizeSmall
                                       2: "Mini",                                           // 2 = kCoreThemeSizeMini
                                       3: "Large"]                                          // 3 = kCoreThemeSizeLarge
    
                                                                                            /// **  ThemeDirection  **
    static let Direction            = [0: "Horizontal",                                     // 0 = kCoreThemeDirectionHorizontal
                                       1: "Vertical",                                       // 1 = kCoreThemeDirectionVertical
                                       2: "Pointing Up",                                    // 2 = kCoreThemeDirectionPointingUp
                                       3: "Pointing Down",                                  // 3 = kCoreThemeDirectionPointingDown
                                       4: "Pointing Left",                                  // 4 = kCoreThemeDirectionPointingLeft
                                       5: "Pointing Right"]                                 // 5 = kCoreThemeDirectionPointingRight
    
                                                                                            /// **  ThemeValue  **
    static let Value                = [0: "Off",                                            // 0 = kCoreThemeValueOff
                                       1: "On",                                             // 1 = kCoreThemeValueOn
                                       2: "Mixed"]                                          // 2 = kCoreThemeValueMixed
    
                                                                                            /// **  Appearance   **  (Equivalent to UIAppearance / NSAppearance, depending on platform)
    static let Appearance           = [0: "Any Luminosity",                                 // 0 = UIAppearanceAny / NSAppearanceNameSystem
                                       1: "Dark",                                           // 1 = UIAppearanceDark / NSAppearanceNameDarkAqua
                                       2: "High Contrast",                                  // 2 = UIAppearanceHighContrastAny
                                       3: "High Contrast Dark",                             // 3 = UIAppearanceHighContrastDark / NSAppearanceNameAccessibilitySystem
                                       4: "Light",                                          // 4 = UIAppearanceLight
                                       5: "High Contrast Light",                            // 5 = UIAppearanceHighContrastLight
                                       6: "High Contrast Dark",                             // 6 = NSAppearanceNameAccessibilityDarkAqua
                                       8: "Light",                                          // 8 = NSAppearanceNameAqua
                                       9: "High Contrast Light"]                            // 9 = NSAppearanceNameAccessibilityAqua
    
    
    // Note: Dimension1 & Dimension2 are the slice reference in resize modes (3-part-horizontal, 3-part-vertical, 9-part, etc)
    
                                                                                            /// **  ThemeState  **
    static let State                = [0: "Normal",                                         // 0 = kCoreThemeStateNormal
                                       1: "Rollover",                                       // 1 = kCoreThemeStateRollover
                                       2: "Pressed",                                        // 2 = kCoreThemeStatePressed
                                       3: "Inactive (obsolete)",                            // 3 = obsolete_kCoreThemeStateInactive
                                       4: "Disabled",                                       // 4 = kCoreThemeStateDisabled
                                       5: "Deeply Pressed"]                                 // 5 = kCoreThemeStateDeeplyPressed
    
                                                                                            /// **  ThemeDrawingLayer  **
    static let Layer                = [0: "Base Layer",                                     // 0 = kCoreThemeLayerBase // aka "Background Layer"?
                                       1: "Highlight Layer",                                // 1 = kCoreThemeLayerHighlight // aka "Gradient Layer"
                                       2: "Mask Layer",                                     // 2 = kCoreThemeLayerMask
                                       3: "Pulse Layer",                                    // 3 = kCoreThemeLayerPulse
                                       4: "Hit Mask Layer",                                 // 4 = kCoreThemeLayerHitMask
                                       5: "Pattern Overlay Layer",                          // 5 = kCoreThemeLayerPatternOverlay
                                       6: "Outline",                                        // 6 = kCoreThemeLayerOutline
                                       7: "Interior"]                                       // 7 = kCoreThemeLayerInterior
    
                                                                                            
    static let Scale                = [0: "Universal",
                                       1: "1x",
                                       2: "2x",
                                       3: "3x"]
    
    
    static let Localization         = [0: "Universal"]                                      // TO BE MAPPE
    
                                                                                            /// **  ThemePresentationState  **
    static let PresentationState    = [0: "Active",                                         // 0 = kCoreThemePresentationStateActive
                                       1: "Inactive",                                       // 1 = kCoreThemePresentationStateInactive
                                       2: "Main"]                                           // 2 = kCoreThemePresentationStateActiveMain
    
                                                                                            /// **  ThemeIdiom  **
    static let Device               = [0: "Universal",                                      // 0 = kCoreThemeIdiomUniversal
                                       1: "iPhone",                                         // 1 = kCoreThemeIdiomPhone
                                       2: "iPad",                                           // 2 = kCoreThemeIdiomPad
                                       3: "Apple TV",                                       // 3 = kCoreThemeIdiomTV
                                       4: "CarPlay",                                        // 4 = kCoreThemeIdiomCar
                                       5: "Apple Watch",                                    // 5 = kCoreThemeIdiomWatch
                                       6: "Marketing"]                                      // 6 = kCoreThemeIdiomMarketing (= App Store, e.g. 1024pt Icon for iOS)
    
                                                                                            /// **  Device Subtype  **  (Note: Device Subtype =/= Rendition Subtype)
    static let Subtype              = [32401: "Mac Catalyst"]                               // TBC
    
                                                                                            /// **  ThemeUISizeClass  **  (Horizontal & Vertical Size Class)
    static let SizeClass            = [0: "Universal",                                      // 0 = kCoreThemeUISizeClassUnspecified
                                       1: "Compact",                                        // 1 = kCoreThemeUISizeClassCompact
                                       2: "Regular"]                                        // 2 = kCoreThemeUISizeClassRegular
    
                                                                                            /// **  ThemeMemoryClass  **
    static let Memory               = [0: "Any",                                            // 0 = kCoreThemeMemoryClassLow
                                       1: "1 GB",                                           // 1 = kCoreThemeMemoryClass1GB
                                       2: "2 GB",                                           // 2 = kCoreThemeMemoryClass2GB
                                       3: "4 GB",                                           // 3 = kCoreThemeMemoryClass4GB (TBC)
                                       4: "3 GB",                                           // 4 = kCoreThemeMemoryClass3GB (TBC)
                                       5: "6 GB"]                                           // 5 = kCoreThemeMemoryClass6GB
    
                                                                                            /// **  ThemeGraphicsFeatureSetClass  **
    static let Graphics             = [0: "OpenGL ES 2.0",                                  // 0 = kCoreThemeFeatureSetOpenGLES2
                                       1: "Metal 1v2",                                      // 1 = kCoreThemeFeatureSetMetalGPUFamily1
                                       2: "Metal 2v2",                                      // 2 = kCoreThemeFeatureSetMetalGPUFamily2
                                       3: "Metal 3v1",                                      // 3 = kCoreThemeFeatureSetMetalGPUFamily3_Deprecated
                                       4: "Metal 3v2",                                      // 4 = kCoreThemeFeatureSetMetalGPUFamily3
                                       5: "Metal 4v1",                                      // 5 = kCoreThemeFeatureSetMetalGPUFamily4
                                       6: "Metal 5v1",                                      // 6 = kCoreThemeFeatureSetMetalGPUFamily5
                                       7: "Apple 6"]                                        // 7 = kCoreThemeFeatureSetMetalGPUFamily6

                                                                                            /// **  ThemeDisplayGamut  **
    static let Gamut                = [0: "sRGB",                                           // 0 = kCoreThemeDisplayGamutSRGB
                                       1: "Display P3"]                                     // 1 = kCoreThemeDisplayGamutP3
    
                                                                                            /// **  ThemeDeploymentTarget  **
    static let Target               = [0: "Any",                                            // 0 = kCoreThemeDeploymentTargetAny
                                       1: "2016",                                           // 1 = kCoreThemeDeploymentTarget2016
                                       2: "2017",                                           // 2 = kCoreThemeDeploymentTarget2017
                                       3: "2018",                                           // 3 = kCoreThemeDeploymentTarget2018
                                       4: "2018 plus",                                      // 4 = kCoreThemeDeploymentTarget2018Plus
                                       5: "2019"]                                           // 5 = kCoreThemeDeploymentTarget2019
    
                                                                                            /// **  ThemeGlyphWeight  **
    static let GlyphWeight          = [0: "None",                                           // 0 = kCoreThemeVectorGlyphWeightNone
                                       1: "Ultralight",                                     // 1 = kCoreThemeVectorGlyphWeightUltralight
                                       2: "Thin",                                           // 2 = kCoreThemeVectorGlyphWeightThin
                                       3: "Light",                                          // 3 = kCoreThemeVectorGlyphWeightLight
                                       4: "Regular",                                        // 4 = kCoreThemeVectorGlyphWeightRegular
                                       5: "Medium",                                         // 5 = kCoreThemeVectorGlyphWeightMedium
                                       6: "Semibold",                                       // 6 = kCoreThemeVectorGlyphWeightSemibold
                                       7: "Bold",                                           // 7 = kCoreThemeVectorGlyphWeightBold
                                       8: "Heavy",                                          // 8 = kCoreThemeVectorGlyphWeightHeavy
                                       9: "Black"]                                          // 9 = kCoreThemeVectorGlyphWeightBlack
    
                                                                                            /// **  ThemeGlyphSize  **
    static let GlyphSize            = [0: "None",                                           // 0 = kCoreThemeVectorGlyphSizeNone
                                       1: "Small",                                          // 1 = kCoreThemeVectorGlyphSizeSmall
                                       2: "Medium",                                         // 2 = kCoreThemeVectorGlyphSizeMedium
                                       3: "Large"]                                          // 3 = kCoreThemeVectorGlyphSSizeLarge
    
    
    
    // MARK: - Rendition Attributes
                                                                                            /// **  RenditionType  **
    static let RenditionType        = [0: "One Part",                                       // 0 = kCUIRenditionTypeOnePart
                                       1: "Three Part Horizontal",                          // 1 = kCUIRenditionTypeThreePartHorizontal
                                       2: "Three Part Vertical",                            // 2 = kCUIRenditionTypeThreePartVertical
                                       3: "Nine Part",                                      // 3 = kCUIRenditionTypeNinePart
                                       4: "Twelve Part",                                    // 4 = kCUIRenditionTypeTwelvePart
                                       5: "Many Part",                                      // 5 = kCUIRenditionTypeManyPart
                                       6: "Gradient",                                       // 6 = kCUIRenditionTypeGradient                => _CUIThemeGradientRendition ?
                                       7: "Effect Definition",                              // 7 = kCUIRenditionTypeEffect                  => _CUIThemeEffectRendition ?
                                       8: "Animation",                                      // 8 = kCUIRenditionTypeAnimation
                                       9: "Vector",                                         // 9 = kCUIRenditionTypeVector                  => _CUIThemeSVGRendition ?
                                       1000: "Raw Data",                                    // 1000 = kCUIRenditionTypeRawData              => _CUIRawDataRendition ?
                                       1001: "External Link",                               // 1001 = kCUIRenditionTypeExternalLink         => _CUIExternalLinkRendition ?
                                       1002: "Layer Stack",                                 // 1002 = kCUIRenditionTypeLayerStack           => _CUILayerStackRendition ?
                                       1003: "Internal Link",                               // 1003 = Internal Link? (TBC)                  => _CUIInternalLinkRendition ?
                                       1004: "Packed RenditionType",                        // 1004 = kCUIRenditionTypePacked               => _CUIThemePixelRendition ?
                                       1005: "NamedContents RenditionType",                 // 1005 = kCUIRenditionTypeNamedContents        => _CUINameContentRendition ?
                                       1006: "Thinning Placeholder RenditionType",          // 1006 = kCUIRenditionTypeThinningPlaceholder  => _CUIThinningPlaceholderRendition ?
                                       1007: "Texture RenditionType",                       // 1007 = kCUIRenditionTypeTexture              => _CUIThemeTextureRendition ?
                                       1008: "Texture Image RenditionType",                 // 1008 = kCUIRenditionTypeTextureImage         => _CUIThemeTextureImageRendition ?
                                       1009: "Color RenditionType",                         // 1009 = kCUIRenditionTypeColor                => _CUIThemeColorRendition ?
                                       1010: "Multisize Image Set RenditionType",           // 1010 = kCUIRenditionTypeMultisizeImageSet    => _CUIThemeMultisizeImageSetRendition ?
                                       1011: "Toplevel Model I/O Asset RenditionType",      // 1011 = kCUIRenditionTypeModelAsset           => _CUIThemeModelAssetRendition ?
                                       1012: "Model I/O Mesh RenditionType",                // 1012 = kCUIRenditionTypeModelMesh            => _CUIThemeModelMeshRendition ?
                                       1013: "Recognition Group",                           // 1013 = kCUIRenditionTypeRecognitionGroup
                                       1014: "Recognition Object",                          // 1014 = kCUIRenditionTypeRecognitionObject    => _CUIRecognitionObjectRendition ?
                                       1015: "Text Style RenditionType",                    // 1015 = kCUIRenditionTypeTextStyle            => _CUIThemeTextStyleRendition ?
                                       1016: "Model I/O Submesh RenditionType",             // 1016 = kCUIRenditionTypeModelSubMesh         => _CUIThemeModelSubmeshRendition ?
                                       1017: "Vector Glyph RenditionType"]                  // 1017 = kCUIRenditionTypeVectorGlyph          => _CUIThemeSVGRendition ?
       
                                                                                            /// **  RenditionSubtype  **
    static let RenditionSubtype     = [10: "One Part Fixed Size",                           // 10 = kCoreThemeOnePartFixedSize
                                       11: "One Part Tiled",                                // 11 = kCoreThemeOnePartTile
                                       12: "One Part Scaled",                               // 12 = kCoreThemeOnePartScale
                                       20: "Three Part Horizontal Tiled",                   // 20 = kCoreThemeThreePartHTile
                                       21: "Three Part Horizontal Scaled",                  // 21 = kCoreThemeThreePartHScale
                                       22: "Three Part Horizontal Uniform",                 // 22 = kCoreThemeThreePartHUniform
                                       23: "Three Part Vertical Tiled",                     // 23 = kCoreThemeThreePartVTile
                                       24: "Three Part Vertical Scaled",                    // 24 = kCoreThemeThreePartVScale
                                       25: "Three Part Vertical Uniform",                   // 25 = kCoreThemeThreePartVUniform
                                       30: "Nine Part Tiled",                               // 30 = kCoreThemeNinePartTile
                                       31: "Nine Part Scaled",                              // 31 = kCoreThemeNinePartScale
                                       32: "Nine Part Horizontal Uniform Vertical Scaled",  // 32 = kCoreThemeNinePartHorizontalUniformVerticalScale
                                       33: "Nine Part Horizontal Scaled Vertical Uniform",  // 33 = kCoreThemeNinePartHorizontalScaleVerticalUniform
                                       34: "Nine Part Edges Only",                          // 34 = kCoreThemeNinePartEdgesOnly
                                       40: "Many Part Layout Unknown",                      // 40 = kCoreThemeManyPartLayoutUnknown
                                       50: "Animation Filmstrip"]                           // 50 = kCoreThemeAnimationFilmstrip
       
                                                                                            /// **  TemplateRenderingMode  **
    static let RenderingMode        = [0: "None",                                           // 0 = kCoreThemeTemplateRenderingModeNone
                                       1: "Template",                                       // 1 = kCoreThemeTemplateRenderingModeTemplate
                                       2: "Automatic"]                                      // 2 = kCoreThemeTemplateRenderingModeAutomatic
       
                                                                                            /// **  ThemeCompressionType  **
    static let Compression          = [0: "Default (Automatic)",                            // 0 = kCoreThemeCompressionTypeDefault
                                       1: "None",                                           // 1 = kCoreThemeCompressionTypeNone
                                       2: "Lossless",                                       // 2 = kCoreThemeCompressionTypeLossless
                                       3: "Lossy",                                          // 3 = kCoreThemeCompressionTypeLossy
                                       4: "GPU Best Quality",                               // 4 = kCoreThemeCompressionTypeGPUOptimizedBest
                                       5: "GPU Smallest Size",                              // 5 = kCoreThemeCompressionTypeGPUOptimizedSmallest
                                       6: "Blurred",                                        // 6 = kCoreThemeCompressionTypeBlurred
                                       7: "Compact"]                                        // 7 = kCoreThemeCompressionTypeCompact

                                                                                            /// **  IterationType  **
    static let IterationType        = [0: "Iterate Values",                                 // 0 = kTDIterationValue
                                       1: "Iterate Presentation States",                    // 1 = kTDIterationPresentationState
                                       2: "Iterate Dim1",                                   // 2 = kTDIterationDimension1
                                       3: "Iterate Dim2",                                   // 3 = kTDIterationDimension2
                                       4: "No Iteration"]                                   // 4 = kTDIterationNone
       
                                                                                            /// **  SchemaCategory  **
    static let SchemaCategory       = [4: "Effects",                                        // 4 = Effects
                                       5: "Images"]                                         // 5 = Images
       
                                                                                            /// **  EffectParameterType  **
    static let EffectParameterType  = [0: "Begin Color",                                    // 0 = CUIEffectParameterColor1
                                       1: "End Color",                                      // 1 = CUIEffectParameterColor2
                                       2: "Opacity",                                        // 2 = CUIEffectParameterOpacity
                                       3: "Shadow Opacity",                                 // 3 = CUIEffectParameterOpacity2
                                       4: "Blur Size",                                      // 4 = CUIEffectParameterBlurSize
                                       5: "Offset",                                         // 5 = CUIEffectParameterOffset
                                       6: "Angle",                                          // 6 = CUIEffectParameterAngle
                                       7: "Blend Mode",                                     // 7 = CUIEffectParameterBlendMode
                                       8: "Soften",                                         // 8 = CUIEffectParameterSoftenSize
                                       9: "Spread",                                         // 9 = CUIEffectParameterSpread
                                       10: "Tintable",                                      // 10 = CUIEffectParameterTintable
                                       11: "Bevel Style"]                                   // 11 = CUIEffectParameterBevelStyle
       
                                                                                            /// **  TextureInterpretation  **
    static let TextureInterpretation = [0: "Data",                                          // 0 = kCoreThemeTextureInterpretationData
                                       1: "Color",                                          // 1 = kCoreThemeTextureInterpretationColor
                                       2: "ColorPremultiplied"]                             // 2 = kCoreThemeTextureInterpretationColorPremultiplied
       
                                                                                            /// **  TextureFace  **
    static let TextureFace          = [0: "+X",                                             // 0 = kCoreThemeTexturePositiveXFace
                                       1: "-X",                                             // 1 = kCoreThemeTextureNegativeXFace
                                       2: "+Y",                                             // 2 = kCoreThemeTexturePositiveYFace
                                       3: "-Y",                                             // 3 = kCoreThemeTextureNegativeYFace
                                       4: "+Z",                                             // 4 = kCoreThemeTexturePositiveZFace
                                       5: "+Z"]                                             // 5 = kCoreThemeTextureNegativeZFace
       
                                                                                            /// **  TexturePixelFormat  **  (=  CIFormat?)
    static let TexturePixelFormat   = [0: "Invalid",                                        // 0 = kCoreThemeTexturePixelFormatInvalid
                                       1: "A8 Unorm",                                       // 1 = kCoreThemeTexturePixelFormatA8Unorm
                                       10: "R8 Unorm",                                      // 10 = kCoreThemeTexturePixelFormatR8Unorm
                                       11: "R8 Unorm sRGB",                                 // 11 = kCoreThemeTexturePixelFormatR8Unorm_sRGB
                                       12: "R8 Snorm",                                      // 12 = kCoreThemeTexturePixelFormatR8Snorm
                                       20: "R16 Unorm",                                     // 20 = kCoreThemeTexturePixelFormatR16Unorm
                                       22: "R16 Snorm",                                     // 22 = kCoreThemeTexturePixelFormatR16Snorm
                                       25: "R16 Float",                                     // 25 = kCoreThemeTexturePixelFormatR16Float
                                       30: "RG8 Unorm",                                     // 30 = kCoreThemeTexturePixelFormatRG8Unorm
                                       31: "RG8 Unorm sRGB",                                // 31 = kCoreThemeTexturePixelFormatRG8Unorm_sRGB
                                       32: "RG8 Snorm",                                     // 32 = kCoreThemeTexturePixelFormatRG8Snorm
                                       55: "R32 Float",                                     // 55 = kCoreThemeTexturePixelFormatR32Float
                                       60: "RG16 Unorm",                                    // 60 = kCoreThemeTexturePixelFormatRG16Unorm
                                       62: "RG16 Snorm",                                    // 62 = kCoreThemeTexturePixelFormatRG16Snorm
                                       65: "RG16 Float",                                    // 65 = kCoreThemeTexturePixelFormatRG16Float
                                       70: "RGBA8 Unorm",                                   // 70 = kCoreThemeTexturePixelFormatRGBA8Unorm
                                       71: "RGBA8 Unorm sRGB",                              // 71 = kCoreThemeTexturePixelFormatRGBA8Unorm_sRGB
                                       72: "RGBA8 Snorm",                                   // 72 = kCoreThemeTexturePixelFormatRGBA8Snorm
                                       80: "BGRA8 Unorm",                                   // 80 = kCoreThemeTexturePixelFormatBGRA8Unorm
                                       81: "BGRA8 Unorm sRGB",                              // 81 = kCoreThemeTexturePixelFormatBGRA8Unorm_sRGB
                                       90: "RGB10A2 Unorm",                                 // 90 = kCoreThemeTexturePixelFormatRGB10A2Unorm
                                       92: "RG11B10 Float",                                 // 92 = kCoreThemeTexturePixelFormatRG11B10Float
                                       93: "RGB9E5 Float",                                  // 93 = kCoreThemeTexturePixelFormatRGB9E5Float
                                       105: "RG32 Float",                                   // 105 = kCoreThemeTexturePixelFormatRG32Float
                                       110: "RGBA16 Unorm",                                 // 110 = kCoreThemeTexturePixelFormatRGBA16Unorm
                                       112: "RGBA16 Snorm",                                 // 112 = kCoreThemeTexturePixelFormatRGBA16Snorm
                                       115: "RGBA16 Float",                                 // 115 = kCoreThemeTexturePixelFormatRGBA16Float
                                       125: "RGBA32 Float",                                 // 125 = kCoreThemeTexturePixelFormatRGBA32Float
                                       130: "BC1 RGBA",                                     // 130 = kCoreThemeTexturePixelFormatBC1_RGBA
                                       131: "BC1 sRGB",                                     // 131 = kCoreThemeTexturePixelFormatBC1_RGBA_sRGB
                                       132: "BC2 RGBA",                                     // 132 = kCoreThemeTexturePixelFormatBC2_RGBA
                                       133: "BC2 sRGB",                                     // 133 = kCoreThemeTexturePixelFormatBC2_RGBA_sRGB
                                       134: "BC3 RGBA",                                     // 134 = kCoreThemeTexturePixelFormatBC3_RGBA
                                       135: "BC3 sRGB",                                     // 135 = kCoreThemeTexturePixelFormatBC3_RGBA_sRGB
                                       140: "BC4 RUnorm",                                   // 140 = kCoreThemeTexturePixelFormatBC4_RUnorm
                                       141: "BC4 SRnorm",                                   // 141 = kCoreThemeTexturePixelFormatBC4_RSnorm
                                       142: "BC5 RGUnorm",                                  // 142 = kCoreThemeTexturePixelFormatBC5_RGUnorm
                                       143: "BC5 RGSnorm",                                  // 143 = kCoreThemeTexturePixelFormatBC5_RGSnorm
                                       152: "BC7 RGBUnorm",                                 // 152 = kCoreThemeTexturePixelFormatBC7_RGBAUnorm
                                       153: "BC7 RGBUnorm sRGB",                            // 153 = kCoreThemeTexturePixelFormatBC7_RGBAUnorm_sRGB
                                       186: "ASTC 4x4 sRGB",                                // 186 = kCoreThemeTexturePixelFormatASTC_4x4_sRGB
                                       194: "ASTC 8x8 sRGB",                                // 194 = kCoreThemeTexturePixelFormatASTC_8x8_sRGB
                                       204: "ASTC 4x4",                                     // 204 = kCoreThemeTexturePixelFormatASTC_4x4_LDR
                                       212: "ASTC 8x8",                                     // 212 = kCoreThemeTexturePixelFormatASTC_8x8_LDR
                                       553: "BGRA10_XR_sRGB",                               // 553 = kCoreThemeTexturePixelFormatBGRA10_XR_sRGB
                                       555: "BGR10_XR_sRGB"]                                // 555 = kCoreThemeTexturePixelFormatBGR10_XR_sRGB
    
    
    
    // MARK: - Rendition Key Attributes (Part 2)
                                                                                            /// **  ThemeElement  **
    static let Element              = [1: "CheckBox",                                       // 1 = kCoreThemeCheckBoxID
                                       2: "Radio Button",                                   // 2 = kCoreThemeRadioButtonID
                                       3: "Push Button",                                    // 3 = kCoreThemePushButtonID
                                       4: "Bevel Button Gradient",                          // 4 = kCoreThemeBevelButtonGradientID
                                       5: "Bevel Button Round",                             // 5 = kCoreThemeBevelButtonRoundID
                                       6: "Disclosure Button",                              // 6 = kCoreThemeDisclosureButtonID
                                       7: "Combo Box Button",                               // 7 = kCoreThemeComboBoxButtonID
                                       8: "Tab Button",                                     // 8 = kCoreThemeTabButtonID
                                       9: "Grouped/Packed Images",                          // 9 = kCoreThemeGroupedImagesID
                                       10: "Glass Push Button",                             // 10 = kCoreThemeGlassButtonID
                                       11: "Basic Button",                                  // 11 = kCoreThemeBasicButtonID
                                       12: "Pop-Up Button Textured",                        // 12 = kCoreThemePopUpButtonTexturedID
                                       13: "Square Pop-Up Button",                          // 13 = kCoreThemeSquarePopUpButtonID
                                       14: "Pull-Down Button Rounded",                      // 14 = kCoreThemePullDownButtonTexturedID
                                       15: "Pull-Down Button Square",                       // 15 = kCoreThemeSquarePullDownButtonID
                                       16: "Box",                                           // 16 = kCoreThemeBoxID
                                       17: "Menu",                                          // 17 = kCoreThemeMenuID
                                       18: "Scroller",                                      // 18 = kCoreThemeScrollerID
                                       19: "SplitView",                                     // 19 = kCoreThemeSplitViewID
                                       20: "Stepper",                                       // 20 = kCoreThemeStepperElementID
                                       21: "Tab View",                                      // 21 = kCoreThemeTabViewElementID
                                       22: "Table View",                                    // 22 = kCoreThemeTableViewElementID
                                       23: "Text Field",                                    // 23 = kCoreThemeTextFieldElementID
                                       24: "Window",                                        // 24 = kCoreThemeWindowID
                                       25: "Patterns",                                      // 25 = kCoreThemePatternsElementID
                                       26: "Button Glyphs",                                 // 26 = kCoreThemeButtonGlyphsID
                                       27: "Bezel",                                         // 27 = kCoreThemeBezelElementID
                                       28: "Progress Bar",                                  // 28 = kCoreThemeProgressBarID
                                       29: "Image Well",                                    // 29 = kCoreThemeImageWellID
                                       30: "Slider",                                        // 30 = kCoreThemeSliderID
                                       31: "Dial",                                          // 31 = kCoreThemeDialID
                                       32: "Drawer",                                        // 32 = kCoreThemeDrawerID
                                       33: "Toolbar",                                       // 33 = kCoreThemeToolbarID
                                       34: "Cursors",                                       // 34 = kCoreThemeCursorsID
                                       35: "Timeline",                                      // 35 = kCoreThemeTimelineID
                                       36: "Zoom Bar",                                      // 36 = kCoreThemeZoomBarID
                                       37: "Zoom Slider",                                   // 37 = kCoreThemeZoomSliderID
                                       38: "Icons",                                         // 38 = kCoreThemeIconsID
                                       39: "List Color Picker Scroller",                    // 39 = kCoreThemeListColorPickerScrollerID
                                       40: "Color Panel",                                   // 40 = kCoreThemeColorPanelID
                                       41: "Texture Group",                                 // 41 = kCoreThemeTextureID
                                       42: "Browser",                                       // 42 = kCoreThemeBrowserID
                                       43: "Nav Panel",                                     // 43 = kCoreThemeNavID
                                       44: "Search Field",                                  // 44 = kCoreThemeSearchFieldID
                                       45: "Font Panel",                                    // 45 = kCoreThemeFontPanelID
                                       46: "Scrubber",                                      // 46 = kCoreThemeScrubberID
                                       47: "Textured Window",                               // 47 = kCoreThemeTexturedWindowID
                                       48: "Utility Window",                                // 48 = kCoreThemeUtilityWindowID
                                       49: "Transient Color Picker",                        // 49 = kCoreThemeTransientColorPickerID
                                       50: "Segmented Scrubber",                            // 50 = kCoreThemeSegmentedScrubberID
                                       51: "Commands",                                      // 51 = kCoreThemeCommandsID
                                       52: "Path Control",                                  // 52 = kCoreThemePathControlID
                                       53: "Custom Button for Zero Code",                   // 53 = kCoreThemeCustomButtonID
                                       54: "Zero Code Place Holder",                        // 54 = kCoreThemeZeroCodePlaceHolderID
                                       55: "Rule Editor",                                   // 55 = kCoreThemeRuleEditorID
                                       56: "Token Field",                                   // 56 = kCoreThemeTokenFieldID
                                       57: "PopUp Arrows for TableViews",                   // 57 = kCoreThemePopUpTableViewArrowsID
                                       58: "PullDown Arrow for TableViews",                 // 58 = kCoreThemePullDownTableViewArrowsID
                                       59: "Combo Box Arrow for TableViews",                // 59 = kCoreThemeComboBoxTableArrowID
                                       60: "Rule Editor - PopUp Button",                    // 60 = kCoreThemeRuleEditorPopUpID
                                       61: "Rule Editor - Stepper",                         // 61 = kCoreThemeRuleEditorStepperID
                                       62: "Rule Editor - ComboBox",                        // 62 = kCoreThemeRuleEditorComboBoxID
                                       63: "Rule Editor - Action Buttons",                  // 63 = kCoreThemeRuleEditorActionButtonsID
                                       64: "Color Slider",                                  // 64 = kCoreThemeColorSliderID
                                       65: "Control Gradient",                              // 65 = kCoreThemeGradientControlGradientID
                                       66: "Gradient Bezel",                                // 66 = kCoreThemeGradientControlBezelID
                                       67: "MegaTrackball",                                 // 67 = kCoreThemeMegaTrackballID
                                       // 68-73: Not Found
                                       74: "LevelIndicatorRelevancy",                       // 74 = kCoreThemeLevelIndicatorRelevancyID
                                       // 75-78: Not Found
                                       79: "Toolbar Raised Effect",                         // 79 = kCoreThemeToolbarRaisedEffectID
                                       80: "Sidebar Raised Effect",                         // 80 = kCoreThemeSidebarRaisedEffectID
                                       81: "Lowered Embossed Effect",                       // 81 = kCoreThemeLoweredEmbossedEffectID
                                       82: "Fullscreen/TAL Window Controls Effect",         // 82 = kCoreThemeTitlebarRaisedEffectID
                                       83: "Segmented Control Rounded",                     // 83 = kCoreThemeSegmentedControlRoundedID
                                       84: "Segmented Control Textured",                    // 84 = kCoreThemeSegmentedControlTexturedID
                                       85: "Named Element",                                 // 85 = kCoreThemeNamedElementID
                                       86: "Letterpress Emboss Effect",                     // 86 = kCoreThemeLetterpressEffectID
                                       87: "Round Rect Button",                             // 87 = kCoreThemeRoundRectButtonID
                                       88: "Round Button",                                  // 88 = kCoreThemeButtonRoundID
                                       89: "Textured Round Button",                         // 89 = kCoreThemeButtonRoundTexturedID
                                       90: "Round Help Button",                             // 90 = kCoreThemeButtonRoundHelpID
                                       91: "Scroll Bar Overlay",                            // 91 = kCoreThemeScrollerOverlayID
                                       92: "Scroll View Frame",                             // 92 = kCoreThemeScrollViewFrameID
                                       93: "Popover",                                       // 93 = kCoreThemePopoverID
                                       94: "Light Content Effect",                          // 94 = kCoreThemeLightContentEffectID
                                       95: "Disclosure Triangle",                           // 95 = kCoreThemeDisclosureTriangleElementID
                                       96: "Source List",                                   // 96 = kCoreThemeSourceListElementID
                                       97: "Pop-Up Button",                                 // 97 = kCoreThemePopUpButtonID
                                       98: "Pull-Down Button",                              // 98 = kCoreThemePullDownButtonID
                                       99: "Textured Text Field",                           // 99 = kCoreThemeTextFieldTexturedElementID
                                       100: "Textured Combo Box",                           // 100 = kCoreThemeComboBoxButtonTexturedID
                                       101: "Structured Image",                             // 101 = kCoreThemeStructuredImageElementID
                                       102: "Pop-Up Button Inset",                          // 102 = kCoreThemePopUpButtonInsetID
                                       103: "Pull Down Button Inset",                       // 103 = kCoreThemePullDownButtonInsetID
                                       104: "Sheet",                                        // 104 = kCoreThemeSheetID
                                       105: "Bevel Button Square",                          // 105 = kCoreThemeBevelButtonSquareID
                                       106: "Bevel Button Pop Up Arrow",                    // 106 = kCoreThemeBevelButtonPopUpArrowID
                                       107: "Recessed Button",                              // 107 = kCoreThemeRecessedButtonID
                                       108: "Segmented Control Separated Toolbar",          // 108 = kCoreThemeSegmentedControlSeparatedToolbarID
                                       109: "Light Effect",                                 // 109 = kCoreThemeLightEffectID
                                       110: "Dark Effect",                                  // 110 = kCoreThemeDarkEffectID
                                       111: "Round Button Inset",                           // 111 = kCoreThemeButtonRoundInsetID
                                       112: "Segmented Control Separated",                  // 112 = kCoreThemeButtonRoundInsetID
                                       113: "Borderless Effect",                            // 113 = kCoreThemeBorderlessEffectID
                                       114: "MenuBar Effect",                               // 114 = kCoreThemeMenuBarEffectID
                                       115: "Secondary Box",                                // 115 = kCoreThemeSecondaryBoxID
                                       116: "Dock Badge",                                   // 116 = kCoreThemeDockBadgeID
                                       117: "Banner",                                       // 117 = kCoreThemeBannerID
                                       118: "Textured Button",                              // 118 = kCoreThemePushButtonTexturedID
                                       119: "Inset Segmented Control",                      // 119 = kCoreThemeSegmentedControlInsetID
                                       120: "HUD Window",                                   // 120 = kCoreThemeHUDWindowID
                                       121: "FullScreen Window",                            // 121 = kCoreThemeFullScreenWindowID
                                       122: "Table View Opaque",                            // 122 = kCoreThemeTableViewOpaqueElementID
                                       123: "Table View Translucent",                       // 123 = kCoreThemeTableViewTranslucentElementID
                                       124: "Image Well Opaque",                            // 124 = kCoreThemeImageWellOpaqueID
                                       125: "State Transform Effect",                       // 125 = kCoreThemeStateTransformEffectID
                                       // 126: Not Found
                                       127: "Light Material",                               // 127 = kCoreThemeLightMaterialID
                                       128: "Mac Light Material",                           // 128 = kCoreThemeMacLightMaterialID
                                       129: "Ultralight Material",                          // 129 = kCoreThemeUltralightMaterialID
                                       130: "Mac Ultralight Material",                      // 130 = kCoreThemeMacUltralightMaterialID
                                       131: "Mac Dark Material",                            // 131 = kCoreThemeMacDarkMaterialID
                                       132: "Mac Medium Dark Material",                     // 132 = kCoreThemeMacMediumDarkMaterialID
                                       133: "Mac Ultradark Material",                       // 133 = kCoreThemeMacUltradarkMaterialID
                                       134: "Titlebar Material",                            // 134 = kCoreThemeTitlebarMaterialID
                                       135: "Selection Material",                           // 135 = kCoreThemeSelectionMaterialID
                                       136: "Emphasized Selection Material",                // 136 = kCoreThemeEmphasizedSelectionMaterialID
                                       137: "Header Material",                              // 137 = kCoreThemeHeaderMaterialID
                                       138: "Toolbar Combo Box",                            // 138 = kCoreThemeComboBoxButtonToolbarID
                                       139: "Pop-Up Button Toolbar",                        // 139 = kCoreThemePopUpButtonToolbarID
                                       140: "Pull-Down Button Rounded Toolbar",             // 140 = kCoreThemePullDownButtonToolbarID
                                       141: "Toolbar Round Button",                         // 141 = kCoreThemeButtonRoundToolbarID
                                       142: "Segmented Control Separated Textured",         // 142 = kCoreThemeSegmentedControlSeparatedTexturedID
                                       143: "Segmented Control Toolbar",                    // 143 = kCoreThemeSegmentedControlToolbarID
                                       144: "Toolbar Button",                               // 144 = kCoreThemePushButtonToolbarID
                                       145: "Opaque Light Material",                        // 145 = kCoreThemeLightOpaqueMaterialID
                                       146: "Opaque Mac Light Material",                    // 146 = kCoreThemeMacLightOpaqueMaterialID
                                       147: "Opaque Ultralight Material",                   // 147 = kCoreThemeUltralightOpaqueMaterialID
                                       148: "Opaque Mac Ultralight Material",               // 148 = kCoreThemeMacUltralightOpaqueMaterialID
                                       149: "Opaque Mac Dark Material",                     // 149 = kCoreThemeMacDarkOpaqueMaterialID
                                       150: "Opaque Mac Medium Dark Material",              // 150 = kCoreThemeMacMediumDarkOpaqueMaterialID
                                       151: "Opaque Mac Ultradark Material",                // 151 = kCoreThemeMacUltradarkOpaqueMaterialID
                                       152: "Opaque Titlebar Material",                     // 152 = kCoreThemeTitlebarOpaqueMaterialID
                                       153: "Opaque Selection Material",                    // 153 = kCoreThemeSelectionOpaqueMaterialID
                                       154: "Opaque Emphasized Selection Material",         // 154 = kCoreThemeEmphasizedSelectionOpaqueMaterialID
                                       155: "Opaque Header Material",                       // 155 = kCoreThemeHeaderOpaqueMaterialID
                                       156: "Recessed Pull Down Button",                    // 156 = kCoreThemeRecessedPullDownButtonID
                                       157: "Bezel Tint Effect",                            // 157 = kCoreThemeBezelTintEffectID
                                       158: "Default Bezel Tint Effect",                    // 158 = kCoreThemeDefaultBezelTintEffectID
                                       159: "On-Off Bezel Tint Effect",                     // 159 = kCoreThemeOnOffBezelTintEffectID
                                       160: "Mac Medium Light Material",                    // 160 = kCoreThemeMacMediumLightMaterialID
                                       161: "Opaque Mac Medium Light Material",             // 161 = kCoreThemeMacMediumLightOpaqueMaterialID
                                       162: "Selection Overlay",                            // 162 = kCoreThemeSelectionOverlayID
                                       163: "Range Selector",                               // 163 = kCoreThemeRangeSelectorID
                                       164: "Model Asset",                                  // 164 = kCoreThemeModelAssetID
                                       // 165: Not Found
                                       166: "Segmented Control Small Square",               // 166 = kCoreThemeSegmentedControlSmallSquareID
                                       167: "LevelIndicator",                               // 167 = kCoreThemeLevelIndicatorID
                                       168: "Menu Material",                                // 168 = kCoreThemeMenuMaterialID
                                       169: "Menu Bar Material",                            // 169 = kCoreThemeMenuBarMaterialID
                                       170: "Popover Material",                             // 170 = kCoreThemePopoverMaterialID
                                       171: "Popover Label Material",                       // 171 = kCoreThemePopoverLabelMaterialID
                                       172: "ToolTip Material",                             // 172 = kCoreThemeToolTipMaterialID
                                       173: "Sidebar Material",                             // 173 = kCoreThemeSidebarMaterialID
                                       174: "Window Background Material",                   // 174 = kCoreThemeWindowBackgroundMaterialID
                                       175: "Under Window Background Material",             // 175 = kCoreThemeUnderWindowBackgroundMaterialID
                                       176: "Content Background Material",                  // 176 = kCoreThemeContentBackgroundMaterialID
                                       177: "Spotlight Background Material",                // 177 = kCoreThemeSpotlightBackgroundMaterialID
                                       178: "Notification Center Background Material",      // 178 = kCoreThemeNotificationCenterBackgroundMaterialID
                                       179: "Sheet Material",                               // 179 = kCoreThemeSheetMaterialID
                                       180: "HUD Window Material",                          // 180 = kCoreThemeHUDWindowMaterialID
                                       181: "Full Screen UI Material",                      // 181 = kCoreThemeFullScreenUIMaterialID
                                       182: "Opaque Menu Material",                         // 182 = kCoreThemeMenuOpaqueMaterialID
                                       183: "Opaque Menu Bar Material",                     // 183 = kCoreThemeMenuBarOpaqueMaterialID
                                       184: "Opaque Popover Material",                      // 184 = kCoreThemePopoverOpaqueMaterialID
                                       185: "Opaque Popover Label Material",                // 185 = kCoreThemePopoverLabelOpaqueMaterialID
                                       186: "Opaque ToolTip Material",                      // 186 = kCoreThemeToolTipOpaqueMaterialID
                                       187: "Opaque Sidebar Material",                      // 187 = kCoreThemeSidebarOpaqueMaterialID
                                       188: "Opaque Window Background Material",            // 188 = kCoreThemeWindowBackgroundOpaqueMaterialID
                                       189: "Opaque Under Window Background Material",      // 189 = kCoreThemeUnderWindowBackgroundOpaqueMaterialID
                                       190: "Opaque Content Background Material",           // 190 = kCoreThemeContentBackgroundOpaqueMaterialID
                                       191: "Opaque Spotlight Background Material",         // 191 = kCoreThemeSpotlightBackgroundOpaqueMaterialID
                                       192: "Opaque Notification Center Background Material", // 192 = kCoreThemeNotificationCenterBackgroundOpaqueMaterialID
                                       193: "Opaque Sheet Material",                        // 193 = kCoreThemeSheetOpaqueMaterialID
                                       194: "Opaque HUD Window Material",                   // 194 = kCoreThemeHUDWindowOpaqueMaterialID
                                       195: "Opaque Full Screen UI Material",               // 195 = kCoreThemeFullScreenUIOpaqueMaterialID
                                       196: "Color Effect for Text Highlights",             // 196 = kCoreThemeTextHighlightEffectID
                                       197: "Color Effect for Selected Rows",               // 197 = kCoreThemeRowSelectionEffectID
                                       198: "Color Effect for Focus Rings",                 // 198 = kCoreThemeFocusRingEffectID
                                       199: "Square Box",                                   // 199 = kCoreThemeBoxSquareID
                                       200: "Color Effect for Selection",                   // 200 = kCoreThemeSelectionEffectID
                                       201: "UnderPage Background Material",                // 201 = kCoreThemeUnderPageBackgroundMaterialID
                                       202: "UnderPage Background Opaque Material",         // 202 = kCoreThemeUnderPageBackgroundOpaqueMaterialID
                                       203: "Inline Sidebar Material",                      // 203 = kCoreThemeInlineSidebarMaterialID
                                       204: "Inline Sidebar Opaque Material",               // 204 = kCoreThemeInlineSidebarOpaqueMaterialID
                                       205: "MenuBar Menu Material",                        // 205 = kCoreThemeMenuBarMenuMaterialID
                                       206: "MenuBar Menu Opaque Material",                 // 206 = kCoreThemeMenuBarMenuOpaqueMaterialID
                                       207: "HUD Controls Background Material",             // 207 = kCoreThemeHUDControlsBackgroundMaterialID
                                       208: "HUD Controls Background Opaque Material",      // 208 = kCoreThemeHUDControlsBackgroundOpaqueMaterialID
                                       209: "System Bezel Material",                        // 209 = kCoreThemeSystemBezelMaterialID
                                       210: "System Bezel Opaque Material",                 // 210 = kCoreThemeSystemBezelOpaqueMaterialID
                                       211: "Login Window Control Material",                // 211 = kCoreThemeLoginWindowControlMaterialID
                                       212: "Login Window Control Opaque Material",         // 212 = kCoreThemeLoginWindowControlOpaqueMaterialID
                                       213: "Desktop Stack Material",                       // 213 = kCoreThsemeDesktopStackMaterialID
                                       214: "Desktop Stack Opaque Material",                // 214 = kCoreThemeDesktopStackOpaqueMaterialID
                                       215: "Color Effect for Detail Accent Colors",        // 215 = kCoreThemeDetailAccentEffectID
                                       216: "Toolbar State Transform Effect",               // 216 = kCoreThemeToolbarStateTransformEffectID
                                       217: "Stateful Colors System Effect",                // 217 = kCoreThemeStatefulColorsSystemEffectID
                                       218: "Switch",                                       // 218 = kCoreThemeSwitchElementID
                                       219: "Inline Titlebar Material",                     // 219 = kCoreThemeInlineTitlebarMaterialID
                                       220: "Inline Titlebar Opaque Material"]              // 220 = kCoreThemeInlineTitlebarOpaqueMaterialID
    
                                                                                            /// **  ThemePart  **
    static let Part                 = [0: "Basic - Basic Part",                             // 0 = kCoreThemeBasicPartID
                                       1: "Basic Button - Titlebar Controls",               // 1 = kCoreThemeTitlebarControlsID
                                       2: "Basic Button - Show Hide Button",                // 2 = kCoreThemeShowHideButtonID
                                       3: "Box - Primary Box",                              // 3 = kCoreThemeBoxPrimaryID
                                       4: "Box - Secondary Box",                            // 4 = kCoreThemeBoxSecondaryID
                                       5: "Box - Metal Box",                                // 5 = kCoreThemeBoxMetalID
                                       6: "Box - Well Box",                                 // 6 = kCoreThemeBoxWellID
                                       7: "Menu - Menu Glyphs",                             // 7 = kCoreThemeMenuGlyphsID
                                       8: "Scroller - Corner",                              // 8 = kCoreThemeCornerID
                                       9: "Scroller - Slot",                                // 9 = kCoreThemeSlotID
                                       10: "Scroller / Zoom / SplitView - Thumb",           // 10 = kCoreThemeThumbID
                                       11: "Scroller - No Arrow",                           // 11 = kCoreThemeNoArrowID
                                       12: "Scroller / Toolbar - Single Arrow",             // 12 = kCoreThemeSingleArrowID
                                       13: "Scroller - Double Arrow Min End",               // 13 = kCoreThemeDoubleArrowMinEndID
                                       14: "Scroller - Double Arrow Max End",               // 14 = kCoreThemeDoubleArrowMaxEndID
                                       15: "SplitView - Divider",                           // 15 = kCoreThemeDividerID
                                       16: "Tab View - Primary Tab",                        // 16 = kCoreThemeTabViewPrimaryTabID
                                       17: "Tab View - Secondary Tab",                      // 17 = kCoreThemeTabViewSecondaryTabID
                                       18: "Tab View - Tab View Rod",                       // 18 = kCoreThemeTabViewRodID
                                       19: "Tab View - Large Rod",                          // 19 = kCoreThemeTabViewLargeRodID
                                       20: "Tab View - Small Rod",                          // 20 = kCoreThemeTabViewSmallRodID
                                       21: "Tab View - Mini Rod",                           // 21 = kCoreThemeTabViewMiniRodID
                                       22: "Tab View - Tab Pane",                           // 22 = kCoreThemeTabViewPaneID
                                       23: "Table View - Primary ListHeader",               // 23 = kCoreThemePrimaryListHeaderID
                                       24: "Table View - Secondary ListHeader",             // 24 = kCoreThemeSecondaryListHeaderID
                                       25: "Table View - ListHeader Glyphs",                // 25 = kCoreThemeListHeaderGlyphsID
                                       26: "Window - Title Bar",                            // 26 = kCoreThemeTitlebarID
                                       27: "Window - Buttons",                              // 27 = kCoreThemeWindowButtonsID
                                       28: "Window - Resize Control",                       // 28 = kCoreThemeResizeControlID
                                       29: "Toolbar - Double Arrow",                        // 29 = kCoreThemeDoubleArrowID
                                       30: "Toolbar - Toolbar Icons",                       // 30 = kCoreThemeToolbarIconsID
                                       31: "Toolbar - Spacer Icons",                        // 31 = kCoreThemeToolbarSpacerIconsID
                                       32: "Progress Bar - Background",                     // 32 = kCoreThemeProgressBackgroundID
                                       33: "Progress Bar - Determinate",                    // 33 = kCoreThemeProgressBarDeterminateID
                                       34: "Progress Bar - Indeterminate",                  // 34 = kCoreThemeProgressBarIndeterminateID
                                       35: "Slider - Track",                                // 35 = kCoreThemeSliderTrackID
                                       36: "Slider - Knob",                                 // 36 = kCoreThemeSliderKnobID
                                       37: "Slider - Tick",                                 // 37 = kCoreThemeSliderTickID
                                       38: "Bezel - Thumbnail",                             // 38 = kCoreThemeThumbnailBezelID
                                       39: "Bezel - Color Swatch",                          // 39 = kCoreThemeColorSwatchBezelID
                                       40: "Text Field - Round Text Field",                 // 40 = kCoreThemeRoundBezelID
                                       41: "Text Field - Square Text Field",                // 41 = kCoreThemeSquareBezelID
                                       42: "Vector Artwork Image",                          // 42 = kCoreThemeVectorArtworkImageID
                                       43: "Cursors - Standard Cursors",                    // 43 = kCoreThemeStandardCursorsID
                                       44: "Timeline - Stream",                             // 44 = kCoreThemeTimelineStreamID
                                       45: "Timeline - Clip",                               // 45 = kCoreThemeTimelineClipID
                                       46: "Timeline - Selected Clip",                      // 46 = kCoreThemeTimelineSelectedClipID
                                       47: "Timeline - Lock Overlay",                       // 47 = kCoreThemeTimelineLockOverlayID
                                       // 48: Not Found
                                       49: "Timeline - Locked Glyph",                       // 49 = kCoreThemeTimelineLockedGlyphID
                                       50: "Timeline / Zoom Bar - Play Head",               // 50 = kCoreThemePlayHeadID
                                       51: "Timeline - Track Size Button",                  // 51 = kCoreThemeTimelineTrackSizeButtonID
                                       52: "Timeline - Time Code Icon",                     // 52 = kCoreThemeTimeCodeIconID
                                       53: "Glass Button / Button Glyphs - Round Button",   // 53 = kCoreThemeGlassRoundButtonID
                                       54: "Glass Button / Button Glyphs - Visibility Button", // 54 = kCoreThemeGlassVisibilityButtonID
                                       55: "Tab Button - Singleton",                        // 55 = kCoreThemeTabButtonSingletonID
                                       56: "Tab Button - Matrix",                           // 56 = kCoreThemeTabButtonMatrixID
                                       57: "Button Glyphs - Sample Glyphs for Tab Matrix Buttons", // 57 = kCoreThemeSampleGlyphsTabButtonsID
                                       58: "Button Glyphs - Sample Glyphs for Singleton Tab Buttons", // 58 = kCoreThemeSampleGlyphsSingleTabButtonID
                                       59: "Glyph Vector Data",                             // 59 = kCoreThemeVectorGlyphID
                                       // 60: Not Found
                                       61: "Bezel - Large Text Bezel",                      // 61 = kCoreThemeLargeTextBezelID
                                       62: "Text Field - Display Text Bezel",               // 62 = kCoreThemeDisplayTextBezelID
                                       63: "Drawer - Slideout Bezel",                       // 63 = kCoreThemeSlideOutBezelID
                                       // 64: Not Found
                                       65: "Drawer - Affordance",                           // 65 = kCoreThemeDrawerAffordanceID
                                       66: "Dial - Dimple",                                 // 66 = kCoreThemeDimpleID
                                       67: "Disclosure - Triangle",                         // 67 = kCoreThemeDisclosureTriangleID
                                       68: "Disclosure - Knob",                             // 68 = kCoreThemeDisclosureKnobID
                                       69: "Disclosure - Glyph",                            // 69 = kCoreThemeDisclosureGlyphID
                                       70: "Button Glyphs - Type Alignment Glyph",          // 70 = kCoreThemeTypeAlignGlyphID
                                       71: "Button Glyphs - Type Leading Glyph",            // 71 = kCoreThemeTypeLeadingGlyphID
                                       72: "Button Glyphs - Font Panel Glyphs",             // 72 = kCoreThemeFontPanelGlyphsID
                                       73: "Icons - Preferences",                           // 73 = kCoreThemePreferencesID
                                       74: "Icons - Note Glyph",                            // 74 = kCoreThemeNoteGlyphID
                                       75: "Bezel - Preview Bezel",                         // 75 = kCoreThemePreviewBezelID
                                       76: "Glass Button / Button Glyphs - Help Button",    // 76 = kCoreThemeGlassHelpButtonID
                                       77: "Browser - Column Resize",                       // 77 = kCoreThemeColumnResizerID
                                       78: "Search Field - Search Button",                  // 78 = kCoreThemeSearchButtonID
                                       79: "Search Field - Cancel Button",                  // 79 = kCoreThemeCancelButtonID
                                       80: "Search Field - SnapBack Button",                // 80 = kCoreThemeSnapBackButtonID
                                       81: "Scrubber / Segmented Scrubber - Arrows",        // 81 = kCoreThemeArrowsID
                                       82: "Nav Panel - Scope Button",                      // 82 = kCoreThemeScopeButtonID
                                       83: "Nav Panel - Preview Button",                    // 83 = kCoreThemePreviewButtonID
                                       84: "Textured Window - Scratches",                   // 84 = kCoreThemeWindowTextureID
                                       85: "Textured Window - Gradient",                    // 85 = kCoreThemeWindowTextureGradientID
                                       86: "Window - Round Corner",                         // 86 = kCoreThemeWindowRoundCornerID
                                       87: "Unified Toolbar - Gradient",                    // 87 = kCoreThemeUnifiedWindowFillID
                                       88: "Menu - Menu Bar",                               // 88 = kCoreThemeMenuBarID
                                       89: "Menu - Apple Menu",                             // 89 = kCoreThemeAppleMenuID
                                       90: "Box - Matte Well Box",                          // 90 = kCoreThemeBoxMatteWellID
                                       91: "Transient Color Picker - Image",                // 91 = kCoreThemeTransientColorPickerImageID
                                       92: "Transient Color Picker - Grayscale Image",      // 92 = kCoreThemeTransientColorPickerImageGrayscaleID
                                       93: "Transient Color Picker - Color Well Left Part", // 93 = kCoreThemeTransientColorWellButtonLeftPartID
                                       94: "Transient Color Picker - Color Well Separator", // 94 = kCoreThemeTransientColorWellButtonSeparatorID
                                       95: "Transient Color Picker - Color Well Right Part", // 95 = kCoreThemeTransientColorWellButtonRightPartID
                                       96: "Transient Color Picker - Color Well (Large) Left Part", // 96 = kCoreThemeTransientColorWellButtonLeftPartLgID
                                       97: "Transient Color Picker - Color Well (Large) Separator", // 97 = kCoreThemeTransientColorWellButtonSeparatorLgID
                                       98: "Transient Color Picker - Color Well (Large) Right Part", // 98 = kCoreThemeTransientColorWellButtonRightPartLgID
                                       99: "Segmented Scrubber - Caret",                    // 99 = kCoreThemeCaretID
                                       100: "Segmented Scrubber - Scrubbing Arrows",        // 100 = kCoreThemeScrubbingArrowsID
                                       101: "Commands - Icons",                             // 101 = kCoreThemeCommandIconsID
                                       102: "Commands - Key Cap",                           // 102 = kCoreThemeCommandKeyCapID
                                       103: "Commands - Extra KeyPad Glyphs",               // 103 = kCoreThemeCommandInfoID
                                       104: "Path Control - Divider",                       // 104 = kCoreThemePathControlDividerID
                                       105: "Path Control - Navagation Bar",                // 105 = kCoreThemePathControlNavBarID
                                       106: "Box - Raised Box",                             // 106 = kCoreThemeBoxRaisedID
                                       107: "Box - Inset Box",                              // 107 = kCoreThemeBoxInsetID
                                       108: "Commands - Searching Focus",                   // 108 = kCoreThemeCommandsSearchFocus
                                       109: "Commands - Searching Overlay",                 // 109 = kCoreThemeCommandsSearchOverlay
                                       // 110-111: Not Found
                                       112: "TableView - Chevron",                          // 112 = kCoreThemeTableViewChevronID
                                       113: "Zero Code - Small Glyph",                      // 113 = kCoreThemeZoomSmallGlyphID
                                       114: "Zero Code - Large Glyph",                      // 114 = kCoreThemeZoomLargeGlyphID
                                       115: "Commands - Key Cap Patch",                     // 115 = kCoreThemeCommandKeyCapPatchID
                                       116: "Button Glyphs - Navigate Backward",            // 116 = kCoreThemeNavigateBackwardID
                                       117: "Button Glyphs - Navigate Forward",             // 117 = kCoreThemeNavigateForwardID
                                       // 118: Not Found
                                       119: "Box - Group Well Box",                         // 119 = kCoreThemeGroupWellID
                                       120: "Segmented Scrubber - TableView Scrubbing Arrows", // 120 = kCoreThemeTableViewScrubbingArrowsID
                                       121: "Progress Indicator - Spinning",                // 121 = kCoreThemeProgressSpinningID
                                       122: "Rule Editor - Label Bullets Round (Tiger)",    // 122 = kCoreThemeLabelBulletRoundID
                                       123: "Rule Editor - Label Selectors Round (Tiger)",  // 123 = kCoreThemeLabelSelectorRoundID
                                       124: "Rule Editor - Label Bullets Square (Leopard)", // 124 = kCoreThemeLabelBulletSquareID
                                       125: "Rule Editor - Label Selectors Square (Leopard)", // 125 = kCoreThemeLabelSelectorSquareID
                                       126: "Disclosure - Nav Sidebar Highlighted Triangle", // 126 = kCoreThemeDisclosureTriangleSidebarID
                                       127: "Packed Contents names",                        // 127 = kCoreThemePackedContentsNamesID
                                       128: "Transient Color Picker - Swatch Background",   // 128 = kCoreThemeTransientColorPickerSwatchBackgroundID
                                       129: "Segmented Control Separator",                  // 129 = kCoreThemeSegmentedControlSeparatorID
                                       130: "Color Label Patterns",                         // 130 = kCoreThemeColorLabelPatternsID
                                       131: "MegaTrackball - Puck",                         // 131 = kCoreThemeMegaTrackballPuckID
                                       132: "MegaTrackball - Glyphs",                       // 132 = kCoreThemeMegaTrackballGlyphsID
                                       133: "MegaTrackball - Base Gradient",                // 133 = kCoreThemeMegaTrackballBaseGradientID
                                       134: "MegaTrackball - Hue Ring",                     // 134 = kCoreThemeMegaTrackballHueRingID
                                       135: "MegaTrackball - Base Shadow Mask",             // 135 = kCoreThemeMegaTrackballBaseShadowMaskID
                                       136: "MegaTrackball - Center",                       // 136 = kCoreThemeMegaTrackballCenterID
                                       137: "Icons - Unified Zoom",                         // 137 = kCoreThemeZoomUnifiedGlyphID
                                       138: "Segmented Control Bezel",                      // 138 = kCoreThemeSegmentedControlBezelID
                                       139: "Browser - Branch Image",                       // 139 = kCoreThemeBrowserBranchID
                                       140: "Pane Cap - Lowered Menu Indicator",            // 140 = kCoreThemePaneCapLoweredMenuIndicatorPartID
                                       141: "Pane Cap - Centered Menu Indicator",           // 141 = kCoreThemePaneCapCenteredMenuIndicatorPartID
                                       142: "Pane Cap - Pop Up Menu Indicator",             // 142 = kCoreThemePaneCapPopUpMenuIndicatorPartID
                                       143: "Content Tab View - Close Button Glyph",        // 143 = kCoreThemeCloseButtonGlyphID
                                       144: "Content Tab View - Tab",                       // 144 = kCoreThemeContentTabViewTabID
                                       145: "Content Tab View - Menu Chevron",              // 145 = kCoreThemeContentTabViewMenuChevronID
                                       146: "Content Tab View - Menu Grabber",              // 146 = kCoreThemeContentViewMenuGrabberID
                                       147: "Content Tab View - Menu Button Glyph",         // 147 = kCoreThemeContentViewMenuButtonGlyphID
                                       148: "Content Tab View - Menu Thumbnail Highlight",  // 148 = kCoreThemeContentViewMenuThumbnailHighlightID
                                       149: "Nav Panel - Scope Bar Push (Save) Button",     // 149 = kCoreThemeNavPushButtonPartID
                                       // 150-152: Not Found
                                       153: "Toolbar Item Selection Indicator",             // 153 = kCoreThemeToolbarSelectionIndicatorID
                                       // 154-159: Not Found
                                       160: "SplitView - Grabber",                          // 160 = kCoreThemeSplitViewGrabberID
                                       // 161-170: Not Found
                                       171: "Pane Cap Header",                              // 171 = kCoreThemePaneCapHeaderID
                                       172: "Pane Cap Footer",                              // 172 = kCoreThemePaneCapFooterID
                                       // 173-174: Not Found
                                       175: "Window - Overlay Pattern",                     // 175 = kCoreThemeWindowOverlayPatternID
                                       176: "Window - Background Image",                    // 176 = kCoreThemeWindowBackgroundImageID
                                       177: "Window - Bottom Gradient",                     // 177 = kCoreThemeWindowBottomGradientID
                                       178: "Image Effect Definition",                      // 178 = kCoreThemeImageEffectID
                                       179: "Text Effect Definition",                       // 179 = kCoreThemeTextEffectID
                                       180: "Menu Seperator",                               // 180 = kCoreThemeMenuSeparatorID
                                       181: "Artwork Image",                                // 181 = kCoreThemeArtworkImageID
                                       182: "Window Titlebar Separator",                    // 182 = kCoreThemeWindowTitlebarSeparatorID
                                       183: "Menu Background",                              // 183 = kCoreThemeMenuPartID
                                       184: "Menu Item",                                    // 184 = kCoreThemeMenuItemPartID
                                       185: "Named Effect",                                 // 185 = kCoreThemeNamedEffectID
                                       186: "Scroller - Expanded Thumb",                    // 186 = kCoreThemeExpandedThumbID
                                       187: "Token Field - Token Background",               // 187 = kCoreThemeTokenFieldTokenBackgroundID
                                       188: "Progress Bar Complete - Determinate",          // 188 = kCoreThemeProgressBarDeterminateCompleteID
                                       189: "Progress Bar Shadow - Determinate",            // 189 = kCoreThemeProgressBarDeterminateShadowID
                                       190: "Progress Spinner - Determinate",               // 190 = kCoreThemeProgressSpinningDeterminateID
                                       191: "Popover - Popover Background",                 // 191 = kCoreThemePopoverBackgroundID
                                       192: "Popover - Popover Area of Interest",           // 192 = kCoreThemePopoverAreaOfInterestID
                                       193: "Source List - Source List Background",         // 193 = kCoreThemeSourceListBackgroundID
                                       194: "Source List - Selected Item",                  // 194 = kCoreThemeSourceListSelectionID
                                       195: "Source List - Menu Highlight",                 // 195 = kCoreThemeSourceListMenuHighlightID
                                       196: "Window BottomBar Separator",                   // 196 = kCoreThemeWindowBottomBarSeparatorID
                                       197: "PopUp Arrow Button",                           // 197 = kCoreThemePopUpArrowButton
                                       198: "PopUp Arrows Only",                            // 198 = kCoreThemePopUpArrowsOnly
                                       199: "List Header Arrow Plus Background",            // 199 = kCoreThemeListHeaderGlyphsPlusBackgroundID
                                       200: "Animation",                                    // 200 = kCoreThemeAnimationPartID
                                       201: "PopUp Arrows Subpart",                         // 201 = kCoreThemePopUpArrowsSubpartID
                                       202: "PopUp Endcap Subpart",                         // 202 = kCoreThemePopUpEndcapSubpartID
                                       203: "Dock Badge Background",                        // 203 = kCoreThemeDockBadgeBackgroundID
                                       204: "Table View Group Header",                      // 204 = kCoreThemeGroupHeaderID
                                       205: "Slider Background",                            // 205 = kCoreThemeSliderBackgroundID
                                       206: "Recognition Group",                            // 206 = kCoreThemeRecognitionGroupID
                                       207: "Recognition Object",                           // 207 = kCoreThemeRecognitionObjectID
                                       208: "Flattened Image",                              // 208 = kCoreThemeFlattenedImageID
                                       209: "Radiosity Image",                              // 209 = kCoreThemeRadiosityImageID
                                       210: "Fill",                                         // 210 = kCoreThemeFillID
                                       211: "Outer Stroke",                                 // 211 = kCoreThemeOuterStrokeID
                                       212: "Inner Stroke",                                 // 212 = kCoreThemeInnerStrokeID
                                       213: "Range Selector No Handle",                     // 213 = kCoreThemeRangeSelectorNoHandleID
                                       214: "Range Selector Single Handle",                 // 214 = kCoreThemeRangeSelectorSingleHandleID
                                       215: "Range Selector Dual Handle",                   // 215 = kCoreThemeRangeSelectorDualHandleID
                                       216: "Range Selector Mono Handle",                   // 216 = kCoreThemeRangeSelectorMonoHandleID
                                       217: "Color Part",                                   // 217 = kCoreThemeColorPartID
                                       218: "Multisize Image Set Part",                     // 218 = kCoreThemeMultisizeImageSetPartID
                                       219: "Top Level Model Asset",                        // 219 = kCoreThemeModelAssetPartID
                                       220: "Multisize Image Part",                         // 220 = kCoreThemeMultisizeImagePartID
                                       221: "Level Indicator Fill",                         // 221 = kCoreThemeLevelIndicatorFillID
                                       222: "Level Indicator Mask",                         // 222 = kCoreThemeLevelIndicatorMaskID
                                       223: "Level Indicator Border",                       // 223 = kCoreThemeLevelIndicatorOutlineID
                                       224: "Level Indicator Relevancy Background",         // 224 = kCoreThemeLevelIndicatorRelevancyBackgroundID
                                       225: "Level Indicator Tick Mark Major",              // 225 = kCoreThemeLevelIndicatorTickMarkMajorID
                                       226: "Level Indicator Tick Mark Minor",              // 226 = kCoreThemeLevelIndicatorTickMarkMinorID
                                       227: "Mask Part",                                    // 227 = kCoreThemeMaskID
                                       228: "Border Part",                                  // 228 = kCoreThemeBorderPartID
                                       229: "Right Part",                                   // 229 = kCoreThemeRightPartID
                                       230: "Left Part",                                    // 230 = kCoreThemeLeftPartID
                                       231: "Text Style Part",                              // 231 = kCoreThemeTextStylePartID
                                       232: "Model Mesh Object",                            // 232 = kCoreThemeModelMeshID
                                       233: "Model SubMesh Object",                         // 233 = kCoreThemeModelSubMeshID
                                       234: "Knob",                                         // 234 = kCoreThemeKnobPartID
                                       235: "Label"]                                        // 235 = kCoreThemeLabelPartID
}
