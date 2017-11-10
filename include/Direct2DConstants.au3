#include-once

;############################################################################################################
;# Direct2D Error Codes
;############################################################################################################
Global Const $D2DERR_NOHWND = 0x80070006 ;Handle that is not valid
Global Const $D2DERR_NOPTR = 0x80004003 ;Pointer that is not valid
Global Const $D2DERR_NOOBJ = 0x800710D8 ;The object identifier does not represent a valid object
Global Const $D2DERR_PARAM = 0x80070057 ;One or more arguments are not valid
Global Const $D2DERR_UFAIL = 0x8000FFFF ;Unexpected failure
Global Const $D2DERR_OBJFAIL = 0x80080001 ;Attempt to create a class object failed.
Global Const $D2DERR_OK = 0x0

Global Const $D2DERR_BAD_NUMBER 							= 0x88990011 ;The number is invalid.
Global Const $D2DERR_BITMAP_BOUND_AS_TARGET 				= 0x88990025 ;You can't draw with a bitmap that is currently bound as the target bitmap.
Global Const $D2DERR_BITMAP_CANNOT_DRAW 					= 0x88990021 ;You can't draw with a bitmap that has the D2D1_BITMAP_OPTIONS_CANNOT_DRAW option.
Global Const $D2DERR_CYCLIC_GRAPH 							= 0x88990020 ;A cycle occurred in the graph.
Global Const $D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED 			= 0x88990009 ;The display format to render is not supported by the hardware device.
Global Const $D2DERR_DISPLAY_STATE_INVALID 					= 0x88990006 ;A valid display state could not be determined.
Global Const $D2DERR_EFFECT_IS_NOT_REGISTERED 				= 0x88990028 ;The class ID of the specified effect is not registered by the operating system.
Global Const $D2DERR_EXCEEDS_MAX_BITMAP_SIZE 				= 0x8899001D ;The requested size is larger than the guaranteed supported texture size.
Global Const $D2DERR_INCOMPATIBLE_BRUSH_TYPES 				= 0x88990018 ;The brush types are incompatible for the call.
Global Const $D2DERR_INSUFFICIENT_BUFFER 					= 0x0000007A ;(Windows error)
Global Const $D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES 		= 0x88990026 ;The Direct3D device doesn't have sufficient capabilities to perform the requested action.
Global Const $D2DERR_INTERMEDIATE_TOO_LARGE 				= 0x88990027 ;You can't render the graph with the context's current tiling settings.
Global Const $D2DERR_INTERNAL_ERROR 						= 0x88990008 ;The application should close this instance of Direct2D and restart it as a new process.
Global Const $D2DERR_INVALID_CALL 							= 0x8899000A ;A call to this method is invalid.
Global Const $D2DERR_INVALID_GRAPH_CONFIGURATION 			= 0x8899001E ;A configuration error occurred in the graph.
Global Const $D2DERR_INVALID_INTERNAL_GRAPH_CONFIGURATION 	= 0x8899001F ;An internal configuration error occurred in the graph.
Global Const $D2DERR_INVALID_PROPERTY 						= 0x88990029 ;The specified property doesn't exist.
Global Const $D2DERR_INVALID_TARGET 						= 0x88990024 ;You can't set the image as a target because it is either an effect or a bitmap that doesn't have the D2D1_BITMAP_OPTIONS_TARGET option.
Global Const $D2DERR_LAYER_ALREADY_IN_USE 					= 0x88990013 ;The application attempted to reuse a layer resource that has not yet been popped off the stack.
Global Const $D2DERR_MAX_TEXTURE_SIZE_EXCEEDED 				= 0x8899000F ;The requested DX surface size exceeds the maximum texture size.
Global Const $D2DERR_NO_HARDWARE_DEVICE 					= 0x8899000B ;There is no hardware rendering device available for this operation.
Global Const $D2DERR_NO_SUBPROPERTIES 						= 0x8899002A ;The specified sub-property doesn't exist.
Global Const $D2DERR_NOT_INITIALIZED 						= 0x88990002 ;The object has not yet been initialized.
Global Const $D2DERR_ORIGINAL_TARGET_NOT_BOUND 				= 0x88990023 ;The operation failed because the original target isn't currently bound as a target.
Global Const $D2DERR_OUTSTANDING_BITMAP_REFERENCES 			= 0x88990022 ;The operation can't complete while you have outstanding references to the target bitmap.
Global Const $D2DERR_POP_CALL_DID_NOT_MATCH_PUSH 			= 0x88990014 ;The application attempted to pop a layer off the stack when a clip was at the top, or pop a clip off the stack when a layer was at the top.
Global Const $D2DERR_PRINT_FORMAT_NOT_SUPPORTED 			= 0x8899002C ;This error occurs during print control creation (ID2D1Device::CreatePrintControl) to indicate that the Direct2D print control (ID2D1PrintControl) can't support any of the package target types that represent printer formats.
Global Const $D2DERR_PRINT_JOB_CLOSED 						= 0x8899002B ;The application called ID2D1PrintControl::AddPage or ID2D1PrintControl::Close after the print job is already finished.
Global Const $D2DERR_PUSH_POP_UNBALANCED 					= 0x88990016 ;The application did not pop all clips and layers off the stack, or it attempted to pop too many clips or layers off the stack.
Global Const $D2DERR_RECREATE_TARGET 						= 0x8899000C ;A presentation error has occurred that may be recoverable. The caller needs to re-create the render target then attempt to render the frame again.
Global Const $D2DERR_RENDER_TARGET_HAS_LAYER_OR_CLIPRECT 	= 0x88990017 ;The requested operation cannot be performed until all layers and clips have been popped off the stack.
Global Const $D2DERR_SCANNER_FAILED 						= 0x88990004 ;The geometry scanner failed to process the data.
Global Const $D2DERR_SCREEN_ACCESS_DENIED 					= 0x88990005 ;Direct2D could not access the screen.
Global Const $D2DERR_SHADER_COMPILE_FAILED 					= 0x8899000E ;Shader compilation failed.
Global Const $D2DERR_TARGET_NOT_GDI_COMPATIBLE 				= 0x8899001A ;The render target is not compatible with GDI.
Global Const $D2DERR_TEXT_EFFECT_IS_WRONG_TYPE 				= 0x8899001B ;A text client drawing effect object is of the wrong type.
Global Const $D2DERR_TEXT_RENDERER_NOT_RELEASED 			= 0x8899001C ;An application is holding a reference to the IDWriteTextRenderer interface after the corresponding DrawText or DrawTextLayout call has returned.
Global Const $D2DERR_TOO_MANY_SHADER_ELEMENTS 				= 0x8899000D ;Shader construction failed because it was too complex.
Global Const $D2DERR_TOO_MANY_TRANSFORM_INPUTS 				= 0x8899002D ;An effect attempted to use a transform with too many inputs.
Global Const $D2DERR_UNSUPPORTED_OPERATION 					= 0x88990003 ;The requested operation is not supported.
Global Const $D2DERR_UNSUPPORTED_PIXEL_FORMAT 				= 0x88982f80 ;(error in wincodec.h)
Global Const $D2DERR_UNSUPPORTED_VERSION 					= 0x88990010 ;The requested Direct2D version is not supported.
Global Const $D2DERR_WIN32_ERROR 							= 0x88990019 ;An unknown Win32 failure occurred.
Global Const $D2DERR_WRONG_FACTORY 							= 0x88990012 ;Objects used together were not all created from the same factory instance.
Global Const $D2DERR_WRONG_RESOURCE_DOMAIN 					= 0x88990015 ;The resource used was created by a render target in a different resource domain.
Global Const $D2DERR_WRONG_STATE 							= 0x88990001 ;The object was not in the correct state to process the method.
Global Const $D2DERR_ZERO_VECTOR 							= 0x88990007 ;The supplied vector is zero.




;############################################################################################################
;# D2D1_Enumerations
;############################################################################################################

;# D3D10_FEATURE_LEVEL1
Global Const $D3D10_FEATURE_LEVEL_10_0   = 0xA000
Global Const $D3D10_FEATURE_LEVEL_10_1   = 0xA100
Global Const $D3D10_FEATURE_LEVEL_9_1    = 0x9100
Global Const $D3D10_FEATURE_LEVEL_9_2    = 0x9200
Global Const $D3D10_FEATURE_LEVEL_9_3    = 0x9300

;# DXGI_FORMAT
Global Const $DXGI_FORMAT_UNKNOWN                      = 0
Global Const $DXGI_FORMAT_R32G32B32A32_TYPELESS        = 1
Global Const $DXGI_FORMAT_R32G32B32A32_FLOAT           = 2
Global Const $DXGI_FORMAT_R32G32B32A32_UINT            = 3
Global Const $DXGI_FORMAT_R32G32B32A32_SINT            = 4
Global Const $DXGI_FORMAT_R32G32B32_TYPELESS           = 5
Global Const $DXGI_FORMAT_R32G32B32_FLOAT              = 6
Global Const $DXGI_FORMAT_R32G32B32_UINT               = 7
Global Const $DXGI_FORMAT_R32G32B32_SINT               = 8
Global Const $DXGI_FORMAT_R16G16B16A16_TYPELESS        = 9
Global Const $DXGI_FORMAT_R16G16B16A16_FLOAT           = 10
Global Const $DXGI_FORMAT_R16G16B16A16_UNORM           = 11
Global Const $DXGI_FORMAT_R16G16B16A16_UINT            = 12
Global Const $DXGI_FORMAT_R16G16B16A16_SNORM           = 13
Global Const $DXGI_FORMAT_R16G16B16A16_SINT            = 14
Global Const $DXGI_FORMAT_R32G32_TYPELESS              = 15
Global Const $DXGI_FORMAT_R32G32_FLOAT                 = 16
Global Const $DXGI_FORMAT_R32G32_UINT                  = 17
Global Const $DXGI_FORMAT_R32G32_SINT                  = 18
Global Const $DXGI_FORMAT_R32G8X24_TYPELESS            = 19
Global Const $DXGI_FORMAT_D32_FLOAT_S8X24_UINT         = 20
Global Const $DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS     = 21
Global Const $DXGI_FORMAT_X32_TYPELESS_G8X24_UINT      = 22
Global Const $DXGI_FORMAT_R10G10B10A2_TYPELESS         = 23
Global Const $DXGI_FORMAT_R10G10B10A2_UNORM            = 24
Global Const $DXGI_FORMAT_R10G10B10A2_UINT             = 25
Global Const $DXGI_FORMAT_R11G11B10_FLOAT              = 26
Global Const $DXGI_FORMAT_R8G8B8A8_TYPELESS            = 27
Global Const $DXGI_FORMAT_R8G8B8A8_UNORM               = 28
Global Const $DXGI_FORMAT_R8G8B8A8_UNORM_SRGB          = 29
Global Const $DXGI_FORMAT_R8G8B8A8_UINT                = 30
Global Const $DXGI_FORMAT_R8G8B8A8_SNORM               = 31
Global Const $DXGI_FORMAT_R8G8B8A8_SINT                = 32
Global Const $DXGI_FORMAT_R16G16_TYPELESS              = 33
Global Const $DXGI_FORMAT_R16G16_FLOAT                 = 34
Global Const $DXGI_FORMAT_R16G16_UNORM                 = 35
Global Const $DXGI_FORMAT_R16G16_UINT                  = 36
Global Const $DXGI_FORMAT_R16G16_SNORM                 = 37
Global Const $DXGI_FORMAT_R16G16_SINT                  = 38
Global Const $DXGI_FORMAT_R32_TYPELESS                 = 39
Global Const $DXGI_FORMAT_D32_FLOAT                    = 40
Global Const $DXGI_FORMAT_R32_FLOAT                    = 41
Global Const $DXGI_FORMAT_R32_UINT                     = 42
Global Const $DXGI_FORMAT_R32_SINT                     = 43
Global Const $DXGI_FORMAT_R24G8_TYPELESS               = 44
Global Const $DXGI_FORMAT_D24_UNORM_S8_UINT            = 45
Global Const $DXGI_FORMAT_R24_UNORM_X8_TYPELESS        = 46
Global Const $DXGI_FORMAT_X24_TYPELESS_G8_UINT         = 47
Global Const $DXGI_FORMAT_R8G8_TYPELESS                = 48
Global Const $DXGI_FORMAT_R8G8_UNORM                   = 49
Global Const $DXGI_FORMAT_R8G8_UINT                    = 50
Global Const $DXGI_FORMAT_R8G8_SNORM                   = 51
Global Const $DXGI_FORMAT_R8G8_SINT                    = 52
Global Const $DXGI_FORMAT_R16_TYPELESS                 = 53
Global Const $DXGI_FORMAT_R16_FLOAT                    = 54
Global Const $DXGI_FORMAT_D16_UNORM                    = 55
Global Const $DXGI_FORMAT_R16_UNORM                    = 56
Global Const $DXGI_FORMAT_R16_UINT                     = 57
Global Const $DXGI_FORMAT_R16_SNORM                    = 58
Global Const $DXGI_FORMAT_R16_SINT                     = 59
Global Const $DXGI_FORMAT_R8_TYPELESS                  = 60
Global Const $DXGI_FORMAT_R8_UNORM                     = 61
Global Const $DXGI_FORMAT_R8_UINT                      = 62
Global Const $DXGI_FORMAT_R8_SNORM                     = 63
Global Const $DXGI_FORMAT_R8_SINT                      = 64
Global Const $DXGI_FORMAT_A8_UNORM                     = 65
Global Const $DXGI_FORMAT_R1_UNORM                     = 66
Global Const $DXGI_FORMAT_R9G9B9E5_SHAREDEXP           = 67
Global Const $DXGI_FORMAT_R8G8_B8G8_UNORM              = 68
Global Const $DXGI_FORMAT_G8R8_G8B8_UNORM              = 69
Global Const $DXGI_FORMAT_BC1_TYPELESS                 = 70
Global Const $DXGI_FORMAT_BC1_UNORM                    = 71
Global Const $DXGI_FORMAT_BC1_UNORM_SRGB               = 72
Global Const $DXGI_FORMAT_BC2_TYPELESS                 = 73
Global Const $DXGI_FORMAT_BC2_UNORM                    = 74
Global Const $DXGI_FORMAT_BC2_UNORM_SRGB               = 75
Global Const $DXGI_FORMAT_BC3_TYPELESS                 = 76
Global Const $DXGI_FORMAT_BC3_UNORM                    = 77
Global Const $DXGI_FORMAT_BC3_UNORM_SRGB               = 78
Global Const $DXGI_FORMAT_BC4_TYPELESS                 = 79
Global Const $DXGI_FORMAT_BC4_UNORM                    = 80
Global Const $DXGI_FORMAT_BC4_SNORM                    = 81
Global Const $DXGI_FORMAT_BC5_TYPELESS                 = 82
Global Const $DXGI_FORMAT_BC5_UNORM                    = 83
Global Const $DXGI_FORMAT_BC5_SNORM                    = 84
Global Const $DXGI_FORMAT_B5G6R5_UNORM                 = 85
Global Const $DXGI_FORMAT_B5G5R5A1_UNORM               = 86
Global Const $DXGI_FORMAT_B8G8R8A8_UNORM               = 87
Global Const $DXGI_FORMAT_B8G8R8X8_UNORM               = 88
Global Const $DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM   = 89
Global Const $DXGI_FORMAT_B8G8R8A8_TYPELESS            = 90
Global Const $DXGI_FORMAT_B8G8R8A8_UNORM_SRGB          = 91
Global Const $DXGI_FORMAT_B8G8R8X8_TYPELESS            = 92
Global Const $DXGI_FORMAT_B8G8R8X8_UNORM_SRGB          = 93
Global Const $DXGI_FORMAT_BC6H_TYPELESS                = 94
Global Const $DXGI_FORMAT_BC6H_UF16                    = 95
Global Const $DXGI_FORMAT_BC6H_SF16                    = 96
Global Const $DXGI_FORMAT_BC7_TYPELESS                 = 97
Global Const $DXGI_FORMAT_BC7_UNORM                    = 98
Global Const $DXGI_FORMAT_BC7_UNORM_SRGB               = 99
Global Const $DXGI_FORMAT_AYUV                         = 100
Global Const $DXGI_FORMAT_Y410                         = 101
Global Const $DXGI_FORMAT_Y416                         = 102
Global Const $DXGI_FORMAT_NV12                         = 103
Global Const $DXGI_FORMAT_P010                         = 104
Global Const $DXGI_FORMAT_P016                         = 105
Global Const $DXGI_FORMAT_420_OPAQUE                   = 106
Global Const $DXGI_FORMAT_YUY2                         = 107
Global Const $DXGI_FORMAT_Y210                         = 108
Global Const $DXGI_FORMAT_Y216                         = 109
Global Const $DXGI_FORMAT_NV11                         = 110
Global Const $DXGI_FORMAT_AI44                         = 111
Global Const $DXGI_FORMAT_IA44                         = 112
Global Const $DXGI_FORMAT_P8                           = 113
Global Const $DXGI_FORMAT_A8P8                         = 114
Global Const $DXGI_FORMAT_B4G4R4A4_UNORM               = 115
Global Const $DXGI_FORMAT_FORCE_UINT                   = 0xFFFFFFFF

;# D2D1_ALPHA_MODE
Global Const $D2D1_ALPHA_MODE_UNKNOWN         = 0
Global Const $D2D1_ALPHA_MODE_PREMULTIPLIED   = 1
Global Const $D2D1_ALPHA_MODE_STRAIGHT        = 2
Global Const $D2D1_ALPHA_MODE_IGNORE          = 3

;# D2D1_ANTIALIAS_MODE
Global Const $D2D1_ANTIALIAS_MODE_PER_PRIMITIVE   = 0
Global Const $D2D1_ANTIALIAS_MODE_ALIASED         = 1

;# D2D1_ARC_SIZE
Global Const $D2D1_ARC_SIZE_SMALL   = 0
Global Const $D2D1_ARC_SIZE_LARGE   = 1

;# D2D1_BITMAP_INTERPOLATION_MODE
Global Const $D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR   = 0
Global Const $D2D1_BITMAP_INTERPOLATION_MODE_LINEAR             = 1

;# D2D1_INTERPOLATION_MODE
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_NEAREST_NEIGHBOR		= 0
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR					= 1
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_CUBIC					= 2
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_MULTI_SAMPLE_LINEAR	= 3
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_ANISOTROPIC			= 4
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_HIGH_QUALITY_CUBIC		= 5
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_FANT					= 6
Global Const $D2D1_INTERPOLATION_MODE_DEFINITION_MIPMAP_LINEAR			= 7

;# D2D1_CAP_STYLE
Global Const $D2D1_CAP_STYLE_FLAT       = 0
Global Const $D2D1_CAP_STYLE_SQUARE     = 1
Global Const $D2D1_CAP_STYLE_ROUND      = 2
Global Const $D2D1_CAP_STYLE_TRIANGLE   = 3

;# D2D1_COMBINE_MODE
Global Const $D2D1_COMBINE_MODE_UNION       = 0
Global Const $D2D1_COMBINE_MODE_INTERSECT   = 1
Global Const $D2D1_COMBINE_MODE_XOR         = 2
Global Const $D2D1_COMBINE_MODE_EXCLUDE     = 3

;# D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS
Global Const $D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE             = 0x00000000
Global Const $D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE   = 0x00000001

;# D2D1_DASH_STYLE
Global Const $D2D1_DASH_STYLE_SOLID          = 0
Global Const $D2D1_DASH_STYLE_DASH           = 1
Global Const $D2D1_DASH_STYLE_DOT            = 2
Global Const $D2D1_DASH_STYLE_DASH_DOT       = 3
Global Const $D2D1_DASH_STYLE_DASH_DOT_DOT   = 4
Global Const $D2D1_DASH_STYLE_CUSTOM         = 5

;# D2D1_DC_INITIALIZE_MODE
Global Const $D2D1_DC_INITIALIZE_MODE_COPY    = 0
Global Const $D2D1_DC_INITIALIZE_MODE_CLEAR   = 1

;# D2D1_DEBUG_LEVEL
Global Const $D2D1_DEBUG_LEVEL_NONE          = 0
Global Const $D2D1_DEBUG_LEVEL_ERROR         = 1
Global Const $D2D1_DEBUG_LEVEL_WARNING       = 2
Global Const $D2D1_DEBUG_LEVEL_INFORMATION   = 3

;# D2D1_DRAW_TEXT_OPTIONS
Global Const $D2D1_DRAW_TEXT_OPTIONS_NO_SNAP   = 0x00000001
Global Const $D2D1_DRAW_TEXT_OPTIONS_CLIP      = 0x00000002
Global Const $D2D1_DRAW_TEXT_OPTIONS_NONE      = 0x00000000

;# D2D1_EXTEND_MODE
Global Const $D2D1_EXTEND_MODE_CLAMP    = 0
Global Const $D2D1_EXTEND_MODE_WRAP     = 1
Global Const $D2D1_EXTEND_MODE_MIRROR   = 2

;# D2D1_FACTORY_TYPE
Global Const $D2D1_FACTORY_TYPE_SINGLE_THREADED   = 0
Global Const $D2D1_FACTORY_TYPE_MULTI_THREADED    = 1

;# D2D1_FEATURE_LEVEL
Global Const $D2D1_FEATURE_LEVEL_DEFAULT   = 0
Global Const $D2D1_FEATURE_LEVEL_9         = $D3D10_FEATURE_LEVEL_9_1
Global Const $D2D1_FEATURE_LEVEL_10        = $D3D10_FEATURE_LEVEL_10_0

;# D2D1_FIGURE_BEGIN
Global Const $D2D1_FIGURE_BEGIN_FILLED   = 0
Global Const $D2D1_FIGURE_BEGIN_HOLLOW   = 1

;# D2D1_FIGURE_END
Global Const $D2D1_FIGURE_END_OPEN     = 0
Global Const $D2D1_FIGURE_END_CLOSED   = 1

;# D2D1_FILL_MODE
Global Const $D2D1_FILL_MODE_ALTERNATE   = 0
Global Const $D2D1_FILL_MODE_WINDING     = 1

;# D2D1_GAMMA
Global Const $D2D1_GAMMA_2_2   = 0
Global Const $D2D1_GAMMA_1_0   = 1

;# D2D1_GEOMETRY_RELATION
Global Const $D2D1_GEOMETRY_RELATION_UNKNOWN        = 0
Global Const $D2D1_GEOMETRY_RELATION_DISJOINT       = 1
Global Const $D2D1_GEOMETRY_RELATION_IS_CONTAINED   = 2
Global Const $D2D1_GEOMETRY_RELATION_CONTAINS       = 3
Global Const $D2D1_GEOMETRY_RELATION_OVERLAP        = 4

;# D2D1_GEOMETRY_SIMPLIFICATION_OPTION
Global Const $D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES   = 0
Global Const $D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES              = 1

;# D2D1_LAYER_OPTIONS
Global Const $D2D1_LAYER_OPTIONS_NONE                       = 0x00000000
Global Const $D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE   = 0x00000001

;# D2D1_LINE_JOIN
Global Const $D2D1_LINE_JOIN_MITER            = 0
Global Const $D2D1_LINE_JOIN_BEVEL            = 1
Global Const $D2D1_LINE_JOIN_ROUND            = 2
Global Const $D2D1_LINE_JOIN_MITER_OR_BEVEL   = 3

;# D2D1_OPACITY_MASK_CONTENT
Global Const $D2D1_OPACITY_MASK_CONTENT_GRAPHICS              = 0
Global Const $D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL          = 1
Global Const $D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE   = 2

;# D2D1_PATH_SEGMENT
Global Const $D2D1_PATH_SEGMENT_NONE                    = 0x00000000
Global Const $D2D1_PATH_SEGMENT_FORCE_UNSTROKED         = 0x00000001
Global Const $D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN   = 0x00000002

;# D2D1_PRESENT_OPTIONS
Global Const $D2D1_PRESENT_OPTIONS_NONE              = 0x00000000
Global Const $D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS   = 0x00000001
Global Const $D2D1_PRESENT_OPTIONS_IMMEDIATELY       = 0x00000002

;# D2D1_RENDER_TARGET_TYPE
Global Const $D2D1_RENDER_TARGET_TYPE_DEFAULT     = 0
Global Const $D2D1_RENDER_TARGET_TYPE_SOFTWARE    = 1
Global Const $D2D1_RENDER_TARGET_TYPE_HARDWARE    = 2

;# D2D1_RENDER_TARGET_USAGE
Global Const $D2D1_RENDER_TARGET_USAGE_NONE                    = 0x00000000
Global Const $D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING   = 0x00000001
Global Const $D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE          = 0x00000002

;# D2D1_SWEEP_DIRECTION
Global Const $D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE   = 0
Global Const $D2D1_SWEEP_DIRECTION_CLOCKWISE           = 1

;# D2D1_TEXT_ANTIALIAS_MODE
Global Const $D2D1_TEXT_ANTIALIAS_MODE_DEFAULT     = 0
Global Const $D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE   = 1
Global Const $D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE   = 2
Global Const $D2D1_TEXT_ANTIALIAS_MODE_ALIASED     = 3

;# D2D1_WINDOW_STATE
Global Const $D2D1_WINDOW_STATE_NONE       = 0x0000000
Global Const $D2D1_WINDOW_STATE_OCCLUDED   = 0x0000001




;############################################################################################################
;# D2D1_BASETYPES
;############################################################################################################
Global Const $tagD2D1_MATRIX_3X2_F = "struct; float M11; float M12; float M21; float M22; float M31; float M32; endstruct;"
Global Const $tagD2D1_COLOR_F = "struct; float R; float G; float B; float A; endstruct;"
Global Const $tagD2D1_POINT_2F = "struct; float X; float Y; endstruct;"
Global Const $tagD2D1_POINT_2U = "struct; uint X; uint Y; endstruct;"
Global Const $tagD2D1_RECT_F = "struct; float Left; float Top; float Right; float Bottom; endstruct;"
Global Const $tagD2D1_RECT_U = "struct; uint Left; uint Top; uint Right; uint Bottom; endstruct;"
Global Const $tagD2D1_SIZE_F = "struct; float Width; float Height; endstruct;"
Global Const $tagD2D1_SIZE_U = "struct; uint Width; uint Height; endstruct;"




;############################################################################################################
;# D2D1_STRUCTURES
;############################################################################################################
Global Const $tagD2D1_ARC_SEGMENT = "struct; float X; float Y; float Width; float Height; float RotationAngle; uint SweepDirection; uint ArcSize; endstruct;"
Global Const $tagD2D1_BEZIER_SEGMENT = "struct; float X1; float Y1; float X2; float Y2; float X3; float Y3; endstruct;"
Global Const $tagD2D1_BITMAP_BRUSH_PROPERTIES = "struct; uint ExtendModeX; uint ExtendModeY; uint InterpolationMode; endstruct;"
Global Const $tagD2D1_PIXEL_FORMAT = "struct; uint PixelFormat; uint AlphaMode; endstruct;"
Global Const $tagD2D1_BITMAP_PROPERTIES = "struct; uint PixelFormat; uint AlphaMode; float DpiX; float DpiY; endstruct;"
Global Const $tagD2D1_BRUSH_PROPERTIES = "struct; float Opacity; float M11; float M12; float M21; float M22; float M31; float M32; endstruct;"
Global Const $tagD2D1_DRAWING_STATE_DESCRIPTION = "struct; uint AntialiasMode; uint TextAntialiasMode; uint64 Tag1; uint64 Tag2; float M11; float M12; float M21; float M22; float M31; float M32; endstruct;"
Global Const $tagD2D1_ELLIPSE = "struct; float X; float Y; float RadiusX; float RadiusY; endstruct;"
Global Const $tagD2D1_FACTORY_OPTIONS = "struct; uint DebugLevel; endstruct;"
Global Const $tagD2D1_GRADIENT_STOP = "struct; float Position; float R; float G; float B; float A; endstruct;"
Global Const $tagD2D1_HWND_RENDER_TARGET_PROPERTIES = "struct; hwnd Hwnd; uint Width; uint Height; uint PresentOptions; endstruct;"
Global Const $tagD2D1_LAYER_PARAMETERS = "struct; float Left; float Top; float Right; float Bottom; ptr GeometricMask; uint MaskAntialiasMode; float M11; float M12; float M21; float M22; float M31; float M32; float Opacity; ptr OpacityBrush; uint LayerOptions; endstruct;"
Global Const $tagD2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES = "struct; float X1; float Y1; float X2; float Y2; endstruct;"
Global Const $tagD2D1_QUADRATIC_BEZIER_SEGMENT = "struct; float X1; float Y1; float X2; float Y2; endstruct;"
Global Const $tagD2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES = "struct; float X; float Y; float OriginOffsetX; float OriginOffsetY; float RadiusX; float RadiusY; endstruct;"
Global Const $tagD2D1_RENDER_TARGET_PROPERTIES = "struct; uint Type; uint PixelFormat; uint AlphaMode; float DpiX; float DpiY; uint Usage; uint MinLevel; endstruct;"
Global Const $tagD2D1_ROUNDED_RECT = "struct; float Left; float Top; float Right; float Bottom; float RadiusX; float RadiusY; endstruct;"
Global Const $tagD2D1_STROKE_STYLE_PROPERTIES = "struct; uint StartCap; uint EndCap; uint DashCap; uint LineJoin; float MiterLimit; uint DashStyle; float DashOffset; endstruct;"
Global Const $tagD2D1_TRIANGLE = "struct; float X1; float Y1; float X2; float Y2; float X3; float Y3; endstruct;"





;############################################################################################################
;# D2D1_GUID
;############################################################################################################
Global Const $sIID_ID2D1Resource = "{2cd90691-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1Bitmap = "{a2296057-ea42-4099-983b-539fb6505426}"
Global Const $sIID_ID2D1GradientStopCollection = "{2cd906a7-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1Brush = "{2cd906a8-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1BitmapBrush = "{2cd906aa-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1SolidColorBrush = "{2cd906a9-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1LinearGradientBrush = "{2cd906ab-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1RadialGradientBrush = "{2cd906ac-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1StrokeStyle = "{2cd9069d-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1Geometry = "{2cd906a1-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1RectangleGeometry = "{2cd906a2-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1RoundedRectangleGeometry = "{2cd906a3-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1EllipseGeometry = "{2cd906a4-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1GeometryGroup = "{2cd906a6-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1TransformedGeometry = "{2cd906bb-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1SimplifiedGeometrySink = "{2cd9069e-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1GeometrySink = "{2cd9069f-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1TessellationSink = "{2cd906c1-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1PathGeometry = "{2cd906a5-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1Mesh = "{2cd906c2-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1Layer = "{2cd9069b-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1DrawingStateBlock = "{28506e39-ebf6-46a1-bb47-fd85565ab957}"
Global Const $sIID_ID2D1RenderTarget = "{2cd90694-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1BitmapRenderTarget = "{2cd90695-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1HwndRenderTarget = "{2cd90698-12e2-11dc-9fed-001143a055f9}"
Global Const $sIID_ID2D1GdiInteropRenderTarget = "{e0db51c3-6f77-4bae-b3d5-e47509b35838}"
Global Const $sIID_ID2D1DCRenderTarget = "{1c51bc64-de61-46fd-9899-63a5d8f03950}"
Global Const $sIID_ID2D1Factory = "{06152247-6f50-465a-9245-118bfd3b6007}"




;############################################################################################################
;# D2D1_InterfaceDescription
;############################################################################################################
Global Const $tagID2D1Resource = "GetFactory none(ptr*);"

Global Const $tagID2D1Bitmap = $tagID2D1Resource & _
		"GetSize ptr(struct*);" & _
		"GetPixelSize ptr(struct*);" & _
		"GetPixelFormat ptr(struct*);" & _
		"GetDpi none(float*;float*);" & _
		"CopyFromBitmap hresult(struct*;struct*;struct*);" & _
		"CopyFromRenderTarget hresult(struct*;struct*;struct*);" & _
		"CopyFromMemory hresult(struct*;struct*;uint);"

Global Const $tagID2D1GradientStopCollection = $tagID2D1Resource & _
		"GetGradientStopCount uint();" & _
		"GetGradientStops none(struct*;uint);" & _
		"GetColorInterpolationGamma uint();" & _
		"GetExtendMode uint();"

Global Const $tagID2D1Brush = $tagID2D1Resource & _
		"SetOpacity none(float);" & _
		"SetTransform none(struct*);" & _
		"GetOpacity float();" & _
		"GetTransform none(struct*);"

Global Const $tagID2D1BitmapBrush = $tagID2D1Brush & _
		"SetExtendModeX none(uint);" & _
		"SetExtendModeY none(uint);" & _
		"SetInterpolationMode none(uint);" & _
		"SetBitmap none(struct*);" & _
		"GetExtendModeX uint();" & _
		"GetExtendModeY uint();" & _
		"GetInterpolationMode uint();" & _
		"GetBitmap none(ptr*);"

Global Const $tagID2D1SolidColorBrush = $tagID2D1Brush & _
		"SetColor none(struct*);" & _
		"GetColor ptr(struct*);"

Global Const $tagID2D1LinearGradientBrush = $tagID2D1Brush & _
		"SetStartPoint none(struct);" & _
		"SetEndPoint none(struct);" & _
		"GetStartPoint ptr(struct*);" & _
		"GetEndPoint ptr(struct*);" & _
		"GetGradientStopCollection none(ptr*);"

Global Const $tagID2D1RadialGradientBrush = $tagID2D1Brush & _
		"SetCenter none(struct);" & _
		"SetGradientOriginOffset none(struct);" & _
		"SetRadiusX none(float);" & _
		"SetRadiusY none(float);" & _
		"GetCenter ptr(struct*);" & _
		"GetGradientOriginOffset ptr(struct*);" & _
		"GetRadiusX float();" & _
		"GetRadiusY float();" & _
		"GetGradientStopCollection none(ptr*);"

Global Const $tagID2D1StrokeStyle = $tagID2D1Resource & _
		"GetStartCap uint();" & _
		"GetEndCap uint();" & _
		"GetDashCap uint();" & _
		"GetMiterLimit float();" & _
		"GetLineJoin uint();" & _
		"GetDashOffset float();" & _
		"GetDashStyle uint();" & _
		"GetDashesCount uint();" & _
		"GetDashes none(struct*;uint);"

Global Const $tagID2D1Geometry = $tagID2D1Resource & _
		"GetBounds hresult(struct*;struct*);" & _
		"GetWidenedBounds hresult(float;struct*;struct*;float;struct*);" & _
		"StrokeContainsPoint hresult(struct;float;struct*;struct*;float;bool*);" & _
		"FillContainsPoint hresult(struct;struct*;float;bool*);" & _
		"CompareWithGeometry hresult(struct*;struct*;float;uint*);" & _
		"Simplify hresult(uint;struct*;float;struct*);" & _
		"Tessellate hresult(struct*;float;struct*);" & _
		"CombineWithGeometry hresult(struct*;uint;struct*;float;struct*);" & _
		"Outline hresult(struct*;float;struct*);" & _
		"ComputeArea hresult(struct*;float;float*);" & _
		"ComputeLength hresult(struct*;float;float*);" & _
		"ComputePointAtLength hresult(float;struct*;float;struct*;struct*);" & _
		"Widen hresult(float;struct*;struct*;float;struct*);"

Global Const $tagID2D1RectangleGeometry = $tagID2D1Geometry & _
		"GetRect none(struct*);"

Global Const $tagID2D1RoundedRectangleGeometry = $tagID2D1Geometry & _
		"GetRoundedRect none(struct*);"

Global Const $tagID2D1EllipseGeometry = $tagID2D1Geometry & _
		"GetEllipse none(struct*);"

Global Const $tagID2D1GeometryGroup = $tagID2D1Geometry & _
		"GetFillMode uint();" & _
		"GetSourceGeometryCount uint();" & _
		"GetSourceGeometries none(struct*;uint);"

Global Const $tagID2D1TransformedGeometry = $tagID2D1Geometry & _
		"GetSourceGeometry none(ptr*);" & _
		"GetTransform none(struct*);"

Global Const $tagID2D1SimplifiedGeometrySink = "SetFillMode none(uint);" & _
		"SetSegmentFlags none(uint);" & _
		"BeginFigure none(struct;uint);" & _
		"AddLines none(struct*;uint);" & _
		"AddBeziers none(struct*;uint);" & _
		"EndFigure none(uint);" & _
		"Close hresult();"

Global Const $tagID2D1GeometrySink = $tagID2D1SimplifiedGeometrySink & _
		"AddLine none(struct);" & _
		"AddBezier none(struct*);" & _
		"AddQuadraticBezier none(struct*);" & _
		"AddQuadraticBeziers none(struct*;uint);" & _
		"AddArc none(struct*);"

Global Const $tagID2D1TessellationSink = "AddTriangles none(struct*;uint);" & _
		"Close hresult();"

Global Const $tagID2D1PathGeometry = $tagID2D1Geometry & _
		"Open hresult(ptr*);" & _
		"Stream hresult(struct*);" & _
		"GetSegmentCount hresult(uint*);" & _
		"GetFigureCount hresult(uint*);"

Global Const $tagID2D1Mesh = $tagID2D1Resource & _
		"Open hresult(ptr*);"

Global Const $tagID2D1Layer = $tagID2D1Resource & _
		"GetSize ptr(struct*);"

Global Const $tagID2D1DrawingStateBlock = $tagID2D1Resource & _
		"GetDescription none(struct*);" & _
		"SetDescription none(struct*);" & _
		"SetTextRenderingParams none(struct*);" & _
		"GetTextRenderingParams none(ptr*);"

Global Const $tagID2D1RenderTarget = $tagID2D1Resource & _
		"CreateBitmap hresult(struct;struct*;uint;struct*;ptr*);" & _
		"CreateBitmapFromWicBitmap hresult(struct*;struct*;ptr*);" & _
		"CreateSharedBitmap hresult(struct*;struct*;struct*;ptr*);" & _
		"CreateBitmapBrush hresult(struct*;struct*;struct*;ptr*);" & _
		"CreateSolidColorBrush hresult(struct*;struct*;ptr*);" & _
		"CreateGradientStopCollection hresult(struct*;uint;uint;uint;ptr*);" & _
		"CreateLinearGradientBrush hresult(struct*;struct*;struct*;ptr*);" & _
		"CreateRadialGradientBrush hresult(struct*;struct*;struct*;ptr*);" & _
		"CreateCompatibleRenderTarget hresult(struct*;struct*;struct*;uint;ptr*);" & _
		"CreateLayer hresult(struct*;ptr*);" & _
		"CreateMesh hresult(ptr*);" & _
		"DrawLine none(struct;struct;struct*;float;struct*);" & _
		"DrawRectangle none(struct*;struct*;float;struct*);" & _
		"FillRectangle none(struct*;struct*);" & _
		"DrawRoundedRectangle none(struct*;struct*;float;struct*);" & _
		"FillRoundedRectangle none(struct*;struct*);" & _
		"DrawEllipse none(struct*;struct*;float;struct*);" & _
		"FillEllipse none(struct*;struct*);" & _
		"DrawGeometry none(struct*;struct*;float;struct*);" & _
		"FillGeometry none(struct*;struct*;struct*);" & _
		"FillMesh none(struct*;struct*);" & _
		"FillOpacityMask none(struct*;struct*;uint;struct*;struct*);" & _
		"DrawBitmap none(struct*;struct*;float;uint;struct*);" & _
		"DrawText none(wstr;uint;struct*;struct*;struct*;uint;uint);" & _
		"DrawTextLayout none(struct;struct*;struct*;uint);" & _
		"DrawGlyphRun none(struct;struct*;struct*;uint);" & _
		"SetTransform none(struct*);" & _
		"GetTransform none(struct*);" & _
		"SetAntialiasMode none(uint);" & _
		"GetAntialiasMode uint();" & _
		"SetTextAntialiasMode none(uint);" & _
		"GetTextAntialiasMode uint();" & _
		"SetTextRenderingParams none(struct*);" & _
		"GetTextRenderingParams none(ptr*);" & _
		"SetTags none(uint64;uint64);" & _
		"GetTags none(uint64*;uint64*);" & _
		"PushLayer none(struct*;struct*);" & _
		"PopLayer none();" & _
		"Flush hresult(uint64*;uint64*);" & _
		"SaveDrawingState none(struct*);" & _
		"RestoreDrawingState none(struct*);" & _
		"PushAxisAlignedClip none(struct*;uint);" & _
		"PopAxisAlignedClip none();" & _
		"Clear none(struct*);" & _
		"BeginDraw none();" & _
		"EndDraw hresult(uint64*;uint64*);" & _
		"GetPixelFormat ptr(struct*);" & _
		"SetDpi none(float;float);" & _
		"GetDpi none(float*;float*);" & _
		"GetSize ptr(struct*);" & _
		"GetPixelSize ptr(struct*);" & _
		"GetMaximumBitmapSize uint();" & _
		"IsSupported bool(struct*);"

Global Const $tagID2D1BitmapRenderTarget = $tagID2D1RenderTarget & _
		"GetBitmap hresult(ptr*);"

Global Const $tagID2D1HwndRenderTarget = $tagID2D1RenderTarget & _
		"CheckWindowState uint();" & _
		"Resize hresult(struct*);" & _
		"GetHwnd hwnd();"

Global Const $tagID2D1GdiInteropRenderTarget = "GetDC hresult(uint;handle*);" & _
		"ReleaseDC hresult(struct*);"

Global Const $tagID2D1DCRenderTarget = $tagID2D1RenderTarget & _
		"BindDC hresult(handle;struct*);"

Global Const $tagID2D1Factory = "ReloadSystemMetrics hresult();" & _
		"GetDesktopDpi none(float*;float*);" & _
		"CreateRectangleGeometry hresult(struct*;ptr*);" & _
		"CreateRoundedRectangleGeometry hresult(struct*;ptr*);" & _
		"CreateEllipseGeometry hresult(struct*;ptr*);" & _
		"CreateGeometryGroup hresult(uint;struct*;uint;ptr*);" & _
		"CreateTransformedGeometry hresult(struct*;struct*;ptr*);" & _
		"CreatePathGeometry hresult(ptr*);" & _
		"CreateStrokeStyle hresult(struct*;struct*;uint;ptr*);" & _
		"CreateDrawingStateBlock hresult(struct*;struct*;ptr*);" & _
		"CreateWicBitmapRenderTarget hresult(struct*;struct*;ptr*);" & _
		"CreateHwndRenderTarget hresult(struct*;struct*;ptr*);" & _
		"CreateDxgiSurfaceRenderTarget hresult(struct*;struct*;ptr*);" & _
		"CreateDCRenderTarget hresult(struct*;ptr*);"