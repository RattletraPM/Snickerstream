#include-once
#include <Direct2DConstants.au3>
#include <WinApi.au3>

; #INDEX# =======================================================================================================================
; Title .........: Direct2D
; AutoIt Version : 3.3.7.20++
; Language ......: English
; Description ...: Functions that assist with Direct2D, an API that provides Win32 developers with the ability to
;                  perform 2-D graphics rendering tasks with superior performance and visual quality.
;                  Direct2D is a hardware-accelerated, immediate-mode 2-D graphics API that provides high performance
;                  and high-quality rendering for 2-D geometry, bitmaps, and text.
;                  The Direct2D API is designed to interoperate with existing code that uses GDI, GDI+, or Direct3D.
; Author ........: trancexx, Eukalyptus
; Modified ......:
; Dll ...........: d2d1.dll
; ===============================================================================================================================

Global Const $__g_hD2D1DLL = DllOpen("d2d1.dll")



;#######################################################################################################################################################################
;# ID2D1Bitmap
;#######################################################################################################################################################################
#cs   ID2D1Bitmap
	Method ...: CopyFromBitmap (struct*, struct*, struct*)
	Info .....:     Copies the specified region from the specified bitmap into the current bitmap.
	Param ....:         $tDestPoint  [in, optional]  <$tagD2D1_POINT_2U>  In the current bitmap, the upper-left corner of the area to which the region specified by srcRect is copied.
	Param ....:         $oBitmap     [in]            <ID2D1Bitmap>        The bitmap to copy from.
	Param ....:         $tSrcRect    [in, optional]  <$tagD2D1_RECT_U>    The area of bitmap to copy.

	Method ...: CopyFromRenderTarget (struct*, struct*, struct*)
	Info .....:     Copies the specified region from the specified render target into the current bitmap.
	Param ....:         $tDestPoint     [in, optional]  <$tagD2D1_POINT_2U>  In the current bitmap, the upper-left corner of the area to which the region specified by srcRect is copied.
	Param ....:         $oRenderTarget  [in]            <ID2D1RenderTarget>  The render target that contains the region to copy.
	Param ....:         $tSrcRect       [in, optional]  <$tagD2D1_RECT_U>    The area of renderTarget to copy.

	Method ...: CopyFromMemory (struct*, struct*, uint)
	Info .....:     Copies the specified region from memory into the current bitmap.
	Param ....:         $tDstRect  [in, optional]  <$tagD2D1_RECT_U>  In the current bitmap, the upper-left corner of the area to which the region specified by srcRect is copied.
	Param ....:         $pSrcData  [in]            <ptr>              The data to copy.
	Param ....:         $iPitch    [in]            <uint>             The stride, or pitch, of the source bitmap stored in srcData. The stride is the byte count of a scanline (one row of pixels in memory). The stride can be computed from the following formula: pixel width * bytes per pixel + memory padding.

	Method ...: GetDpi (float*, float*)
	Info .....:     Return the dots per inch (DPI) of the bitmap.
	Param ....:         $fDpiX  [out]  <float>  The horizontal DPI of the image. You must allocate storage for this parameter.
	Param ....:         $fDpiY  [out]  <float>  The vertical DPI of the image. You must allocate storage for this parameter.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format and alpha mode of the bitmap.
	Param ....:         $tD2D1_PIXEL_FORMAT  [OUT]  <$tagD2D1_PIXEL_FORMAT>

	Method ...: GetPixelSize (struct*)
	Info .....:     Returns the size, in device-dependent units (pixels), of the bitmap.
	Param ....:         $tD2D1_SIZE_U  [OUT]  <$tagD2D1_SIZE_U>

	Method ...: GetSize (struct*)
	Info .....:     Returns the size, in device-independent pixels (DIPs), of the bitmap.
	Param ....:         $tD2D1_SIZE_F  [OUT]  <$tagD2D1_SIZE_F>
#ce
; _D2D_Bitmap_GetSize
; _D2D_Bitmap_GetPixelSize
; _D2D_Bitmap_GetPixelFormat
; _D2D_Bitmap_GetDpi
; _D2D_Bitmap_CopyFromBitmap
; _D2D_Bitmap_CopyFromRenderTarget
; _D2D_Bitmap_CopyFromMemory



;#######################################################################################################################################################################
;# ID2D1BitmapBrush
;#######################################################################################################################################################################
#cs   ID2D1BitmapBrush
	Method ...: GetBitmap (ptr*)
	Info .....:     Gets the bitmap source that this brush uses to paint.
	Param ....:         $oBitmap  [out]  <ID2D1Bitmap>  When this method returns, contains the address to a pointer to the bitmap with which this brush paints.

	Method ...: GetExtendModeX ()
	Info .....:     Gets the method by which the brush horizontally tiles those areas that extend past its bitmap.
	Param ....:         This method has no parameters.

	Method ...: GetExtendModeY ()
	Info .....:     Gets the method by which the brush vertically tiles those areas that extend past its bitmap.
	Param ....:         This method has no parameters.

	Method ...: GetInterpolationMode ()
	Info .....:     Gets the interpolation method used when the brush bitmap is scaled or rotated.
	Param ....:         This method has no parameters.

	Method ...: SetBitmap (struct*)
	Info .....:     Specifies the bitmap source that this brush uses to paint.
	Param ....:         $oBitmap  [in]  <ID2D1Bitmap>  The bitmap source used by the brush.

	Method ...: SetExtendModeX (uint)
	Info .....:     Specifies how the brush horizontally tiles those areas that extend past its bitmap.
	Param ....:         $iExtendModeX  [in]  <$D2D1_EXTEND_MODE>  A value that specifies how the brush horizontally tiles those areas that extend past its bitmap.

	Method ...: SetExtendModeY (uint)
	Info .....:     Specifies how the brush vertically tiles those areas that extend past its bitmap.
	Param ....:         $iExtendModeY  [in]  <$D2D1_EXTEND_MODE>  A value that specifies how the brush vertically tiles those areas that extend past its bitmap.

	Method ...: SetInterpolationMode (uint)
	Info .....:     Specifies the interpolation mode used when the brush bitmap is scaled or rotated.
	Param ....:         $iInterpolationMode  [in]  <$D2D1_BITMAP_INTERPOLATION_MODE>  The interpolation mode used when the brush bitmap is scaled or rotated.
#ce
; _D2D_BitmapBrush_SetExtendModeX
; _D2D_BitmapBrush_SetExtendModeY
; _D2D_BitmapBrush_SetInterpolationMode
; _D2D_BitmapBrush_SetBitmap
; _D2D_BitmapBrush_GetExtendModeX
; _D2D_BitmapBrush_GetExtendModeY
; _D2D_BitmapBrush_GetInterpolationMode
; _D2D_BitmapBrush_GetBitmap



;#######################################################################################################################################################################
;# ID2D1BitmapRenderTarget
;#######################################################################################################################################################################
#cs   ID2D1BitmapRenderTarget
	Method ...: GetBitmap (ptr*)
	Info .....:     Retrieves the bitmap for this render target. The returned bitmap can be used for drawing operations.
	Param ....:         $oBitmap  [out]  <ID2D1Bitmap>  When this method returns, contains the address of a pointer to the bitmap for this render target. This bitmap can be used for drawing operations.
#ce

; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_BitmapRenderTarget_GetBitmap
; Description ...: Retrieves the bitmap for this render target. The returned bitmap can be used for drawing operations.
; Syntax ........: _D2D_BitmapRenderTarget_GetBitmap($oIBitmapRenderTarget)
; Parameters ....: $oIBitmapRenderTarget   -  An ID2D1BitmapRenderTarget Object.
; Return values .: Success - An ID2D1Bitmap object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The DPI for the ID2D1Bitmap obtained from GetBitmap will be the DPI of the ID2D1BitmapRenderTarget when the render
;                  target was created. Changing the DPI of the ID2D1BitmapRenderTarget by calling SetDpi doesn't affect the DPI of
;                  the bitmap, even if SetDpi is called before GetBitmap. Using SetDpi to change the DPI of the ID2D1BitmapRenderTarget
;                  does affect how contents are rendered into the bitmap: it just doesn't affect the DPI of the bitmap retrieved
;                  by GetBitmap.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_BitmapRenderTarget_GetBitmap($oIBitmapRenderTarget)
	If Not IsObj($oIBitmapRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pBitmap
	Local $iHResult = $oIBitmapRenderTarget.GetBitmap($pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 1, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_ID2D1Bitmap, $tagID2D1Bitmap)
	If Not IsObj($oBitmap) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oBitmap
EndFunc   ;==>_D2D_BitmapRenderTarget_GetBitmap



;#######################################################################################################################################################################
;# ID2D1Brush
;#######################################################################################################################################################################
#cs   ID2D1Brush
	Method ...: GetOpacity ()
	Info .....:     Gets the degree of opacity of this brush.
	Param ....:         This method has no parameters.

	Method ...: GetTransform (struct*)
	Info .....:     Gets the transform applied to this brush.
	Param ....:         $tTransform  [out]  <$tagD2D1_MATRIX_3X2_F>  The transform applied to this brush.

	Method ...: SetOpacity (float)
	Info .....:     Sets the degree of opacity of this brush.
	Param ....:         $fOpacity  [in]  <float>  A value between zero and 1 that indicates the opacity of the brush. This value is a constant multiplier that linearly scales the alpha value of all pixels filled by the brush. The opacity values are clamped in the range 0–1 before they are multipled together.

	Method ...: SetTransform (struct*)
	Info .....:     Sets the transformation applied to the brush.
	Param ....:         $tTransform  [in]  <$tagD2D1_MATRIX_3X2_F>  The transformation to apply to this brush.
#ce
; _D2D_Brush_SetOpacity
; _D2D_Brush_SetTransform
; _D2D_Brush_GetOpacity
; _D2D_Brush_GetTransform



;#######################################################################################################################################################################
;# ID2D1DCRenderTarget
;#######################################################################################################################################################################
#cs   ID2D1DCRenderTarget
	Method ...: BindDC (handle, struct*)
	Info .....:     Binds the render target to the device context to which it issues drawing commands.
	Param ....:         $hHDC       [in]  <hwnd>      The device context to which the render target issues drawing commands.
	Param ....:         $tPSubRect  [in]  <$tagRECT>  The dimensions of the handle to a device context (HDC) to which the render target is bound.
#ce
; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DCRenderTarget_BindDC
; Description ...:  Binds the render target to the device context to which it issues drawing commands.
; Syntax ........: _D2D_DCRenderTarget_BindDC($oIDCRenderTarget, $hDC, $tSubRect)
; Parameters ....: $oIDCRenderTarget - This ID2D1DCRenderTarget object
;                  $hDC              - The device context to which the render target issues drawing commands.
;                  $tSubRect         - A $tagRECT structure. The dimensions of the handle to a device context (HDC) to which the render target
;                                      is bound.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Before you can render with the DC render target, you must use its BindDC method to associate it with a GDI DC. You do this
;                  each time you use a different DC, or the size of the area you want to draw to changes.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DCRenderTarget_BindDC($oIDCRenderTarget, $hDC, $tSubRect)
	If Not IsObj($oIDCRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsDllStruct($tSubRect) And Not $tSubRect Then Return SetError($D2DERR_PARAM, 1, False)

	Local $iHResult = $oIDCRenderTarget.BindDC($hDC, $tSubRect)
	If $iHResult Then Return SetError($iHResult, 2, False)

	Return True
EndFunc   ;==>_D2D_DCRenderTarget_BindDC



;#######################################################################################################################################################################
;# ID2D1DrawingStateBlock
;#######################################################################################################################################################################
#cs   ID2D1DrawingStateBlock
	Method ...: GetDescription (struct*)
	Info .....:     Retrieves the antialiasing mode, transform, and tags portion of the drawing state.
	Param ....:         $tStateDescription  [out]  <$tagD2D1_DRAWING_STATE_DESCRIPTION>  When this method returns, contains the antialiasing mode, transform, and tags portion of the drawing state. You must allocate storage for this parameter.

	Method ...: GetTextRenderingParams (ptr*)
	Info .....:     Retrieves the text-rendering configuration of the drawing state.
	Param ....:         $oTextRenderingParams  [out]  <IDWriteRenderingParams>  When this method returns, contains the address of a pointer to an object that describes the text-rendering configuration of the drawing state.

	Method ...: SetDescription (struct*)
	Info .....:     Specifies the antialiasing mode, transform, and tags portion of the drawing state.
	Param ....:         $tStateDescription  [in]  <$tagD2D1_DRAWING_STATE_DESCRIPTION>  The antialiasing mode, transform, and tags portion of the drawing state.

	Method ...: SetTextRenderingParams (struct*)
	Info .....:     Specifies the text-rendering configuration of the drawing state.
	Param ....:         $oTextRenderingParams  [optional]  <IDWriteRenderingParams>  The text-rendering configuration of the drawing state, or NULL to use default settings.
#ce
; _D2D_DrawingStateBlock_GetDescription
; _D2D_DrawingStateBlock_SetDescription
; _D2D_DrawingStateBlock_SetTextRenderingParams
; _D2D_DrawingStateBlock_GetTextRenderingParams



;#######################################################################################################################################################################
;# ID2D1EllipseGeometry
;#######################################################################################################################################################################
#cs   ID2D1EllipseGeometry
	Method ...: GetEllipse (struct*)
	Info .....:     Gets the structure that describes this ellipse geometry.
	Param ....:         $tEllipse  [out]  <$tagD2D1_ELLIPSE>  When this method returns, contains the that describes the size and position of the ellipse. You must allocate storage for this parameter.
#ce
; _D2D_EllipseGeometry_GetEllipse



;#######################################################################################################################################################################
;# ID2D1Factory
;#######################################################################################################################################################################
#cs   ID2D1Factory
	Method ...: CreateDCRenderTarget (struct*, ptr*)
	Info .....:     Creates a render target that draws to a Windows Graphics Device Interface (GDI) device context.
	Param ....:         $tRenderTargetProperties  [in]   <$tagD2D1_RENDER_TARGET_PROPERTIES>  The rendering mode, pixel format, remoting options, DPI information, and the minimum DirectX support required for hardware rendering. To enable the device context (DC) render target to work with GDI, set the DXGI format to <a class="mtps-external-link" href="http://msdn.microsoft.com/en-us/library/bb173059(VS.85).aspx">DXGI_FORMAT_B8G8R8A8_UNORM</a> and the alpha mode to or D2D1_ALPHA_MODE_IGNORE. For more information about pixel formats, see .
	Param ....:         $oDcRenderTarget          [out]  <ID2D1DCRenderTarget>                When this method returns, dcRenderTarget contains the address of the pointer to the created by the method.

	Method ...: CreateDrawingStateBlock (struct*, struct*, ptr*)
	Info .....:     Creates an that can be used with the and methods of a render target.
	Param ....:         $tDrawingStateDescription  [in, optional]  <$tagD2D1_DRAWING_STATE_DESCRIPTION>  A structure that contains antialiasing, transform, and tags information.
	Param ....:         $oTextRenderingParams      [in, optional]  <IDWriteRenderingParams>              Optional text parameters that indicate how text should be rendered.
	Param ....:         $oDrawingStateBlock        [out]           <ID2D1DrawingStateBlock>              When this method returns, contains the address of a pointer to the new drawing state block created by this method.

	Method ...: CreateDxgiSurfaceRenderTarget (struct*, struct*, ptr*)
	Info .....:     Creates a render target that draws to a DirectX Graphics Infrastructure (DXGI) surface.
	Param ....:         $oDxgiSurface             [in]   <IDXGISurface>                       The IDXGISurface to which the render target will draw.
	Param ....:         $tRenderTargetProperties  [in]   <$tagD2D1_RENDER_TARGET_PROPERTIES>  The rendering mode, pixel format, remoting options, DPI information, and the minimum DirectX support required for hardware rendering. For information about supported pixel formats, see .
	Param ....:         $oRenderTarget            [out]  <ID2D1RenderTarget>                  When this method returns, contains the address of the pointer to the object created by this method.

	Method ...: CreateEllipseGeometry (struct*, ptr*)
	Info .....:     Creates an .
	Param ....:         $tEllipse          [in]   <$tagD2D1_ELLIPSE>      A value that describes the center point, x-radius, and y-radius of the ellipse geometry.
	Param ....:         $oEllipseGeometry  [out]  <ID2D1EllipseGeometry>  When this method returns, contains the address of the pointer to the ellipse geometry created by this method.

	Method ...: CreateGeometryGroup (uint, struct*, uint, ptr*)
	Info .....:     Creates an , which is an object that holds other geometries.
	Param ....:         $iFillMode         [in]   <$D2D1_FILL_MODE>     A value that specifies the rule that a composite shape uses to determine whether a given point is part of the geometry.
	Param ....:         $oGeometries       [in]   <ID2D1Geometry>       An array containing the geometry objects to add to the geometry group. The number of elements in this array is indicated by the geometriesCount parameter.
	Param ....:         $iGeometriesCount  [in]   <uint>                The number of elements in geometries.
	Param ....:         $oGeometryGroup    [out]  <ID2D1GeometryGroup>  When this method returns, contains the address of a pointer to the geometry group created by this method.

	Method ...: CreateHwndRenderTarget (struct*, struct*, ptr*)
	Info .....:     Creates an , a render target that renders to a window.
	Param ....:         $tRenderTargetProperties      [in]   <$tagD2D1_RENDER_TARGET_PROPERTIES>       The rendering mode, pixel format, remoting options, DPI information, and the minimum DirectX support required for hardware rendering. For information about supported pixel formats, see .
	Param ....:         $tHwndRenderTargetProperties  [in]   <$tagD2D1_HWND_RENDER_TARGET_PROPERTIES>  The window handle, initial size (in pixels), and present options.
	Param ....:         $oHwndRenderTarget            [out]  <ID2D1HwndRenderTarget>                   When this method returns, contains the address of the pointer to the object created by this method.

	Method ...: CreatePathGeometry (ptr*)
	Info .....:     Creates an empty .
	Param ....:         $oPathGeometry  [out]  <ID2D1PathGeometry>  When this method returns, contains the address to a pointer to the path geometry created by this method.

	Method ...: CreateRectangleGeometry (struct*, ptr*)
	Info .....:     Creates an .
	Param ....:         $tRectangle          [in]   <$tagD2D1_RECT_F>         The coordinates of the rectangle geometry.
	Param ....:         $oRectangleGeometry  [out]  <ID2D1RectangleGeometry>  When this method returns, contains the address of the pointer to the rectangle geometry created by this method.

	Method ...: CreateRoundedRectangleGeometry (struct*, ptr*)
	Info .....:     Creates an .
	Param ....:         $tRoundedRectangle          [in]   <$tagD2D1_ROUNDED_RECT>          The coordinates and corner radii of the rounded rectangle geometry.
	Param ....:         $oRoundedRectangleGeometry  [out]  <ID2D1RoundedRectangleGeometry>  When this method returns, contains the address of the pointer to the rounded rectangle geometry created by this method.

	Method ...: CreateStrokeStyle (struct*, struct*, uint, ptr*)
	Info .....:     Creates an that describes start cap, dash pattern, and other features of a stroke.
	Param ....:         $tStrokeStyleProperties  [in]            <$tagD2D1_STROKE_STYLE_PROPERTIES>  A structure that describes the stroke's line cap, dash offset, and other details of a stroke.
	Param ....:         $fDashes                 [in, optional]  <float>                             An array whose elements are set to the length of each dash and space in the dash pattern. The first element sets the length of a dash, the second element sets the length of a space, the third element sets the length of a dash, and so on. The length of each dash and space in the dash pattern is the product of the element value in the array and the stroke width.
	Param ....:         $iDashesCount            [in]            <uint>                              The number of elements in the dashes array.
	Param ....:         $oStrokeStyle            [out]           <ID2D1StrokeStyle>                  When this method returns, contains the address of the pointer to the stroke style created by this method.

	Method ...: CreateTransformedGeometry (struct*, struct*, ptr*)
	Info .....:     Transforms the specified geometry and stores the result as an object.
	Param ....:         $oSourceGeometry       [in]            <ID2D1Geometry>             The geometry to transform.
	Param ....:         $tTransform            [in, optional]  <$tagD2D1_MATRIX_3X2_F>     The transformation to apply.
	Param ....:         $oTransformedGeometry  [out]           <ID2D1TransformedGeometry>  When this method returns, contains the address of the pointer to the new transformed geometry object. The transformed geometry stores the result of transforming sourceGeometry by transform.

	Method ...: CreateWicBitmapRenderTarget (struct*, struct*, ptr*)
	Info .....:     Creates a render target that renders to a Microsoft Windows Imaging Component (WIC) bitmap.
	Param ....:         $oTarget                  [in]   <IWICBitmap>                         The bitmap that receives the rendering output of the render target.
	Param ....:         $tRenderTargetProperties  [in]   <$tagD2D1_RENDER_TARGET_PROPERTIES>  The rendering mode, pixel format, remoting options, DPI information, and the minimum DirectX support required for hardware rendering. For information about supported pixel formats, see .
	Param ....:         $oRenderTarget            [out]  <ID2D1RenderTarget>                  When this method returns, contains the address of the pointer to the object created by this method.

	Method ...: GetDesktopDpi (float*, float*)
	Info .....:     Retrieves the current desktop dots per inch (DPI). To refresh this value, call .
	Param ....:         $fDpiX  [out]  <float>  When this method returns, contains the horizontal DPI of the desktop. You must allocate storage for this parameter.
	Param ....:         $fDpiY  [out]  <float>  When this method returns, contains the vertical DPI of the desktop. You must allocate storage for this parameter.

	Method ...: ReloadSystemMetrics ()
	Info .....:     Forces the factory to refresh any system defaults that it might have changed since factory creation.
	Param ....:         This method has no parameters.
#ce
; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_Create
; Description ...: Creates a factory object that can be used to create Direct2D resources.
; Syntax ........: _D2D_Factory_Create()
; Parameters ....:
; Return values .: Success - An ID2D1Factory Object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The ID2D1Factory interface is the starting point for using Direct2D; it's what you use to create other Direct2D
;                  resources that you can use to draw or describe shapes. A factory defines a set of Create Resource methods that can
;                  produce the following drawing resources:
;                          .Render targets: objects that render drawing commands.
;                          .Drawing state blocks: objects that store drawing state information, such as the current transformation and antialiasing mode.
;                          .Geometries: objects that represent simple and potentially complex shapes.
;                  You should retain the ID2D1Factory instance for as long as you use Direct2D resources; in general, you shouldn't need
;                  to recreate it when the application is running.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_Create()
	Local $tIID_ID2D1Factory = _WinAPI_GUIDFromString($sIID_ID2D1Factory)

	Local $aResult = DllCall($__g_hD2D1DLL, "int", "D2D1CreateFactory", "uint", 0, "struct*", $tIID_ID2D1Factory, "uint*", 0, "ptr*", 0)
	If @error Then Return SetError($D2DERR_UFAIL, 1, False)
	If $aResult[0] Or Not $aResult[4] Then Return SetError($aResult[0], 2, False)

	Local $oFactory = ObjCreateInterface($aResult[4], $sIID_ID2D1Factory, $tagID2D1Factory)
	If Not IsObj($oFactory) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oFactory
EndFunc   ;==>_D2D_Factory_Create


; _D2D_Factory_ReloadSystemMetrics
; _D2D_Factory_GetDesktopDpi



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateRectangleGeometry
; Description ...: Creates an ID2D1RectangleGeometry.
; Syntax ........: _D2D_Factory_CreateRectangleGeometry($oIFactory, $fLeft, $fTop, $fRight, $fBottom)
; Parameters ....: $oIFactory   -  An ID2D1Factory Object.
;                  $fLeft       -  The x-coordinate of the upper-left corner of the rectangle.
;                  $fTop        -  The y-coordinate of the upper-left corner of the rectangle.
;                  $fRight      -  The x-coordinate of the lower-right corner of the rectangle.
;                  $fBottom     -  The y-coordinate of the lower-right corner of the rectangle.
; Return values .: Success - An ID2D1RectangleGeometry object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateRectangleGeometry($oIFactory, $fLeft, $fTop, $fRight, $fBottom)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pRectangleGeometry
	Local $iHResult = $oIFactory.CreateRectangleGeometry(_D2D1_RECT_F($fLeft, $fTop, $fRight, $fBottom), $pRectangleGeometry)
	If $iHResult Or Not $pRectangleGeometry Then Return SetError($iHResult, 1, False)

	Local $oRectangleGeometry = ObjCreateInterface($pRectangleGeometry, $sIID_ID2D1RectangleGeometry, $tagID2D1RectangleGeometry)
	If Not IsObj($oRectangleGeometry) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oRectangleGeometry
EndFunc   ;==>_D2D_Factory_CreateRectangleGeometry


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateRoundedRectangleGeometry
; Description ...:  Creates an ID2D1RoundedRectangleGeometry.
; Syntax ........: _D2D_Factory_CreateRoundedRectangleGeometry($oIFactory, $fLeft, $fTop, $fRight, $fBottom, $fRadiusX, $fRadiusY)
; Parameters ....: $oIFactory - This ID2D1Factory object
;                  $fLeft     - The x-coordinate of the upper-left corner of the rectangle.
;                  $fTop      - The y-coordinate of the upper-left corner of the rectangle.
;                  $fRight    - The x-coordinate of the lower-right corner of the rectangle.
;                  $fBottom   - The y-coordinate of the lower-right corner of the rectangle.
;                  $fRadiusX  - The x-radius for the quarter ellipse that is drawn to replace every corner of the rectangle.
;                  $fRadiusY  - The y-radius for the quarter ellipse that is drawn to replace every corner of the rectangle.
; Return values .: Success - An ID2D1RoundedRectangleGeometry object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateRoundedRectangleGeometry($oIFactory, $fLeft, $fTop, $fRight, $fBottom, $fRadiusX, $fRadiusY)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	Local $tD2D1_ROUNDED_RECT = _D2D1_ROUNDED_RECT($fLeft, $fTop, $fRight, $fBottom, $fRadiusX, $fRadiusY)

	Local $pRoundedRectangleGeometry
	Local $iHResult = $oIFactory.CreateRoundedRectangleGeometry($tD2D1_ROUNDED_RECT, $pRoundedRectangleGeometry)
	If $iHResult Or Not $pRoundedRectangleGeometry Then Return SetError($iHResult, 1, False)

	Local $oRoundedRectangleGeometry = ObjCreateInterface($pRoundedRectangleGeometry, $sIID_ID2D1RoundedRectangleGeometry, $tagID2D1RoundedRectangleGeometry)
	If Not IsObj($oRoundedRectangleGeometry) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oRoundedRectangleGeometry
EndFunc   ;==>_D2D_Factory_CreateRoundedRectangleGeometry



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateEllipseGeometry
; Description ...: Creates an ID2D1EllipseGeometry.
; Syntax ........: _D2D_Factory_CreateEllipseGeometry($oIFactory, $fX, $fY, $fRadiusX, $fRadiusY)
; Parameters ....: $oIFactory - This ID2D1Factory object
;                  $fX        - The x-coordinate of the center point of the ellipse.
;                  $fY        - The y-coordinate of the center point of the ellipse.
;                  $fRadiusX  - The X-radius of the ellipse.
;                  $fRadiusY  - The Y-radius of the ellipse.
; Return values .: Success - An ID2D1EllipseGeometry object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateEllipseGeometry($oIFactory, $fX, $fY, $fRadiusX, $fRadiusY)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	Local $tD2D1_ELLIPSE = _D2D1_ELLIPSE($fX, $fY, $fRadiusX, $fRadiusY)

	Local $pEllipseGeometry
	Local $iHResult = $oIFactory.CreateEllipseGeometry($tD2D1_ELLIPSE, $pEllipseGeometry)
	If $iHResult Or Not $pEllipseGeometry Then Return SetError($iHResult, 1, False)

	Local $oEllipseGeometry = ObjCreateInterface($pEllipseGeometry, $sIID_ID2D1EllipseGeometry, $tagID2D1EllipseGeometry)
	If Not IsObj($oEllipseGeometry) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oEllipseGeometry
EndFunc   ;==>_D2D_Factory_CreateEllipseGeometry

; _D2D_Factory_CreateGeometryGroup


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateTransformedGeometry
; Description ...: Transforms the specified geometry and stores the result as an ID2D1TransformedGeometry object.
; Syntax ........: _D2D_Factory_CreateTransformedGeometry($oIFactory, $oSourceGeometry[, $tTransform = Null])
; Parameters ....: $oIFactory       - This ID2D1Factory object
;                  $oSourceGeometry - An ID2D1Geometry object. The geometry to transform.
;                  $tTransform      - [optional] A $tagD2D1_MATRIX_3X2_F structure. The transformation to apply.
; Return values .: Success - An ID2D1TransformedGeometry object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Like other resources, a transformed geometry inherits the resource space and threading policy of the factory that created it.
;                  This object is immutable.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateTransformedGeometry($oIFactory, $oSourceGeometry, $tTransform = Null)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oSourceGeometry) Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $pTransformedGeometry
	Local $iHResult = $oIFactory.CreateTransformedGeometry($oSourceGeometry, $tTransform, $pTransformedGeometry)
	If $iHResult Or Not $pTransformedGeometry Then Return SetError($iHResult, 2, False)

	Local $oTransformedGeometry = ObjCreateInterface($pTransformedGeometry, $sIID_ID2D1TransformedGeometry, $tagID2D1TransformedGeometry)
	If Not IsObj($oTransformedGeometry) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oTransformedGeometry
EndFunc   ;==>_D2D_Factory_CreateTransformedGeometry



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreatePathGeometry
; Description ...: Creates an empty ID2D1PathGeometry.
; Syntax ........: _D2D_Factory_CreatePathGeometry($oIFactory)
; Parameters ....: $oIFactory   -  An ID2D1Factory Object.
; Return values .: Success - An ID2D1PathGeometry object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreatePathGeometry($oIFactory)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pPathGeometry
	Local $iHResult = $oIFactory.CreatePathGeometry($pPathGeometry)
	If $iHResult Or Not $pPathGeometry Then Return SetError($iHResult, 1, False)

	Local $oPathGeometry = ObjCreateInterface($pPathGeometry, $sIID_ID2D1PathGeometry, $tagID2D1PathGeometry)
	If Not IsObj($oPathGeometry) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oPathGeometry
EndFunc   ;==>_D2D_Factory_CreatePathGeometry



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateStrokeStyle
; Description ...: Creates an ID2D1StrokeStyle that describes start cap, dash pattern, and other features of a stroke.
; Syntax ........: _D2D_Factory_CreateStrokeStyle($oIFactory[, $iLineJoin = 0[, $fMiterLimit = 10[, $iStartCap = 0[, $iEndCap = 0[, $iDashCap = 0[, $iDashStyle = 0[, $fDashOffset = 0[, $tDashes = Null[, $iDashesCount = 0]]]]]]]]])
; Parameters ....: $oIFactory    - This ID2D1Factory object
;                  $iLineJoin    - [optional] A $D2D1_LINE_JOIN enumeraion. A value that describes how segments are joined. This value is ignored
;                                             for a vertex if the segment flags specify that the segment should have a smooth join. -
;                  $fMiterLimit  - [optional] The limit of the thickness of the join on a mitered corner. This value is always treated as though
;                                             it is greater than or equal to 1.0f. -
;                  $iStartCap    - [optional] A $D2D1_CAP_STYLE enumeraion. The cap applied to the start of all the open figures in a stroked geometry.
;                  $iEndCap      - [optional] A $D2D1_CAP_STYLE enumeraion. The cap applied to the end of all the open figures in a stroked geometry.
;                  $iDashCap     - [optional] A $D2D1_CAP_STYLE enumeraion. The shape at either end of each dash segment.
;                  $iDashStyle   - [optional] A $D2D1_DASH_STYLE enumeraion. A value that specifies whether the stroke has a dash pattern and,
;                                             if so, the dash style.
;                  $fDashOffset  - [optional] A value that specifies an offset in the dash sequence. A positive dash offset value shifts the
;                                             dash pattern, in units of stroke width, toward the start of the stroked geometry. A negative dash
;                                             offset value shifts the dash pattern, in units of stroke width, toward the end of the stroked geometry.
;                  $tDashes      - [optional] A $tagFLOAT structure. A structure of float values. The first element sets the length of a dash,
;                                             the second element sets the length of a space, the third element sets the length of a dash, and
;                                             so on. The length of each dash and space in the dash pattern is the product of the element value
;                                             in the array and the stroke width.
;                  $iDashesCount - [optional] The number of elements in the "dashes" array.
; Return values .: Success - An ID2D1StrokeStyle object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateStrokeStyle($oIFactory, $iLineJoin = 0, $fMiterLimit = 10, $iStartCap = 0, $iEndCap = 0, $iDashCap = 0, $iDashStyle = 0, $fDashOffset = 0, $tDashes = Null, $iDashesCount = 0)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	Local $tD2D1_STROKE_STYLE_PROPERTIES = _D2D1_STROKE_STYLE_PROPERTIES($iStartCap, $iEndCap, $iDashCap, $iLineJoin, $fMiterLimit, $iDashStyle, $fDashOffset)

	Local $pStrokeStyle
	Local $iHResult = $oIFactory.CreateStrokeStyle($tD2D1_STROKE_STYLE_PROPERTIES, $tDashes, $iDashesCount, $pStrokeStyle)
	If $iHResult Or Not $pStrokeStyle Then Return SetError($iHResult, 1, False)

	Local $oStrokeStyle = ObjCreateInterface($pStrokeStyle, $sIID_ID2D1StrokeStyle, $tagID2D1StrokeStyle)
	If Not IsObj($oStrokeStyle) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oStrokeStyle
EndFunc   ;==>_D2D_Factory_CreateStrokeStyle



; _D2D_Factory_CreateDrawingStateBlock


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateWicBitmapRenderTarget
; Description ...: Creates a render target that renders to a Microsoft Windows Imaging Component (WIC) bitmap.
; Syntax ........: _D2D_Factory_CreateWicBitmapRenderTarget($oIFactory, $oWICBitmap[, $iPixelFormat = $DXGI_FORMAT_B8G8R8A8_UNORM[, $iAlphaMode = $D2D1_ALPHA_MODE_PREMULTIPLIED[, $fDpiX = 0[, $fDpiY = 0[, $iUsage = $D2D1_RENDER_TARGET_USAGE_NONE]]]]])
; Parameters ....: $oIFactory    - This ID2D1Factory object
;                  $oWICBitmap   - An IWICBitmap object. The bitmap that receives the rendering output of the render target.
;                  $iPixelFormat - [optional] The pixel format of the render target.
;                  $iAlphaMode   - [optional] A $D2D1_ALPHA_MODE enumeraion. The alpha mode of the render target.
;                  $fDpiX        - [optional] The horizontal DPI of the render target. To use the default DPI, set "dpiX" and "dpiY" to 0.
;                  $fDpiY        - [optional] The vertical DPI of the render target. To use the default DPI, set "dpiX" and "dpiY" to 0.
;                  $iUsage       - [optional] A $D2D1_RENDER_TARGET_USAGE enumeraion. A value that specifies how the render target is remoted
;                                             and whether it should be GDI-compatible.
; Return values .: Success - An ID2D1RenderTarget object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateWicBitmapRenderTarget($oIFactory, $oWICBitmap, $iPixelFormat = $DXGI_FORMAT_B8G8R8A8_UNORM, $iAlphaMode = $D2D1_ALPHA_MODE_PREMULTIPLIED, $fDpiX = 0, $fDpiY = 0, $iUsage = $D2D1_RENDER_TARGET_USAGE_NONE)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oWICBitmap) Then Return SetError($D2DERR_NOOBJ, 1, False)
	Local $tD2D1_RENDER_TARGET_PROPERTIES = _D2D1_RENDER_TARGET_PROPERTIES($D2D1_RENDER_TARGET_TYPE_SOFTWARE, $iPixelFormat, $iAlphaMode, $fDpiX, $fDpiY, $iUsage, $D2D1_FEATURE_LEVEL_DEFAULT)

	Local $pRenderTarget
	Local $iHResult = $oIFactory.CreateWicBitmapRenderTarget($oWICBitmap, $tD2D1_RENDER_TARGET_PROPERTIES, $pRenderTarget)
	If $iHResult Or Not $pRenderTarget Then Return SetError($iHResult, 2, False)

	Local $oRenderTarget = ObjCreateInterface($pRenderTarget, $sIID_ID2D1RenderTarget, $tagID2D1RenderTarget)
	If Not IsObj($oRenderTarget) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oRenderTarget
EndFunc   ;==>_D2D_Factory_CreateWicBitmapRenderTarget



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateHwndRenderTarget
; Description ...: Creates an ID2D1HwndRenderTarget, a render target that renders to a window.
; Syntax ........: _D2D_Factory_CreateHwndRenderTarget($oIFactory, $hHwnd[, $iWidth = 0[, $iHeight = 0[, $iPresentOptions = 0[, $iType = 0[, $iFormat = 0[, $iAlphaMode = 0[, $fDpiX = 0[, $fDpiY = 0[, $iUsage = 0[, $iMinLevel = 0]]]]]]]]]])
; Parameters ....: $oIFactory         -  An ID2D1Factory Object.
;                  $hHwnd             -  The HWND to which the render target issues the output from its drawing commands.
;                  $iWidth            -  The Width of the render target, in pixels.
;                  $iHeight           -  The Height of the render target, in pixels.
;                  $iPresentOptions   -  A value that specifies whether the render target retains the frame after it is presented and whether
;                                        the render target waits for the device to refresh before presenting.
;                  $iType             -  A value that specifies whether the render target should force hardware or software rendering.
;                  $iFormat           -  The pixel format of the render target.
;                  $iAlphaMode        -  The alpha mode of the render target.
;                  $fDpiX             -  The horizontal DPI of the render target.
;                  $fDpiY             -  The vertical DPI of the render target.
;                  $iUsage            -  A value that specifies how the render target is remoted and whether it should be GDI-compatible.
;                  $iMinLevel         -  A value that specifies the minimum Direct3D feature level required for hardware rendering.
; Return values .: Success - An ID2D1HwndRenderTarget object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: When you create a render target and hardware acceleration is available, you allocate resources on the computer's GPU.
;                  By creating a render target once and retaining it as long as possible, you gain performance benefits. Your application
;                  should create render targets once and hold onto them for the life of the application or until the D2DERR_RECREATE_TARGET
;                  error is recieved. When you recieve this error, you need to recreate the render target (and any resources it created).
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateHwndRenderTarget($oIFactory, $hHwnd, $iWidth = 0, $iHeight = 0, $iPresentOptions = 0, $iType = 0, $iFormat = 0, $iAlphaMode = 0, $fDpiX = 0, $fDpiY = 0, $iUsage = 0, $iMinLevel = 0)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)

	If Not $iWidth Then $iWidth = _WinAPI_GetClientWidth($hHwnd)
	If Not $iHeight Then $iHeight = _WinAPI_GetClientHeight($hHwnd)

	Local $pHwndRenderTarget
	Local $iHResult = $oIFactory.CreateHwndRenderTarget(_D2D1_RENDER_TARGET_PROPERTIES($iType, $iFormat, $iAlphaMode, $fDpiX, $fDpiY, $iUsage, $iMinLevel), _D2D1_HWND_RENDER_TARGET_PROPERTIES($hHwnd, $iWidth, $iHeight, $iPresentOptions), $pHwndRenderTarget)
	If $iHResult Or Not $pHwndRenderTarget Then Return SetError($iHResult, 1, False)

	Local $oHwndRenderTarget = ObjCreateInterface($pHwndRenderTarget, $sIID_ID2D1HwndRenderTarget, $tagID2D1HwndRenderTarget)
	If Not IsObj($oHwndRenderTarget) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oHwndRenderTarget
EndFunc   ;==>_D2D_Factory_CreateHwndRenderTarget





; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateDxgiSurfaceRenderTarget
; Description ...: Creates a render target that draws to a DirectX Graphics Infrastructure (DXGI) surface.
; Syntax ........: _D2D_Factory_CreateDxgiSurfaceRenderTarget($oIFactory, $oDxgiSurface[, $iType = $D2D1_RENDER_TARGET_TYPE_DEFAULT[, $iFormat = $DXGI_FORMAT_UNKNOWN[, $iAlphaMode = $D2D1_ALPHA_MODE_UNKNOWN[, $iMinLevel = $D2D1_FEATURE_LEVEL_DEFAULT[, $fDpiX = 0[, $fDpiY = 0]]]]]])
; Parameters ....: $oIFactory    - This ID2D1Factory object
;                  $oDxgiSurface - An IDXGISurface object. The IDXGISurface to which the render target will draw.
;                  $iType        - [optional] A $D2D1_RENDER_TARGET_TYPE enumeraion. A value that specifies whether the render target should
;                                             force hardware or software rendering.
;                  $iFormat      - [optional] The pixel format of the render target.
;                  $iAlphaMode   - [optional] A $D2D1_ALPHA_MODE enumeraion. The alpha mode of the render target.
;                  $iMinLevel    - [optional] A $D2D1_FEATURE_LEVEL enumeraion. A value that specifies the minimum Direct3D feature level required
;                                             for hardware rendering. If the specified minimum level is not available, the render target uses
;                                             software rendering if the type member is set to D2D1_RENDER_TARGET_TYPE_DEFAULT; if type is set
;                                             to to D2D1_RENDER_TARGET_TYPE_HARDWARE, render target creation fails.
;                  $fDpiX        - [optional] The horizontal DPI of the render target. To use the default DPI, set "dpiX" and "dpiY" to 0.
;                  $fDpiY        - [optional] The vertical DPI of the render target. To use the default DPI, set "dpiX" and "dpiY" to 0.
; Return values .: Success - An ID2D1RenderTarget object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: To write to a Direct3D surface, you obtain an IDXGISurface and pass it to the CreateDxgiSurfaceRenderTarget method to create
;                  a DXGI surface render target; you can then use the DXGI surface render target to draw 2-D content to the DXGI surface.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateDxgiSurfaceRenderTarget($oIFactory, $oDxgiSurface, $iType = $D2D1_RENDER_TARGET_TYPE_DEFAULT, $iFormat = $DXGI_FORMAT_UNKNOWN, $iAlphaMode = $D2D1_ALPHA_MODE_UNKNOWN, $iMinLevel = $D2D1_FEATURE_LEVEL_DEFAULT, $fDpiX = 0, $fDpiY = 0)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oDxgiSurface) And Not $oDxgiSurface Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $tD2D1_RENDER_TARGET_PROPERTIES = _D2D1_RENDER_TARGET_PROPERTIES($iType, $iFormat, $iAlphaMode, $fDpiX, $fDpiY, $D2D1_RENDER_TARGET_USAGE_NONE, $iMinLevel)

	Local $pRenderTarget
	Local $iHresult = $oIFactory.CreateDxgiSurfaceRenderTarget($oDxgiSurface, $tD2D1_RENDER_TARGET_PROPERTIES, $pRenderTarget)
	If $iHresult Or Not $pRenderTarget Then Return SetError($iHresult, 2, False)

	Local $oRenderTarget = ObjCreateInterface($pRenderTarget, $sIID_ID2D1RenderTarget, $tagID2D1RenderTarget)
	If Not IsObj($oRenderTarget) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oRenderTarget
EndFunc   ;==>_D2D_Factory_CreateDxgiSurfaceRenderTarget



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory_CreateDCRenderTarget
; Description ...: Creates a render target that draws to a Windows Graphics Device Interface (GDI) device context.
; Syntax ........: _D2D_Factory_CreateDCRenderTarget($oIFactory[, $iType = $D2D1_RENDER_TARGET_TYPE_DEFAULT[, $vFormat = $DXGI_FORMAT_B8G8R8A8_UNORM[, $iAlphaMode = $D2D1_ALPHA_MODE_PREMULTIPLIED[, $fDpiX = 0[, $fDpiY = 0[, $iUsage = 0[, $iMinLevel = 0]]]]]]])
; Parameters ....: $oIFactory  - This ID2D1Factory object
;                  $iType      - [optional] A $D2D1_RENDER_TARGET_TYPE enumeraion. A value that specifies whether the render target should force
;                                           hardware or software rendering.
;                  $vFormat    - [optional] The pixel format of the render target. To enable the device context (DC) render target to work with
;                                           GDI, set the DXGI format to DXGI_FORMAT_B8G8R8A8_UNORM.
;                  $iAlphaMode - [optional] A $D2D1_ALPHA_MODE enumeraion. The alpha mode of the render target. To enable the device context
;                                           (DC) render target to work with GDI, set the alpha mode to D2D1_ALPHA_MODE_PREMULTIPLIED or D2D1_ALPHA_MODE_IGNORE.
;                  $fDpiX      - [optional] The horizontal DPI of the render target. To use the default DPI, set "dpiX" and "dpiY" to 0.
;                  $fDpiY      - [optional] The vertical DPI of the render target. To use the default DPI, set "dpiX" and "dpiY" to 0.
;                  $iUsage     - [optional] A $D2D1_RENDER_TARGET_USAGE enumeraion. A value that specifies how the render target is remoted and
;                                           whether it should be GDI-compatible.
;                  $iMinLevel  - [optional] A value that specifies the minimum Direct3D feature level required for hardware rendering.
; Return values .: Success - An ID2D1DCRenderTarget object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Before you can render with a DC render target, you must use the render target's BindDC method to associate it with a GDI DC.
;                  Do this for each different DC and whenever there is a change in the size of the area you want to draw to.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Factory_CreateDCRenderTarget($oIFactory, $iType = $D2D1_RENDER_TARGET_TYPE_DEFAULT, $vFormat = $DXGI_FORMAT_B8G8R8A8_UNORM, $iAlphaMode = $D2D1_ALPHA_MODE_PREMULTIPLIED, $fDpiX = 0, $fDpiY = 0, $iUsage = 0, $iMinLevel = 0)
	If Not IsObj($oIFactory) Then Return SetError($D2DERR_NOOBJ, 0, False)
	Local $tD2D1_RENDER_TARGET_PROPERTIES = _D2D1_RENDER_TARGET_PROPERTIES($iType, $vFormat, $iAlphaMode, $fDpiX, $fDpiY, $iUsage, $iMinLevel)

	Local $pDcRenderTarget
	Local $iHResult = $oIFactory.CreateDCRenderTarget($tD2D1_RENDER_TARGET_PROPERTIES, $pDcRenderTarget)
	If $iHResult Or Not $pDcRenderTarget Then Return SetError($iHResult, 1, False)

	Local $oDcRenderTarget = ObjCreateInterface($pDcRenderTarget, $sIID_ID2D1DCRenderTarget, $tagID2D1DCRenderTarget)
	If Not IsObj($oDcRenderTarget) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oDcRenderTarget
EndFunc   ;==>_D2D_Factory_CreateDCRenderTarget



;#######################################################################################################################################################################
;# ID2D1GdiInteropRenderTarget
;#######################################################################################################################################################################
#cs   ID2D1GdiInteropRenderTarget
	Method ...: GetDC (uint, handle*)
	Info .....:     Retrieves the device context associated with this render target.
	Param ....:         $iMode  [in]   <$D2D1_DC_INITIALIZE_MODE>  A value that specifies whether the device context should be cleared.
	Param ....:         $hHdc   [out]  <hwnd>                      When this method returns, contains the device context associated with this render target. You must allocate storage for this parameter.

	Method ...: ReleaseDC (struct*)
	Info .....:     Indicates that drawing with the device context retrieved using the method is finished.
	Param ....:         $tUpdate  [in, optional]  <$tagRECT>  The modified region of the device context, or NULL to specify the entire render target.
#ce
; _D2D_GdiInteropRenderTarget_GetDC
; _D2D_GdiInteropRenderTarget_ReleaseDC



;#######################################################################################################################################################################
;# ID2D1Geometry
;#######################################################################################################################################################################
#cs   ID2D1Geometry
	Method ...: CombineWithGeometry (struct*, uint, struct*, float, struct*)
	Info .....:     Combines this geometry with the specified geometry and stores the result in an .
	Param ....:         $oInputGeometry           [in]            <ID2D1Geometry>                The geometry to combine with this instance.
	Param ....:         $iCombineMode             [in]            <$D2D1_COMBINE_MODE>           The type of combine operation to perform.
	Param ....:         $tInputGeometryTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>        The transform to apply to inputGeometry before combining.
	Param ....:         $oGeometrySink            [in]            <ID2D1SimplifiedGeometrySink>  The result of the combine operation.

	Method ...: CompareWithGeometry (struct*, struct*, float, uint*)
	Info .....:     Describes the intersection between this geometry and the specified geometry. The comparison is performed using the default flattening tolerance.
	Param ....:         $oInputGeometry           [in]            <ID2D1Geometry>            The geometry to test.
	Param ....:         $tInputGeometryTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>    The transform to apply to inputGeometry, or NULL.
	Param ....:         $iRelation                [out]           <$D2D1_GEOMETRY_RELATION>  When this method returns, contains a pointer to a value that describes how this geometry is related to inputGeometry. You must allocate storage for this parameter.

	Method ...: ComputeArea (struct*, float, float*)
	Info .....:     Computes the area of the geometry after it has been transformed by the specified matrix and flattened by using the default tolerance.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to this geometry before computing its area, or NULL.
	Param ....:         $fArea            [out]           <float>                  When this method returns, contains a pointer to the area of the transformed, flattened version of this geometry. You must allocate storage for this parameter.

	Method ...: ComputeLength (struct*, float, float*)
	Info .....:     Calculates the length of the geometry as though each segment were unrolled into a line.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to the geometry before calculating its length, or NULL.
	Param ....:         $fLength          [out]           <float>                  When this method returns, contains a pointer to the length of the geometry. For closed geometries, the length includes an implicit closing segment. You must allocate storage for this parameter.

	Method ...: ComputePointAtLength (float, struct*, float, struct*, struct*)
	Info .....:     Calculates the point and tangent vector at the specified distance along the geometry after it has been transformed by the specified matrix and flattened using the default tolerance.
	Param ....:         $fLength             [in]             <float>                  The distance along the geometry of the point and tangent to find. If this distance is less then 0, this method calculates the first point in the geometry. If this distance is greater than the length of the geometry, this method calculates the last point in the geometry.
	Param ....:         $tWorldTransform     [in, optional]   <$tagD2D1_MATRIX_3X2_F>  The transform to apply to the geometry before calculating the specified point and tangent, or NULL.
	Param ....:         $tPoint              [out, optional]  <$tagD2D1_POINT_2F>      The location at the specified distance along the geometry. If the geometry is empty, this point contains NaN as its x and y values.
	Param ....:         $tUnitTangentVector  [out, optional]  <$tagD2D1_POINT_2F>      The tangent vector at the specified distance along the geometry. If the geometry is empty, this vector contains NaN as its x and y values.

	Method ...: FillContainsPoint (struct, struct*, float, bool*)
	Info .....:     Indicates whether the area filled by this geometry would contain the specified point.
	Param ....:         $tPoint           [in]            <$tagD2D1_POINT_2F>      The point to test.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to this geometry prior to testing for containment, or NULL.
	Param ....:         $bContains        [out]           <bool>                   When this method returns, contains a BOOL value that is TRUE if the area filled by the geometry contains point; otherwise, FALSE. You must allocate storage for this parameter.

	Method ...: GetBounds (struct*, struct*)
	Info .....:     Retrieves the bounds of the geometry.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to this geometry before calculating its bounds, or NULL.
	Param ....:         $tBounds          [out]           <$tagD2D1_RECT_F>        When this method returns, contains the bounds of this geometry. If the bounds are empty, this parameter will be a rect where bounds.left &gt; bounds.right. You must allocate storage for this parameter.

	Method ...: GetWidenedBounds (float, struct*, struct*, float, struct*)
	Info .....:     Gets the bounds of the geometry after it has been widened by the specified stroke width and style and transformed by the specified matrix.
	Param ....:         $fStrokeWidth     [in]            <float>                  The amount by which to widen the geometry by stroking its outline.
	Param ....:         $oStrokeStyle     [in, optional]  <ID2D1StrokeStyle>       The style of the stroke that widens the geometry.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>  A transform to apply to the geometry after the geometry is transformed and after the geometry has been stroked, or NULL.
	Param ....:         $tBounds          [out]           <$tagD2D1_RECT_F>        When this method returns, contains the bounds of the widened geometry. You must allocate storage for this parameter.

	Method ...: Outline (struct*, float, struct*)
	Info .....:     Computes the outline of the geometry and writes the result to an .
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>        The transform to apply to the geometry outline, or NULL.
	Param ....:         $oGeometrySink    [in]            <ID2D1SimplifiedGeometrySink>  The to which the geometry's transformed outline is appended.

	Method ...: StrokeContainsPoint (struct, float, struct*, struct*, float, bool*)
	Info .....:     Determines whether the geometry's stroke contains the specified point given the specified stroke thickness, style, and transform.
	Param ....:         $tPoint           [in]            <$tagD2D1_POINT_2F>      The point to test for containment.
	Param ....:         $fStrokeWidth     [in]            <float>                  The thickness of the stroke to apply.
	Param ....:         $oStrokeStyle     [in, optional]  <ID2D1StrokeStyle>       The style of stroke to apply.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to the stroked geometry.
	Param ....:         $bContains        [out]           <bool>                   When this method returns, contains a boolean value set to true if the geometry's stroke contains the specified point; otherwise, false. You must allocate storage for this parameter.

	Method ...: Simplify (uint, struct*, float, struct*)
	Info .....:     Creates a simplified version of the geometry that contains only lines and (optionally) cubic Bezier curves and writes the result to an .
	Param ....:         $iSimplificationOption  [in]            <$D2D1_GEOMETRY_SIMPLIFICATION_OPTION>  A value that specifies whether the simplified geometry should contain curves.
	Param ....:         $tWorldTransform        [in, optional]  <$tagD2D1_MATRIX_3X2_F>                 The transform to apply to the simplified geometry, or NULL.
	Param ....:         $oGeometrySink          [in]            <ID2D1SimplifiedGeometrySink>           The to which the simplified geometry is appended.

	Method ...: Tessellate (struct*, float, struct*)
	Info .....:     Creates a set of clockwise-wound triangles that cover the geometry after it has been transformed using the specified matrix and flattened using the default tolerance.
	Param ....:         $tWorldTransform    [in, optional]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to this geometry, or NULL.
	Param ....:         $oTessellationSink  [in]            <ID2D1TessellationSink>  The to which the tessellated is appended.

	Method ...: Widen (float, struct*, struct*, float, struct*)
	Info .....:     Widens the geometry by the specified stroke and writes the result to an after it has been transformed by the specified matrix and flattened using the default tolerance.
	Param ....:         $fStrokeWidth     [in]            <float>                        The amount by which to widen the geometry.
	Param ....:         $oStrokeStyle     [in, optional]  <ID2D1StrokeStyle>             The style of stroke to apply to the geometry, or NULL.
	Param ....:         $tWorldTransform  [in, optional]  <$tagD2D1_MATRIX_3X2_F>        The transform to apply to the geometry after widening it, or NULL.
	Param ....:         $oGeometrySink    [in]            <ID2D1SimplifiedGeometrySink>  The to which the widened geometry is appended.
#ce

; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Geometry_GetBounds
; Description ...: Retrieves the bounds of the geometry.
; Syntax ........: _D2D_Geometry_GetBounds($oIGeometry[, $tWorldTransform = Null])
; Parameters ....: $oIGeometry      - This ID2D1Geometry object
;                  $tWorldTransform - [optional] A $tagD2D1_MATRIX_3X2_F structure. The transform to apply to this geometry before calculating
;                                                its bounds, or NULL.
; Return values .: Success - A $tagD2D1_RECT_F structure.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Geometry_GetBounds($oIGeometry, $tWorldTransform = Null)
	If Not IsObj($oIGeometry) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tBounds = DllStructCreate($tagD2D1_RECT_F)
	Local $iHResult = $oIGeometry.GetBounds($tWorldTransform, $tBounds)
	If $iHResult Then Return SetError($iHResult, 1, False)

	Return $tBounds
EndFunc   ;==>_D2D_Geometry_GetBounds





; _D2D_Geometry_GetWidenedBounds
; _D2D_Geometry_StrokeContainsPoint
; _D2D_Geometry_FillContainsPoint
; _D2D_Geometry_CompareWithGeometry
; _D2D_Geometry_Simplify
; _D2D_Geometry_Tessellate


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Geometry_CombineWithGeometry
; Description ...: Combines this geometry with the specified geometry and stores the result in an ID2D1PathGeometry.
; Syntax ........: _D2D_Geometry_CombineWithGeometry($oIGeometry, $oInputGeometry[, $iCombineMode = 0[, $tMatrix = Null[, $fFlatteningTolerance = 0]]])
; Parameters ....: $oIGeometry             -  An ID2D1Geometry Object.
;                  $oInputGeometry         -  The geometry to combine with this instance.
;                  $iCombineMode           -  The type of combine operation to perform.
;                  $tMatrix                -  The transform to apply to inputGeometry before combining, or NULL.
;                  $fFlatteningTolerance   -  The maximum bounds on the distance between points in the polygonal approximation of the geometries.
;                                             Smaller values produce more accurate results but cause slower execution.
; Return values .: Success - An ID2D1PathGeometry object. The result of the combine operation.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Geometry_CombineWithGeometry($oIGeometry, $oInputGeometry, $iCombineMode = 0, $tMatrix = Null, $fFlatteningTolerance = 0)
	If Not IsObj($oIGeometry) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oInputGeometry) Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $pFactory
	Local $iHResult = $oIGeometry.GetFactory($pFactory)
	If $iHResult Or Not $pFactory Then Return SetError($iHResult, 2, False)
	Local $oFactory = ObjCreateInterface($pFactory, $sIID_ID2D1Factory, $tagID2D1Factory)
	If Not IsObj($oFactory) Then Return SetError($D2DERR_OBJFAIL, 3, False)

	Local $pPathGeometry
	$iHResult = $oFactory.CreatePathGeometry($pPathGeometry)
	$oFactory = 0
	If $iHResult Or Not $pPathGeometry Then Return SetError($iHResult, 2, False)
	Local $oPathGeometry = ObjCreateInterface($pPathGeometry, $sIID_ID2D1PathGeometry, $tagID2D1PathGeometry)
	If Not IsObj($oPathGeometry) Then Return SetError($D2DERR_OBJFAIL, 3, False)

	Local $pGeometrySink
	$iHResult = $oPathGeometry.Open($pGeometrySink)
	If $iHResult Or Not $pGeometrySink Then Return SetError($iHResult, 4, False)
	Local $oGeometrySink = ObjCreateInterface($pGeometrySink, $sIID_ID2D1GeometrySink, $tagID2D1GeometrySink)
	If Not IsObj($oGeometrySink) Then Return SetError($D2DERR_OBJFAIL, 5, False)

	$iHResult = $oIGeometry.CombineWithGeometry($oInputGeometry, $iCombineMode, $tMatrix, $fFlatteningTolerance, $oGeometrySink)
	If $iHResult Then Return SetError($D2DERR_UFAIL, 6, False)
	$oGeometrySink.Close()
	$oGeometrySink = 0

	Return $oPathGeometry
EndFunc   ;==>_D2D_Geometry_CombineWithGeometry


; _D2D_Geometry_Outline
; _D2D_Geometry_ComputeArea




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Geometry_ComputeLength
; Description ...: Calculates the length of the geometry as though each segment were unrolled into a line.
; Syntax ........: _D2D_Geometry_ComputeLength($oIGeometry[, $fFlatteningTolerance = 0[, $tTransform = Null]])
; Parameters ....: $oIGeometry           - This ID2D1Geometry object
;                  $fFlatteningTolerance - [optional] The maximum error allowed when constructing a polygonal approximation of the geometry.
;                                                     No point in the polygonal representation will diverge from the original geometry by more
;                                                     than the flattening tolerance. Smaller values produce more accurate results but cause slower execution.
;                  $tTransform           - [optional] A $tagD2D1_MATRIX_3X2_F structure. The transform to apply to the geometry before calculating
;                                                     its length, or NULL.
; Return values .: Success - float - length of the geometry
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Geometry_ComputeLength($oIGeometry, $fFlatteningTolerance = 0, $tTransform = Null)
	If Not IsObj($oIGeometry) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $fLength
	Local $iHResult = $oIGeometry.ComputeLength($tTransform, $fFlatteningTolerance, $fLength)
	If $iHResult Or Not $fLength Then Return SetError($iHResult, 1, False)

	Return $fLength
EndFunc   ;==>_D2D_Geometry_ComputeLength


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Geometry_ComputePointAtLength
; Description ...: Calculates the point and tangent vector at the specified distance along the geometry after it has been transformed by the specified matrix and flattened using the specified tolerance.
; Syntax ........: _D2D_Geometry_ComputePointAtLength($oIGeometry, $fLength[, $fFlatteningTolerance = 0[, $tTransform = Null]])
; Parameters ....: $oIGeometry           - This ID2D1Geometry object
;                  $fLength              - The distance along the geometry of the point and tangent to find. If this distance is less then 0,
;                                          this method calculates the first point in the geometry. If this distance is greater than the length
;                                          of the geometry, this method calculates the last point in the geometry.
;                  $fFlatteningTolerance - [optional] The maximum error allowed when constructing a polygonal approximation of the geometry.
;                                                     No point in the polygonal representation will diverge from the original geometry by more
;                                                     than the flattening tolerance. Smaller values produce more accurate results but cause slower execution.
;                  $tTransform           - [optional] A $tagD2D1_MATRIX_3X2_F structure. The transform to apply to the geometry before calculating
;                                                     the specified point and tangent, or NULL.
; Return values .: Success - A $tagD2D1_POINT_2F structure.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Geometry_ComputePointAtLength($oIGeometry, $fLength, $fFlatteningTolerance = 0, $tTransform = Null)
	If Not IsObj($oIGeometry) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tPoint = DllStructCreate($tagD2D1_POINT_2F)
	Local $iHResult = $oIGeometry.ComputePointAtLength($fLength, $tTransform, $fFlatteningTolerance, $tPoint, Null)
	If $iHResult Then Return SetError($iHResult, 1, False)

	Return $tPoint
EndFunc   ;==>_D2D_Geometry_ComputePointAtLength



; _D2D_Geometry_Widen



;#######################################################################################################################################################################
;# ID2D1GeometryGroup
;#######################################################################################################################################################################
#cs   ID2D1GeometryGroup
	Method ...: GetFillMode ()
	Info .....:     Indicates how the intersecting areas of the geometries contained in this geometry group are combined.
	Param ....:         This method has no parameters.

	Method ...: GetSourceGeometries (struct*, uint)
	Info .....:     Retrieves the geometries in the geometry group.
	Param ....:         $oGeometries       [out]  <ID2D1Geometry>  When this method returns, contains the address of a pointer to an array of geometries to be filled by this method. The length of the array is specified by the geometryCount parameter. If the array is NULL, then this method performs no operation. You must allocate the memory for this array.
	Param ....:         $iGeometriesCount  [in]   <uint>           A value indicating the number of geometries to return in the geometries array. If this value is less than the number of geometries in the geometry group, the remaining geometries are omitted. If this value is larger than the number of geometries in the geometry group, the extra geometries are set to NULL. To obtain the number of geometries currently in the geometry group, use the method.

	Method ...: GetSourceGeometryCount ()
	Info .....:     Indicates the number of geometry objects in the geometry group.
	Param ....:         This method has no parameters.
#ce
; _D2D_GeometryGroup_GetFillMode
; _D2D_GeometryGroup_GetSourceGeometryCount
; _D2D_GeometryGroup_GetSourceGeometries



;#######################################################################################################################################################################
;# ID2D1GeometrySink
;#######################################################################################################################################################################
#cs   ID2D1GeometrySink
	Method ...: AddArc (struct*)
	Info .....:     Adds a single arc to the path geometry.
	Param ....:         $tArc  [in]  <$tagD2D1_ARC_SEGMENT>  The arc segment to add to the figure.

	Method ...: AddBezier (struct*)
	Info .....:     Creates a cubic Bezier curve between the current point and the specified endpoint.
	Param ....:         $tBezier  [in]  <$tagD2D1_BEZIER_SEGMENT>  A structure that describes the control points and endpoint of the Bezier curve to add.

	Method ...: AddLine (struct)
	Info .....:     Creates a line segment between the current point and the specified end point and adds it to the geometry sink.
	Param ....:         $tPoint  [in]  <$tagD2D1_POINT_2F>  The end point of the line to draw.

	Method ...: AddQuadraticBezier (struct*)
	Info .....:     Creates a quadratic Bezier curve between the current point and the specified endpoint.
	Param ....:         $tBezier  [in]  <$tagD2D1_QUADRATIC_BEZIER_SEGMENT>  A structure that describes the control point and the endpoint of the quadratic Bezier curve to add.

	Method ...: AddQuadraticBeziers (struct*, uint)
	Info .....:     Adds a sequence of quadratic Bezier segments as an array in a single call.
	Param ....:         $tBeziers      [in]  <$tagD2D1_QUADRATIC_BEZIER_SEGMENT>  An array of a sequence of quadratic Bezier segments.
	Param ....:         $iBezierCount  [in]  <uint>                               A value indicating the number of quadratic Bezier segments in beziers.
#ce

; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_GeometrySink_AddLine
; Description ...: Creates a line segment between the current point and the specified end point and adds it to the geometry sink.
; Syntax ........: _D2D_GeometrySink_AddLine($oIGeometrySink, $fX, $fY)
; Parameters ....: $oIGeometrySink - This ID2D1GeometrySink object
;                  $fX             - The x-coordinate of the end point of the line to draw.
;                  $fY             - The y-coordinate of the end point of the line to draw.
; Return values .: Success - void
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_GeometrySink_AddLine($oIGeometrySink, $fX, $fY)
	If Not IsObj($oIGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)

	$oIGeometrySink.AddLine(_D2D1_POINT_2F($fX, $fY))

	Return True
EndFunc   ;==>_D2D_GeometrySink_AddLine




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_GeometrySink_AddBezier
; Description ...:  Creates a cubic Bezier curve between the current point and the specified endpoint.
; Syntax ........: _D2D_GeometrySink_AddBezier($oIGeometrySink, $fPoint1X, $fPoint1Y, $fPoint2X, $fPoint2Y, $fPoint3X, $fPoint3Y)
; Parameters ....: $oIGeometrySink - This ID2D1GeometrySink object
;                  $fPoint1X       - The x-coordinate of the first control point for the Bezier segment.
;                  $fPoint1Y       - The y-coordinate of the first control point for the Bezier segment.
;                  $fPoint2X       - The x-coordinate of the second control point for the Bezier segment.
;                  $fPoint2Y       - The y-coordinate of the second control point for the Bezier segment.
;                  $fPoint3X       - The x-coordinate of the end point for the Bezier segment.
;                  $fPoint3Y       - The y-coordinate of the end point for the Bezier segment.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_GeometrySink_AddBezier($oIGeometrySink, $fPoint1X, $fPoint1Y, $fPoint2X, $fPoint2Y, $fPoint3X, $fPoint3Y)
	If Not IsObj($oIGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)

	$oIGeometrySink.AddBezier(_D2D1_BEZIER_SEGMENT($fPoint1X, $fPoint1Y, $fPoint2X, $fPoint2Y, $fPoint3X, $fPoint3Y))

	Return True
EndFunc   ;==>_D2D_GeometrySink_AddBezier



; _D2D_GeometrySink_AddQuadraticBezier
; _D2D_GeometrySink_AddQuadraticBeziers



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_GeometrySink_AddArc
; Description ...: Adds a single arc to the path geometry.
; Syntax ........: _D2D_GeometrySink_AddArc($oIGeometrySink, $fX, $fY, $fWidth, $fHeight, $fRotationAngle[, $iSweepDirection = 1[, $iArcSize = 0]])
; Parameters ....: $oIGeometrySink  - This ID2D1GeometrySink object
;                  $fX              - The x-coordinate of the end point of the arc.
;                  $fY              - The y-coordinate of the end point of the arc.
;                  $fWidth          - The x-radius of the arc.
;                  $fHeight         - The y-radius of the arc.
;                  $fRotationAngle  - A value that specifies how many degrees in the clockwise direction the ellipse is rotated relative to the
;                                     current coordinate system.
;                  $iSweepDirection - [optional] A $D2D1_SWEEP_DIRECTION enumeraion. A value that specifies whether the arc sweep is clockwise
;                                                or counterclockwise.
;                  $iArcSize        - [optional] A $D2D1_ARC_SIZE enumeraion. A value that specifies whether the given arc is larger than 180 degrees.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_GeometrySink_AddArc($oIGeometrySink, $fX, $fY, $fWidth, $fHeight, $fRotationAngle, $iSweepDirection = 1, $iArcSize = 0)
	If Not IsObj($oIGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)

	$oIGeometrySink.AddArc(_D2D1_ARC_SEGMENT($fX, $fY, $fWidth, $fHeight, $fRotationAngle, $iSweepDirection, $iArcSize))

	Return True
EndFunc   ;==>_D2D_GeometrySink_AddArc


;#######################################################################################################################################################################
;# ID2D1GradientStopCollection
;#######################################################################################################################################################################
#cs   ID2D1GradientStopCollection
	Method ...: GetColorInterpolationGamma ()
	Info .....:     Indicates the gamma space in which the gradient stops are interpolated.
	Param ....:         This method has no parameters.

	Method ...: GetExtendMode ()
	Info .....:     Indicates the behavior of the gradient outside the normalized gradient range.
	Param ....:         This method has no parameters.

	Method ...: GetGradientStopCount ()
	Info .....:     Retrieves the number of gradient stops in the collection.
	Param ....:         This method has no parameters.

	Method ...: GetGradientStops (struct*, uint)
	Info .....:     Copies the gradient stops from the collection into an array of structures.
	Param ....:         $tGradientStops       [out]  <$tagD2D1_GRADIENT_STOP>  A pointer to a one-dimensional array of structures. When this method returns, the array contains copies of the collection's gradient stops. You must allocate the memory for this array.
	Param ....:         $iGradientStopsCount  [in]   <uint>                    A value indicating the number of gradient stops to copy. If the value is less than the number of gradient stops in the collection, the remaining gradient stops are omitted. If the value is larger than the number of gradient stops in the collection, the extra gradient stops are set to NULL. To obtain the number of gradient stops in the collection, use the method.
#ce
; _D2D_GradientStopCollection_GetGradientStopCount
; _D2D_GradientStopCollection_GetGradientStops
; _D2D_GradientStopCollection_GetColorInterpolationGamma
; _D2D_GradientStopCollection_GetExtendMode



;#######################################################################################################################################################################
;# ID2D1HwndRenderTarget
;#######################################################################################################################################################################
#cs   ID2D1HwndRenderTarget
	Method ...: CheckWindowState ()
	Info .....:     Indicates whether the HWND associated with this render target is occluded.
	Param ....:         This method has no parameters.

	Method ...: GetHwnd ()
	Info .....:     Returns the HWND associated with this render target.
	Param ....:         This method has no parameters.

	Method ...: Resize (struct*)
	Info .....:     Changes the size of the render target to the specified pixel size.
	Param ....:         $tPixelSize  [in]  <$tagD2D1_SIZE_U>  The new size of the render target in device pixels.
#ce
; _D2D_HwndRenderTarget_CheckWindowState
; _D2D_HwndRenderTarget_Resize
; _D2D_HwndRenderTarget_GetHwnd



;#######################################################################################################################################################################
;# ID2D1Layer
;#######################################################################################################################################################################
#cs   ID2D1Layer
	Method ...: GetSize (struct*)
	Info .....:     Gets the size of the layer in device-independent pixels.
	Param ....:         $tD2D1_SIZE_F  [OUT]  <$tagD2D1_SIZE_F>
#ce
; _D2D_Layer_GetSize



;#######################################################################################################################################################################
;# ID2D1LinearGradientBrush
;#######################################################################################################################################################################
#cs   ID2D1LinearGradientBrush
	Method ...: GetEndPoint (struct*)
	Info .....:     Retrieves the ending coordinates of the linear gradient.
	Param ....:         $tD2D1_POINT_2F  [OUT]  <$tagD2D1_POINT_2F>

	Method ...: GetGradientStopCollection (ptr*)
	Info .....:     Retrieves the associated with this linear gradient brush.
	Param ....:         $oGradientStopCollection  [out]  <ID2D1GradientStopCollection>  The object associated with this linear gradient brush object. This parameter is passed uninitialized.

	Method ...: GetStartPoint (struct*)
	Info .....:     Retrieves the starting coordinates of the linear gradient.
	Param ....:         $tD2D1_POINT_2F  [OUT]  <$tagD2D1_POINT_2F>

	Method ...: SetEndPoint (struct)
	Info .....:     Sets the ending coordinates of the linear gradient in the brush's coordinate space.
	Param ....:         $tEndPoint  [in]  <$tagD2D1_POINT_2F>  The ending two-dimensional coordinates of the linear gradient, in the brush's coordinate space.

	Method ...: SetStartPoint (struct)
	Info .....:     Sets the starting coordinates of the linear gradient in the brush's coordinate space.
	Param ....:         $tStartPoint  [in]  <$tagD2D1_POINT_2F>  The starting two-dimensional coordinates of the linear gradient, in the brush's coordinate space.
#ce
; _D2D_LinearGradientBrush_SetStartPoint
; _D2D_LinearGradientBrush_SetEndPoint
; _D2D_LinearGradientBrush_GetStartPoint
; _D2D_LinearGradientBrush_GetEndPoint
; _D2D_LinearGradientBrush_GetGradientStopCollection



;#######################################################################################################################################################################
;# ID2D1Mesh
;#######################################################################################################################################################################
#cs   ID2D1Mesh
	Method ...: Open (ptr*)
	Info .....:     Opens the mesh for population.
	Param ....:         $oTessellationSink  [out]  <ID2D1TessellationSink>  When this method returns, contains a pointer to a pointer to an that is used to populate the mesh. This parameter is passed uninitialized.
#ce
; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Mesh_Open
; Description ...: Opens the mesh for population.
; Syntax ........: _D2D_Mesh_Open($oIMesh)
; Parameters ....: $oIMesh   -  An ID2D1Mesh Object.
; Return values .: Success - An ID2D1TessellationSink object. that is used to populate the mesh.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_Mesh_Open($oIMesh)
	If Not IsObj($oIMesh) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pTessellationSink
	Local $iHResult = $oIMesh.Open($pTessellationSink)
	If $iHResult Or Not $pTessellationSink Then Return SetError($iHResult, 1, False)

	Local $oTessellationSink = ObjCreateInterface($pTessellationSink, $sIID_ID2D1TessellationSink, $tagID2D1TessellationSink)
	If Not IsObj($oTessellationSink) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oTessellationSink
EndFunc   ;==>_D2D_Mesh_Open



;#######################################################################################################################################################################
;# ID2D1PathGeometry
;#######################################################################################################################################################################
#cs   ID2D1PathGeometry
	Method ...: GetFigureCount (uint*)
	Info .....:     Retrieves the number of figures in the path geometry.
	Param ....:         $iCount  [out]  <uint>  A pointer that receives the number of figures in the path geometry when this method returns. You must allocate storage for this parameter.

	Method ...: GetSegmentCount (uint*)
	Info .....:     Retrieves the number of segments in the path geometry.
	Param ....:         $iCount  [out]  <uint>  A pointer that receives the number of segments in the path geometry when this method returns. You must allocate storage for this parameter.

	Method ...: Open (ptr*)
	Info .....:     Retrieves the geometry sink that is used to populate the path geometry with figures and segments.
	Param ....:         $oGeometrySink  [out]  <ID2D1GeometrySink>  When this method returns, geometrySink contains the address of a pointer to the geometry sink that is used to populate the path geometry with figures and segments. This parameter is passed uninitialized.

	Method ...: Stream (struct*)
	Info .....:     Copies the contents of the path geometry to the specified .
	Param ....:         $oGeometrySink  [in]  <ID2D1GeometrySink>  The sink to which the path geometry's contents are copied. Modifying this sink does not change the contents of this path geometry.
#ce

; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_PathGeometry_Open
; Description ...: Retrieves the geometry sink that is used to populate the path geometry with figures and segments.
; Syntax ........: _D2D_PathGeometry_Open($oIPathGeometry)
; Parameters ....: $oIPathGeometry   -  An ID2D1PathGeometry Object.
; Return values .: Success - An ID2D1GeometrySink object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Because path geometries are immutable and can only be populated once, it is an error to call Open on a path geometry
;                  more than once.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_PathGeometry_Open($oIPathGeometry)
	If Not IsObj($oIPathGeometry) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pGeometrySink
	Local $iHResult = $oIPathGeometry.Open($pGeometrySink)
	If $iHResult Or Not $pGeometrySink Then Return SetError($iHResult, 1, False)

	Local $oGeometrySink = ObjCreateInterface($pGeometrySink, $sIID_ID2D1GeometrySink, $tagID2D1GeometrySink)
	If Not IsObj($oGeometrySink) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oGeometrySink
EndFunc   ;==>_D2D_PathGeometry_Open



; _D2D_PathGeometry_Stream
; _D2D_PathGeometry_GetSegmentCount
; _D2D_PathGeometry_GetFigureCount



;#######################################################################################################################################################################
;# ID2D1RadialGradientBrush
;#######################################################################################################################################################################
#cs   ID2D1RadialGradientBrush
	Method ...: GetCenter (struct*)
	Info .....:     Retrieves the center of the gradient ellipse.
	Param ....:         $tD2D1_POINT_2F  [OUT]  <$tagD2D1_POINT_2F>

	Method ...: GetGradientOriginOffset (struct*)
	Info .....:     Retrieves the offset of the gradient origin relative to the gradient ellipse's center.
	Param ....:         $tD2D1_POINT_2F  [OUT]  <$tagD2D1_POINT_2F>

	Method ...: GetGradientStopCollection (ptr*)
	Info .....:     Retrieves the associated with this radial gradient brush object.
	Param ....:         $oGradientStopCollection  [out]  <ID2D1GradientStopCollection>  The object associated with this linear gradient brush object. This parameter is passed uninitialized.

	Method ...: GetRadiusX ()
	Info .....:     Retrieves the x-radius of the gradient ellipse.
	Param ....:         This method has no parameters.

	Method ...: GetRadiusY ()
	Info .....:     Retrieves the y-radius of the gradient ellipse.
	Param ....:         This method has no parameters.

	Method ...: SetCenter (struct)
	Info .....:     Specifies the center of the gradient ellipse in the brush's coordinate space.
	Param ....:         $tCenter  [in]  <$tagD2D1_POINT_2F>  The center of the gradient ellipse, in the brush's coordinate space.

	Method ...: SetGradientOriginOffset (struct)
	Info .....:     Specifies the offset of the gradient origin relative to the gradient ellipse's center.
	Param ....:         $tGradientOriginOffset  [in]  <$tagD2D1_POINT_2F>  The offset of the gradient origin from the center of the gradient ellipse.

	Method ...: SetRadiusX (float)
	Info .....:     Specifies the x-radius of the gradient ellipse, in the brush's coordinate space.
	Param ....:         $fRadiusX  [in]  <float>  The x-radius of the gradient ellipse. This value is in the brush's coordinate space.

	Method ...: SetRadiusY (float)
	Info .....:     Specifies the y-radius of the gradient ellipse, in the brush's coordinate space.
	Param ....:         $fRadiusY  [in]  <float>  The y-radius of the gradient ellipse. This value is in the brush's coordinate space.
#ce
; _D2D_RadialGradientBrush_SetCenter
; _D2D_RadialGradientBrush_SetGradientOriginOffset
; _D2D_RadialGradientBrush_SetRadiusX
; _D2D_RadialGradientBrush_SetRadiusY
; _D2D_RadialGradientBrush_GetCenter
; _D2D_RadialGradientBrush_GetGradientOriginOffset
; _D2D_RadialGradientBrush_GetRadiusX
; _D2D_RadialGradientBrush_GetRadiusY
; _D2D_RadialGradientBrush_GetGradientStopCollection



;#######################################################################################################################################################################
;# ID2D1RectangleGeometry
;#######################################################################################################################################################################
#cs   ID2D1RectangleGeometry
	Method ...: GetRect (struct*)
	Info .....:     Retrieves the rectangle that describes the rectangle geometry's dimensions.
	Param ....:         $tRect  [out]  <$tagD2D1_RECT_F>  Contains a pointer to a rectangle that describes the rectangle geometry's dimensions when this method returns. You must allocate storage for this parameter.
#ce
; _D2D_RectangleGeometry_GetRect



;#######################################################################################################################################################################
;# ID2D1RenderTarget
;#######################################################################################################################################################################
#cs   ID2D1RenderTarget
	Method ...: BeginDraw ()
	Info .....:     Initiates drawing on this render target.
	Param ....:         This method has no parameters.

	Method ...: Clear (struct*)
	Info .....:     Clears the drawing area to the specified color.
	Param ....:         $tClearColor  [in, optional]  <$tagD2D1_COLOR_F>  The color to which the drawing area is cleared, or NULL for transparent black.

	Method ...: CreateBitmap (struct, struct*, uint, struct*, ptr*)
	Info .....:     Creates a Direct2D bitmap from a pointer to in-memory source data.
	Param ....:         $tSize              [in]            <$tagD2D1_SIZE_U>             The dimension of the bitmap to create in pixels.
	Param ....:         $pSrcData           [in, optional]  <ptr>                         A pointer to the memory location of the image data, or NULL to create an uninitialized bitmap.
	Param ....:         $iPitch             [in]            <uint>                        The byte count of each scanline, which is equal to (the image width in pixels × the number of bytes per pixel) + memory padding. If srcData is NULL, this value is ignored. (Note that pitch is also sometimes called stride.)
	Param ....:         $tBitmapProperties  [in]            <$tagD2D1_BITMAP_PROPERTIES>  The pixel format and dots per inch (DPI) of the bitmap to create.
	Param ....:         $oBitmap            [out]           <ID2D1Bitmap>                 When this method returns, contains a pointer to a pointer to the new bitmap. This parameter is passed uninitialized.

	Method ...: CreateBitmapBrush (struct*, struct*, struct*, ptr*)
	Info .....:     Creates an from the specified bitmap.
	Param ....:         $oBitmap                 [in]            <ID2D1Bitmap>                       The bitmap contents of the new brush.
	Param ....:         $tBitmapBrushProperties  [in, optional]  <$tagD2D1_BITMAP_BRUSH_PROPERTIES>  The extend modes and interpolation mode of the new brush, or NULL. If you set this parameter to NULL, the brush defaults to the horizontal and vertical extend modes and the interpolation mode.
	Param ....:         $tBrushProperties        [in, optional]  <$tagD2D1_BRUSH_PROPERTIES>         A structure that contains the opacity and transform of the new brush, or NULL. If you set this parameter to NULL, the brush sets the opacity member to 1.0F and the transform member to the identity matrix.
	Param ....:         $oBitmapBrush            [out]           <ID2D1BitmapBrush>                  When this method returns, this output parameter contains a pointer to a pointer to the new brush. Pass this parameter uninitialized.

	Method ...: CreateBitmapFromWicBitmap (struct*, struct*, ptr*)
	Info .....:     Creates an by copying the specified Microsoft Windows Imaging Component (WIC) bitmap.
	Param ....:         $oWicBitmapSource   [in]            <IWICBitmapSource>            The WIC bitmap to copy.
	Param ....:         $tBitmapProperties  [in, optional]  <$tagD2D1_BITMAP_PROPERTIES>  The pixel format and DPI of the bitmap to create. The pixel format must match the pixel format of wicBitmapSource, or the method will fail. To prevent a mismatch, you can pass NULL or pass the value obtained from calling the helper function without specifying any parameter values. If both dpiX and dpiY are 0.0f, the default DPI, 96, is used. DPI information embedded in wicBitmapSource is ignored.
	Param ....:         $oBitmap            [out]           <ID2D1Bitmap>                 When this method returns, contains the address of a pointer to the new bitmap. This parameter is passed uninitialized.

	Method ...: CreateCompatibleRenderTarget (struct*, struct*, struct*, uint, ptr*)
	Info .....:     Creates a bitmap render target for use during intermediate offscreen drawing that is compatible with the current render target.
	Param ....:         $tDesiredSize         [in, optional]  <$tagD2D1_SIZE_F>                         The desired size of the new render target in device-independent pixels if it should be different from the original render target, or NULL. For more information, see the Remarks section.
	Param ....:         $tDesiredPixelSize    [in, optional]  <$tagD2D1_SIZE_U>                         The desired size of the new render target in pixels if it should be different from the original render target, or NULL. For more information, see the Remarks section.
	Param ....:         $tDesiredFormat       [in, optional]  <$tagD2D1_PIXEL_FORMAT>                   The desired pixel format and alpha mode of the new render target, or NULL. If the pixel format is set to DXGI_FORMAT_UNKNOWN or if this parameter is null, the new render target uses the same pixel format as the original render target. If the alpha mode is or this parameter is NULL, the alpha mode of the new render target defaults to D2D1_ALPHA_MODE_PREMULTIPLIED. For information about supported pixel formats, see .
	Param ....:         $iOptions             [in]            <$D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS>  A value that specifies whether the new render target must be compatible with GDI.
	Param ....:         $oBitmapRenderTarget  [out]           <ID2D1BitmapRenderTarget>                 When this method returns, contains the address of a pointer to a new bitmap render target. This parameter is passed uninitialized.

	Method ...: CreateGradientStopCollection (struct*, uint, uint, uint, ptr*)
	Info .....:     Creates an from the specified gradient stops that uses the color interpolation gamma and the clamp extend mode.
	Param ....:         $tGradientStops           [in]   <$tagD2D1_GRADIENT_STOP>       A pointer to an array of structures.
	Param ....:         $iGradientStopsCount      [in]   <uint>                         A value greater than or equal to 1 that specifies the number of gradient stops in the gradientStops array.
	Param ....:         $oGradientStopCollection  [out]  <ID2D1GradientStopCollection>  When this method returns, contains a pointer to a pointer to the new gradient stop collection.

	Method ...: CreateLayer (struct*, ptr*)
	Info .....:     Creates a layer resource that can be used with this render target and its compatible render targets. The new layer has the specified initial size.
	Param ....:         $tSize   [in, optional]  <$tagD2D1_SIZE_F>  The initial size of the layer in device-independent pixels, or NULL. If NULL or (0, 0) is specified, no backing store is created behind the layer resource. The layer resource is allocated to the minimum size when is called.
	Param ....:         $oLayer  [out]           <ID2D1Layer>       When the method returns, contains a pointer to a pointer to the new layer. This parameter is passed uninitialized.

	Method ...: CreateLinearGradientBrush (struct*, struct*, struct*, ptr*)
	Info .....:     Creates an that contains the specified gradient stops and has the specified transform and base opacity.
	Param ....:         $tLinearGradientBrushProperties  [in]            <$tagD2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES>  The start and end points of the gradient.
	Param ....:         $tBrushProperties                [in, optional]  <$tagD2D1_BRUSH_PROPERTIES>                  The transform and base opacity of the new brush, or NULL. If this value is NULL, the brush defaults to a base opacity of 1.0f and the identity matrix as its transformation.
	Param ....:         $oGradientStopCollection         [in]            <ID2D1GradientStopCollection>                A collection of structures that describe the colors in the brush's gradient and their locations along the gradient line.
	Param ....:         $oLinearGradientBrush            [out]           <ID2D1LinearGradientBrush>                   When this method returns, contains the address of a pointer to the new brush. This parameter is passed uninitialized.

	Method ...: CreateMesh (ptr*)
	Info .....:     Create a mesh that uses triangles to describe a shape.
	Param ....:         $oMesh  [out]  <ID2D1Mesh>  When this method returns, contains a pointer to a pointer to the new mesh.

	Method ...: CreateRadialGradientBrush (struct*, struct*, struct*, ptr*)
	Info .....:     Creates an that contains the specified gradient stops and has the specified transform and base opacity.
	Param ....:         $tRadialGradientBrushProperties  [in]            <$tagD2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES>  The center, gradient origin offset, and x-radius and y-radius of the brush's gradient.
	Param ....:         $tBrushProperties                [in, optional]  <$tagD2D1_BRUSH_PROPERTIES>                  The transform and base opacity of the new brush, or NULL. If this value is NULL, the brush defaults to a base opacity of 1.0f and the identity matrix as its transformation.
	Param ....:         $oGradientStopCollection         [in]            <ID2D1GradientStopCollection>                A collection of structures that describe the colors in the brush's gradient and their locations along the gradient.
	Param ....:         $oRadialGradientBrush            [out]           <ID2D1RadialGradientBrush>                   When this method returns, contains a pointer to a pointer to the new brush. This parameter is passed uninitialized.

	Method ...: CreateSharedBitmap (struct*, struct*, struct*, ptr*)
	Info .....:     Creates an whose data is shared with another resource.
	Param ....:         $tRiid              [in]            <struct>                      The interface ID of the object supplying the source data.
	Param ....:         $pData              [in, out]       <ptr>                         An , <a class="mtps-external-link" href="http://msdn.microsoft.com/en-us/library/bb174565(VS.85).aspx">IDXGISurface</a>, or an that contains the data to share with the new ID2D1Bitmap. For more information, see the Remarks section.
	Param ....:         $tBitmapProperties  [in, optional]  <$tagD2D1_BITMAP_PROPERTIES>  The pixel format and DPI of the bitmap to create . The <a class="mtps-external-link" href="http://msdn.microsoft.com/en-us/library/bb173059(VS.85).aspx">DXGI_FORMAT</a> portion of the pixel format must match the <a class="mtps-external-link" href="http://msdn.microsoft.com/en-us/library/bb173059(VS.85).aspx">DXGI_FORMAT</a> of data or the method will fail, but the alpha modes don't have to match. To prevent a mismatch, you can pass NULL or the value obtained from the helper function. The DPI settings do not have to match those of data. If both dpiX and dpiY are 0.0f, the DPI of the render target is used.
	Param ....:         $oBitmap            [out]           <ID2D1Bitmap>                 When this method returns, contains the address of a pointer to the new bitmap. This parameter is passed uninitialized.

	Method ...: CreateSolidColorBrush (struct*, struct*, ptr*)
	Info .....:     Creates a new that has the specified color and opacity.
	Param ....:         $tColor            [in]            <$tagD2D1_COLOR_F>           The red, green, blue, and alpha values of the brush's color.
	Param ....:         $tBrushProperties  [in, optional]  <$tagD2D1_BRUSH_PROPERTIES>  The base opacity of the brush.
	Param ....:         $oSolidColorBrush  [out]           <ID2D1SolidColorBrush>       When this method returns, contains the address of a pointer to the new brush. This parameter is passed uninitialized.

	Method ...: DrawBitmap (struct*, struct*, float, uint, struct*)
	Info .....:     Draws the specified bitmap after scaling it to the size of the specified rectangle.
	Param ....:         $oBitmap                [in]            <ID2D1Bitmap>                      The bitmap to render.
	Param ....:         $tDestinationRectangle  [in, optional]  <$tagD2D1_RECT_F>                  The size and position, in device-independent pixels in the render target's coordinate space, of the area to which the bitmap is drawn; NULL to draw the selected portion of the bitmap at the origin of the render target. If the rectangle is specified but not well-ordered, nothing is drawn, but the render target does not enter an error state.
	Param ....:         $fOpacity               [in]            <float>                            A value between 0.0f and 1.0f, inclusive, that specifies an opacity value to apply to the bitmap; this value is multiplied against the alpha values of the bitmap's contents. The default value is 1.0f.
	Param ....:         $iInterpolationMode     [in]            <$D2D1_BITMAP_INTERPOLATION_MODE>  The interpolation mode to use if the bitmap is scaled or rotated by the drawing operation. The default value is .
	Param ....:         $tSourceRectangle       [in, optional]  <$tagD2D1_RECT_F>                  The size and position, in device-independent pixels in the bitmap's coordinate space, of the area within the bitmap to be drawn; NULL to draw the entire bitmap.

	Method ...: DrawEllipse (struct*, struct*, float, struct*)
	Info .....:     Draws the outline of the specified ellipse using the specified stroke style.
	Param ....:         $tEllipse      [in]            <$tagD2D1_ELLIPSE>  The position and radius of the ellipse to draw, in device-independent pixels.
	Param ....:         $oBrush        [in]            <ID2D1Brush>        The brush used to paint the ellipse's outline.
	Param ....:         $fStrokeWidth  [in]            <float>             The width of the stroke, in device-independent pixels. The value must be greater than or equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>  The style of stroke to apply to the ellipse's outline, or NULL to paint a solid stroke.

	Method ...: DrawGeometry (struct*, struct*, float, struct*)
	Info .....:     Draws the outline of the specified geometry using the specified stroke style.
	Param ....:         $oGeometry     [in]            <ID2D1Geometry>     The geometry to draw.
	Param ....:         $oBrush        [in]            <ID2D1Brush>        The brush used to paint the geometry's stroke.
	Param ....:         $fStrokeWidth  [in]            <float>             The width of the stroke, in device-independent pixels. The value must be greater than or equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>  The style of stroke to apply to the geometry's outline, or NULL to paint a solid stroke.

	Method ...: DrawGlyphRun (struct, struct*, struct*, uint)
	Info .....:     Draws the specified glyphs.
	Param ....:         $tBaselineOrigin   [in]  <$tagD2D1_POINT_2F>      The origin, in device-independent pixels, of the glyphs' baseline.
	Param ....:         $oGlyphRun         [in]  <DWRITE_GLYPH_RUN>       The glyphs to render.
	Param ....:         $oForegroundBrush  [in]  <ID2D1Brush>             The brush used to paint the specified glyphs.
	Param ....:         $oMeasuringMode    [in]  <DWRITE_MEASURING_MODE>  A value that indicates how glyph metrics are used to measure text when it is formatted. The default value is .

	Method ...: DrawLine (struct, struct, struct*, float, struct*)
	Info .....:     Draws a line between the specified points using the specified stroke style.
	Param ....:         $tPoint0       [in]            <$tagD2D1_POINT_2F>  The start point of the line, in device-independent pixels.
	Param ....:         $tPoint1       [in]            <$tagD2D1_POINT_2F>  The end point of the line, in device-independent pixels.
	Param ....:         $oBrush        [in]            <ID2D1Brush>         The brush used to paint the line's stroke.
	Param ....:         $fStrokeWidth  [in]            <float>              The width of the stroke, in device-independent pixels. The value must be greater than or equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>   The style of stroke to paint, or NULL to paint a solid line.

	Method ...: DrawRectangle (struct*, struct*, float, struct*)
	Info .....:     Draws the outline of a rectangle that has the specified dimensions and stroke style.
	Param ....:         $tRect         [in]            <$tagD2D1_RECT_F>   The dimensions of the rectangle to draw, in device-independent pixels.
	Param ....:         $oBrush        [in]            <ID2D1Brush>        The brush used to paint the rectangle's stroke.
	Param ....:         $fStrokeWidth  [in]            <float>             The width of the stroke, in device-independent pixels. The value must be greater than or equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>  The style of stroke to paint, or NULL to paint a solid stroke.

	Method ...: DrawRoundedRectangle (struct*, struct*, float, struct*)
	Info .....:     Draws the outline of the specified rounded rectangle using the specified stroke style.
	Param ....:         $tRoundedRect  [in]            <$tagD2D1_ROUNDED_RECT>  The dimensions of the rounded rectangle to draw, in device-independent pixels.
	Param ....:         $oBrush        [in]            <ID2D1Brush>             The brush used to paint the rounded rectangle's outline.
	Param ....:         $fStrokeWidth  [in]            <float>                  The width of the stroke, in device-independent pixels. The value must be greater than or equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>       The style of the rounded rectangle's stroke, or NULL to paint a solid stroke. The default value is NULL.

	Method ...: DrawText (wstr, uint, struct*, struct*, struct*, uint, uint)
	Info .....:     Draws the specified text using the format information provided by an object.
	Param ....:         $sString                  [in]  <wchar>                    A pointer to an array of Unicode characters to draw.
	Param ....:         $iStringLength            [in]  <uint>                     The number of characters in string.
	Param ....:         $oTextFormat              [in]  <IDWriteTextFormat>        An object that describes formatting details of the text to draw, such as the font, the font size, and flow direction.
	Param ....:         $tLayoutRect              [in]  <$tagD2D1_RECT_F>          The size and position of the area in which the text is drawn.
	Param ....:         $oDefaultForegroundBrush  [in]  <ID2D1Brush>               The brush used to paint the text.
	Param ....:         $iOptions                 [in]  <$D2D1_DRAW_TEXT_OPTIONS>  A value that indicates whether the text should be snapped to pixel boundaries and whether the text should be clipped to the layout rectangle. The default value is , which indicates that text should be snapped to pixel boundaries and it should not be clipped to the layout rectangle.
	Param ....:         $oMeasuringMode           [in]  <DWRITE_MEASURING_MODE>    A value that indicates how glyph metrics are used to measure text when it is formatted. The default value is .

	Method ...: DrawTextLayout (struct, struct*, struct*, uint)
	Info .....:     Draws the formatted text described by the specified object.
	Param ....:         $tOrigin                  [in]  <$tagD2D1_POINT_2F>        The point, described in device-independent pixels, at which the upper-left corner of the text described by textLayout is drawn.
	Param ....:         $oTextLayout              [in]  <IDWriteTextLayout>        The formatted text to draw. Any drawing effects that do not inherit from are ignored. If there are drawing effects that inherit from ID2D1Resource that are not brushes, this method fails and the render target is put in an error state.
	Param ....:         $oDefaultForegroundBrush  [in]  <ID2D1Brush>               The brush used to paint any text in textLayout that does not already have a brush associated with it as a drawing effect (specified by the method).
	Param ....:         $iOptions                 [in]  <$D2D1_DRAW_TEXT_OPTIONS>  A value that indicates whether the text should be snapped to pixel boundaries and whether the text should be clipped to the layout rectangle. The default value is , which indicates that text should be snapped to pixel boundaries and it should not be clipped to the layout rectangle.

	Method ...: EndDraw (uint64*, uint64*)
	Info .....:     Ends drawing operations on the render target and indicates the current error state and associated tags.
	Param ....:         $iTag1  [out, optional]  <$D2D1_TAG>  When this method returns, contains the tag for drawing operations that caused errors or 0 if there were no errors. This parameter is passed uninitialized.
	Param ....:         $iTag2  [out, optional]  <$D2D1_TAG>  When this method returns, contains the tag for drawing operations that caused errors or 0 if there were no errors. This parameter is passed uninitialized.

	Method ...: FillEllipse (struct*, struct*)
	Info .....:     Paints the interior of the specified ellipse.
	Param ....:         $tEllipse  [in]  <$tagD2D1_ELLIPSE>  The position and radius, in device-independent pixels, of the ellipse to paint.
	Param ....:         $oBrush    [in]  <ID2D1Brush>        The brush used to paint the interior of the ellipse.

	Method ...: FillGeometry (struct*, struct*, struct*)
	Info .....:     Paints the interior of the specified geometry.
	Param ....:         $oGeometry      [in]            <ID2D1Geometry>  The geometry to paint.
	Param ....:         $oBrush         [in]            <ID2D1Brush>     The brush used to paint the geometry's interior.
	Param ....:         $oOpacityBrush  [in, optional]  <ID2D1Brush>     The opacity mask to apply to the geometry, or NULL for no opacity mask. If an opacity mask (the opacityBrush parameter) is specified, brush must be an that has its x- and y-extend modes set to . For more information, see the Remarks section.

	Method ...: FillMesh (struct*, struct*)
	Info .....:     Paints the interior of the specified mesh.
	Param ....:         $oMesh   [in]  <ID2D1Mesh>   The mesh to paint.
	Param ....:         $oBrush  [in]  <ID2D1Brush>  The brush used to paint the mesh.

	Method ...: FillOpacityMask (struct*, struct*, uint, struct*, struct*)
	Info .....:     Applies the opacity mask described by the specified bitmap to a brush and uses that brush to paint a region of the render target.
	Param ....:         $oOpacityMask           [in]            <ID2D1Bitmap>                 The opacity mask to apply to the brush. The alpha value of each pixel in the region specified by sourceRectangle is multiplied with the alpha value of the brush after the brush has been mapped to the area defined by destinationRectangle.
	Param ....:         $oBrush                 [in]            <ID2D1Brush>                  The brush used to paint the region of the render target specified by destinationRectangle.
	Param ....:         $iContent               [in]            <$D2D1_OPACITY_MASK_CONTENT>  The type of content the opacity mask contains. The value is used to determine the color space in which the opacity mask is blended.
	Param ....:         $tDestinationRectangle  [in, optional]  <$tagD2D1_RECT_F>             The region of the render target to paint, in device-independent pixels, or NULL. If NULL is specified, the brush paints a rectangle the same size as sourceRectangle, but positioned on the origin. If sourceRectangle isn't specified, the brush paints a rectangle the same size as the opacityMask bitmap and positioned on the origin.
	Param ....:         $tSourceRectangle       [in, optional]  <$tagD2D1_RECT_F>             The region of the bitmap to use as the opacity mask, in device-independent pixels, or NULL. If NULL is specified, the entire bitmap is used.

	Method ...: FillRectangle (struct*, struct*)
	Info .....:     Paints the interior of the specified rectangle.
	Param ....:         $tRect   [in]  <$tagD2D1_RECT_F>  The dimension of the rectangle to paint, in device-independent pixels.
	Param ....:         $oBrush  [in]  <ID2D1Brush>       The brush used to paint the rectangle's interior.

	Method ...: FillRoundedRectangle (struct*, struct*)
	Info .....:     Paints the interior of the specified rounded rectangle.
	Param ....:         $tRoundedRect  [in]  <$tagD2D1_ROUNDED_RECT>  The dimensions of the rounded rectangle to paint, in device-independent pixels.
	Param ....:         $oBrush        [in]  <ID2D1Brush>             The brush used to paint the interior of the rounded rectangle.

	Method ...: Flush (uint64*, uint64*)
	Info .....:     Executes all pending drawing commands.
	Param ....:         $iTag1  [out, optional]  <$D2D1_TAG>  When this method returns, contains the tag for drawing operations that caused errors or 0 if there were no errors. This parameter is passed uninitialized.
	Param ....:         $iTag2  [out, optional]  <$D2D1_TAG>  When this method returns, contains the tag for drawing operations that caused errors or 0 if there were no errors. This parameter is passed uninitialized.

	Method ...: GetAntialiasMode ()
	Info .....:     Retrieves the current antialiasing mode for nontext drawing operations.
	Param ....:         This method has no parameters.

	Method ...: GetDpi (float*, float*)
	Info .....:     Return the render target's dots per inch (DPI).
	Param ....:         $fDpiX  [out]  <float>  When this method returns, contains the horizontal DPI of the render target. This parameter is passed uninitialized.
	Param ....:         $fDpiY  [out]  <float>  When this method returns, contains the vertical DPI of the render target. This parameter is passed uninitialized.

	Method ...: GetMaximumBitmapSize ()
	Info .....:     Gets the maximum size, in device-dependent units (pixels), of any one bitmap dimension supported by the render target.
	Param ....:         This method has no parameters.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format and alpha mode of the render target.
	Param ....:         $tD2D1_PIXEL_FORMAT  [OUT]  <$tagD2D1_PIXEL_FORMAT>

	Method ...: GetPixelSize (struct*)
	Info .....:     Returns the size of the render target in device pixels.
	Param ....:         $tD2D1_SIZE_U  [OUT]  <$tagD2D1_SIZE_U>

	Method ...: GetSize (struct*)
	Info .....:     Returns the size of the render target in device-independent pixels.
	Param ....:         $tD2D1_SIZE_F  [OUT]  <$tagD2D1_SIZE_F>

	Method ...: GetTags (uint64*, uint64*)
	Info .....:     Gets the label for subsequent drawing operations.
	Param ....:         $iTag1  [out, optional]  <$D2D1_TAG>  When this method returns, contains the first label for subsequent drawing operations. This parameter is passed uninitialized. If NULL is specified, no value is retrieved for this parameter.
	Param ....:         $iTag2  [out, optional]  <$D2D1_TAG>  When this method returns, contains the second label for subsequent drawing operations. This parameter is passed uninitialized. If NULL is specified, no value is retrieved for this parameter.

	Method ...: GetTextAntialiasMode ()
	Info .....:     Gets the current antialiasing mode for text and glyph drawing operations.
	Param ....:         This method has no parameters.

	Method ...: GetTextRenderingParams (ptr*)
	Info .....:     Retrieves the render target's current text rendering options.
	Param ....:         $oTextRenderingParams  [out]  <IDWriteRenderingParams>  When this method returns, textRenderingParamscontains the address of a pointer to the render target's current text rendering options.

	Method ...: GetTransform (struct*)
	Info .....:     Gets the current transform of the render target.
	Param ....:         $tTransform  [out]  <$tagD2D1_MATRIX_3X2_F>  When this returns, contains the current transform of the render target. This parameter is passed uninitialized.

	Method ...: IsSupported (struct*)
	Info .....:     Indicates whether the render target supports the specified properties.
	Param ....:         $tRenderTargetProperties  [in]  <$tagD2D1_RENDER_TARGET_PROPERTIES>  The render target properties to test.

	Method ...: PopAxisAlignedClip ()
	Info .....:     Removes the last axis-aligned clip from the render target. After this method is called, the clip is no longer applied to subsequent drawing operations.
	Param ....:         This method has no parameters.

	Method ...: PopLayer ()
	Info .....:     Stops redirecting drawing operations to the layer that is specified by the last call.
	Param ....:         This method has no parameters.

	Method ...: PushAxisAlignedClip (struct*, uint)
	Info .....:     Specifies a rectangle to which all subsequent drawing operations are clipped.
	Param ....:         $tClipRect       [in]  <$tagD2D1_RECT_F>       The size and position of the clipping area, in device-independent pixels.
	Param ....:         $iAntialiasMode  [in]  <$D2D1_ANTIALIAS_MODE>  The antialiasing mode that is used to draw the edges of clip rects that have subpixel boundaries, and to blend the clip with the scene contents. The blending is performed once when the method is called, and does not apply to each primitive within the layer.

	Method ...: PushLayer (struct*, struct*)
	Info .....:     Adds the specified layer to the render target so that it receives all subsequent drawing operations until is called.
	Param ....:         $tLayerParameters  [in]  <$tagD2D1_LAYER_PARAMETERS>  The content bounds, geometric mask, opacity, opacity mask, and antialiasing options for the layer.
	Param ....:         $oLayer            [in]  <ID2D1Layer>                 The layer that receives subsequent drawing operations.

	Method ...: RestoreDrawingState (struct*)
	Info .....:     Sets the render target's drawing state to that of the specified .
	Param ....:         $oDrawingStateBlock  [in]  <ID2D1DrawingStateBlock>  The new drawing state of the render target.

	Method ...: SaveDrawingState (struct*)
	Info .....:     Saves the current drawing state to the specified .
	Param ....:         $oDrawingStateBlock  [in, out]  <ID2D1DrawingStateBlock>  When this method returns, contains the current drawing state of the render target. This parameter must be initialized before passing it to the method.

	Method ...: SetAntialiasMode (uint)
	Info .....:     Sets the antialiasing mode of the render target. The antialiasing mode applies to all subsequent drawing operations, excluding text and glyph drawing operations.
	Param ....:         $iAntialiasMode  [in]  <$D2D1_ANTIALIAS_MODE>  The antialiasing mode for future drawing operations.

	Method ...: SetDpi (float, float)
	Info .....:     Sets the dots per inch (DPI) of the render target.
	Param ....:         $fDpiX  [in]  <float>  A value greater than or equal to zero that specifies the horizontal DPI of the render target.
	Param ....:         $fDpiY  [in]  <float>  A value greater than or equal to zero that specifies the vertical DPI of the render target.

	Method ...: SetTags (uint64, uint64)
	Info .....:     Specifies a label for subsequent drawing operations.
	Param ....:         $iTag1  [in]  <$D2D1_TAG>  A label to apply to subsequent drawing operations.
	Param ....:         $iTag2  [in]  <$D2D1_TAG>  A label to apply to subsequent drawing operations.

	Method ...: SetTextAntialiasMode (uint)
	Info .....:     Specifies the antialiasing mode to use for subsequent text and glyph drawing operations.
	Param ....:         $iTextAntialiasMode  [in]  <$D2D1_TEXT_ANTIALIAS_MODE>  The antialiasing mode to use for subsequent text and glyph drawing operations.

	Method ...: SetTextRenderingParams (struct*)
	Info .....:     Specifies text rendering options to be applied to all subsequent text and glyph drawing operations.
	Param ....:         $oTextRenderingParams  [in, optional]  <IDWriteRenderingParams>  The text rendering options to be applied to all subsequent text and glyph drawing operations; NULL to clear current text rendering options.

	Method ...: SetTransform (struct*)
	Info .....:     Applies the specified transform to the render target, replacing the existing transformation. All subsequent drawing operations occur in the transformed space.
	Param ....:         $tTransform  [in]  <$tagD2D1_MATRIX_3X2_F>  The transform to apply to the render target.
#ce


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateBitmap
; Description ...: Creates a Direct2D bitmap from a pointer to in-memory source data.
; Syntax ........: _D2D_RenderTarget_CreateBitmap($oIRenderTarget, $iWidth, $iHeight[, $iFormat = 0[, $iAlphaMode = 0[, $tSrcData = Null[, $iPitch = 0[, $fDpiX = 0[, $fDpiY = 0]]]]]])
; Parameters ....: $oIRenderTarget   -  An ID2D1RenderTarget Object.
;                  $iWidth           -  The horizontal component of this size. The dimension of the bitmap to create in pixels.
;                  $iHeight          -  The vertical component of this size. The dimension of the bitmap to create in pixels.
;                  $iFormat          -  The bitmap's pixel format.
;                  $iAlphaMode       -  The bitmap's alpha mode.
;                  $tSrcData         -  A pointer to the memory location of the image data, or NULL to create an uninitialized bitmap.
;                  $iPitch           -  The byte count of each scanline, which is equal to (the image width in pixels * the number of bytes
;                                       per pixel) + memory padding. If srcData is NULL, this value is ignored. (Note that pitch is also sometimes
;                                       called stride.)
;                  $fDpiX            -  The horizontal dpi of the bitmap.
;                  $fDpiY            -  The vertical dpi of the bitmap.
; Return values .: Success - An ID2D1Bitmap object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateBitmap($oIRenderTarget, $iWidth, $iHeight, $iFormat = $DXGI_FORMAT_UNKNOWN, $iAlphaMode = $D2D1_ALPHA_MODE_UNKNOWN, $tSrcData = Null, $iPitch = 0, $fDpiX = 0, $fDpiY = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tD2D1_BITMAP_PROPERTIES = _D2D1_BITMAP_PROPERTIES($iFormat, $iAlphaMode, $fDpiX, $fDpiY)
	If $iFormat = 0 Then $oIRenderTarget.GetPixelFormat($tD2D1_BITMAP_PROPERTIES)

	Local $pBitmap
	Local $iHResult = $oIRenderTarget.CreateBitmap(_D2D1_SIZE_U($iWidth, $iHeight), $tSrcData, $iPitch, $tD2D1_BITMAP_PROPERTIES, $pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 1, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_ID2D1Bitmap, $tagID2D1Bitmap)
	If Not IsObj($oBitmap) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oBitmap
EndFunc   ;==>_D2D_RenderTarget_CreateBitmap


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateBitmapFromWicBitmap
; Description ...: Creates an ID2D1Bitmap by copying the specified Microsoft Windows Imaging Component (WIC) bitmap.
; Syntax ........: _D2D_RenderTarget_CreateBitmapFromWicBitmap($oIRenderTarget, $oWicBitmapSource[, $iFormat = 0[, $iAlphaMode = 0[, $fDpiX = 0[, $fDpiY = 0]]]])
; Parameters ....: $oIRenderTarget     -  An ID2D1RenderTarget Object.
;                  $oWicBitmapSource   -  The WIC bitmap to copy.
;                  $iFormat            -  The bitmap's pixel format. The pixel format must match the pixel format of wicBitmapSource, or the method will fail.
;                                         To prevent a mismatch, you can pass NULL.
;                  $iAlphaMode         -  The bitmap's alpha mode.
;                  $fDpiX              -  The horizontal dpi of the bitmap. If both dpiX and dpiY are 0.0, the default DPI, 96, is used.
;                  $fDpiY              -  The vertical dpi of the bitmap. If both dpiX and dpiY are 0.0, the default DPI, 96, is used.
; Return values .: Success - An ID2D1Bitmap object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Before Direct2D can load a WIC bitmap, that bitmap must be converted to a supported pixel format and alpha mode.
;                  For a list of supported pixel formats and alpha modes, see Supported Pixel Formats and Alpha Modes.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateBitmapFromWicBitmap($oIRenderTarget, $oWicBitmapSource, $iFormat = 0, $iAlphaMode = 0, $fDpiX = 0, $fDpiY = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oWicBitmapSource) And Not $oWicBitmapSource Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $tD2D1_BITMAP_PROPERTIES = Null
	If $iFormat Or $iAlphaMode Or $fDpiX Or $fDpiY Then $tD2D1_BITMAP_PROPERTIES = _D2D1_BITMAP_PROPERTIES($iFormat, $iAlphaMode, $fDpiX, $fDpiY)

	Local $pBitmap
	Local $iHResult = $oIRenderTarget.CreateBitmapFromWicBitmap($oWicBitmapSource, $tD2D1_BITMAP_PROPERTIES, $pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 2, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_ID2D1Bitmap, $tagID2D1Bitmap)
	If Not IsObj($oBitmap) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oBitmap
EndFunc   ;==>_D2D_RenderTarget_CreateBitmapFromWicBitmap



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateSharedBitmap
; Description ...: Creates an ID2D1Bitmap whose data is shared with another resource.
; Syntax ........: _D2D_RenderTarget_CreateSharedBitmap($oIRenderTarget, $sIID, $oData[, $iFormat = $DXGI_FORMAT_UNKNOWN[, $iAlphaMode = $D2D1_ALPHA_MODE_UNKNOWN[, $fDpiX = 0[, $fDpiY = 0]]]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $sIID           - The interface ID of the object supplying the source data.
;                  $oData          - An void object. An ID2D1Bitmap, IDXGISurface, or an IWICBitmapLock that contains the data to share with
;                                    the new ID2D1Bitmap. For more information, see the Remarks section.
;                  $iFormat        - [optional] The bitmap's pixel format. The DXGI_FORMAT portion of the pixel format must match the DXGI_FORMAT
;                                               of "data" or the method will fail, but the alpha modes don't have to match. To prevent a mismatch,
;                                               you can pass NULL.
;                  $iAlphaMode     - [optional] A $D2D1_ALPHA_MODE enumeraion. The bitmap's alpha mode.
;                  $fDpiX          - [optional] The horizontal dpi of the bitmap. The DPI settings do not have to match those of "data". If both
;                                               "dpiX" and "dpiY" are 0.0, the DPI of the render target is used.
;                  $fDpiY          - [optional] The vertical dpi of the bitmap. The DPI settings do not have to match those of "data". If both
;                                               "dpiX" and "dpiY" are 0.0, the DPI of the render target is used.
; Return values .: Success - An ID2D1Bitmap object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The CreateSharedBitmap method is useful for efficiently reusing bitmap data and can also be used to provide interoperability
;                  with Direct3D.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateSharedBitmap($oIRenderTarget, $sIID, $oData, $iFormat = $DXGI_FORMAT_UNKNOWN, $iAlphaMode = $D2D1_ALPHA_MODE_UNKNOWN, $fDpiX = 0, $fDpiY = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oData) Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $tGUID = _WinAPI_GUIDFromString($sIID)
	If @error Or Not IsDllStruct($tGUID) Then Return SetError($D2DERR_PARAM, 2, False)

	Local $tD2D1_BITMAP_PROPERTIES = _D2D1_BITMAP_PROPERTIES($iFormat, $iAlphaMode, $fDpiX, $fDpiY)

	Local $pBitmap
	Local $iHResult = $oIRenderTarget.CreateSharedBitmap($tGUID, $oData, $tD2D1_BITMAP_PROPERTIES, $pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 3, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_ID2D1Bitmap, $tagID2D1Bitmap)
	If Not IsObj($oBitmap) Then Return SetError($D2DERR_OBJFAIL, 4, False)
	Return $oBitmap
EndFunc   ;==>_D2D_RenderTarget_CreateSharedBitmap



; _D2D_RenderTarget_CreateBitmapBrush


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateSolidColorBrush
; Description ...: Creates a new ID2D1SolidColorBrush that has the specified color and opacity.
; Syntax ........: _D2D_RenderTarget_CreateSolidColorBrush($oIRenderTarget[, $fRed = 0[, $fGreen = 0[, $fBlue = 0[, $fAlpha = 1[, $fOpacity = 1]]]]])
; Parameters ....: $oIRenderTarget   -  An ID2D1RenderTarget Object.
;                  $fRed             -  The red value of the brush's color.
;                  $fGreen           -  The green value of the brush's color.
;                  $fBlue            -  The blue value of the brush's color.
;                  $fAlpha           -  The alpha channel value of the brush's color.
;                  $fOpacity         -  A value between 0.0f and 1.0f, inclusive, that specifies the degree of opacity of the brush.
; Return values .: Success - An ID2D1SolidColorBrush object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateSolidColorBrush($oIRenderTarget, $fRed = 0, $fGreen = 0, $fBlue = 0, $fAlpha = 1, $fOpacity = 1)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pSolidColorBrush
	Local $iHResult = $oIRenderTarget.CreateSolidColorBrush(_D2D1_COLOR_F($fRed, $fGreen, $fBlue, $fAlpha), _D2D1_BRUSH_PROPERTIES($fOpacity), $pSolidColorBrush)
	If $iHResult Or Not $pSolidColorBrush Then Return SetError($iHResult, 1, False)

	Local $oSolidColorBrush = ObjCreateInterface($pSolidColorBrush, $sIID_ID2D1SolidColorBrush, $tagID2D1SolidColorBrush)
	If Not IsObj($oSolidColorBrush) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oSolidColorBrush
EndFunc   ;==>_D2D_RenderTarget_CreateSolidColorBrush


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateGradientStopCollection
; Description ...: Creates an ID2D1GradientStopCollection from the specified gradient stops, color interpolation gamma, and extend mode.
; Syntax ........: _D2D_RenderTarget_CreateGradientStopCollection($oIRenderTarget, $aGradientStops[, $iGamma = 0[, $iExtendMode = 0]])
; Parameters ....: $oIRenderTarget   -  An ID2D1RenderTarget Object.
;                  $aGradientStops   -  An array of $tagD2D1_GRADIENT_STOP structures.
;                  $iGamma           -  The space in which color interpolation between the gradient stops is performed.
;                  $iExtendMode      -  The behavior of the gradient outside the [0,1] normalized range.
; Return values .: Success - An ID2D1GradientStopCollection object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateGradientStopCollection($oIRenderTarget, $aGradientStops, $iGamma = 0, $iExtendMode = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsArray($aGradientStops) Or UBound($aGradientStops, 0) <> 1 Then Return SetError($D2DERR_PARAM, 1, False)

	Local $iCount = $aGradientStops[0]
	If Not $iCount Or $iCount >= UBound($aGradientStops) Then $iCount = UBound($aGradientStops) - 1
	Local $tGradientStops = DllStructCreate("float[" & 5 * $iCount & "];")
	Local $pGradientStops = DllStructGetPtr($tGradientStops)
	Local $iSize = _D2D1_SIZEOF($tagD2D1_GRADIENT_STOP)
	For $i = 0 To $iCount - 1
		If Not IsDllStruct($aGradientStops[$i + 1]) Then Return SetError($D2DERR_PARAM, 2, False)
		DllCall("kernel32.dll", "none", "RtlMoveMemory", "struct*", $pGradientStops + $iSize * $i, "struct*", $aGradientStops[$i + 1], "ulong_ptr", $iSize)
	Next

	Local $pGradientStopCollection
	Local $iHResult = $oIRenderTarget.CreateGradientStopCollection($tGradientStops, $iCount, $iGamma, $iExtendMode, $pGradientStopCollection)
	If $iHResult Or Not $pGradientStopCollection Then Return SetError($iHResult, 3, False)

	Local $oGradientStopCollection = ObjCreateInterface($pGradientStopCollection, $sIID_ID2D1GradientStopCollection, $tagID2D1GradientStopCollection)
	If Not IsObj($oGradientStopCollection) Then Return SetError($D2DERR_OBJFAIL, 4, False)
	Return $oGradientStopCollection
EndFunc   ;==>_D2D_RenderTarget_CreateGradientStopCollection



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateLinearGradientBrush
; Description ...: Creates an ID2D1LinearGradientBrush that contains the specified gradient stops and has the specified transform and base opacity.
; Syntax ........: _D2D_RenderTarget_CreateLinearGradientBrush($oIRenderTarget, $oGradientStopCollection[, $fStartPointX = 0[, $fStartPointY = 0[, $fEndPointX = 0[, $fEndPointY = 0[, $fOpacity = 1[, $tTransform = Null]]]]]])
; Parameters ....: $oIRenderTarget          - This ID2D1RenderTarget object
;                  $oGradientStopCollection - An ID2D1GradientStopCollection object. A collection of D2D1_GRADIENT_STOP structures that describe
;                                             the colors in the brush's gradient and their locations along the gradient line.
;                  $fStartPointX            - [optional] The x-coordinate of the starting point of the gradient axis in the brush's coordinate space.
;                  $fStartPointY            - [optional] The y-coordinate of the the starting point of the gradient axis in the brush's coordinate space.
;                  $fEndPointX              - [optional] The x-coordinate of the endpoint of the gradient axis in the brush's coordinate space.
;                  $fEndPointY              - [optional] The y-coordinate of the endpoint of the gradient axis in the brush's coordinate space.
;                  $fOpacity                - [optional] A value between 0.0 and 1.0, inclusive, that specifies the degree of opacity of the brush.
;                  $tTransform              - [optional] A $tagD2D1_MATRIX_3X2_F structure. The transformation that is applied to the brush.
; Return values .: Success - An ID2D1LinearGradientBrush object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateLinearGradientBrush($oIRenderTarget, $oGradientStopCollection, $fStartPointX = 0, $fStartPointY = 0, $fEndPointX = 0, $fEndPointY = 0, $fOpacity = 1, $tTransform = Null)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oGradientStopCollection) Then Return SetError($D2DERR_NOOBJ, 1, False)
	Local $tD2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES = _D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES($fStartPointX, $fStartPointY, $fEndPointX, $fEndPointY)
	Local $tD2D1_BRUSH_PROPERTIES = _D2D1_BRUSH_PROPERTIES($fOpacity, $tTransform)

	Local $pLinearGradientBrush
	Local $iHResult = $oIRenderTarget.CreateLinearGradientBrush($tD2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES, $tD2D1_BRUSH_PROPERTIES, $oGradientStopCollection, $pLinearGradientBrush)
	If $iHResult Or Not $pLinearGradientBrush Then Return SetError($iHResult, 2, False)

	Local $oLinearGradientBrush = ObjCreateInterface($pLinearGradientBrush, $sIID_ID2D1LinearGradientBrush, $tagID2D1LinearGradientBrush)
	If Not IsObj($oLinearGradientBrush) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oLinearGradientBrush
EndFunc   ;==>_D2D_RenderTarget_CreateLinearGradientBrush


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateRadialGradientBrush
; Description ...: Creates an ID2D1RadialGradientBrush that contains the specified gradient stops and has the specified transform and base opacity.
; Syntax ........: _D2D_RenderTarget_CreateRadialGradientBrush($oIRenderTarget, $oGradientStopCollection[, $fCenterX = 0[, $fCenterY = 0[, $fRadiusX = 0[, $fRadiusY = 0[, $fOriginX = 0[, $fOriginY = 0[, $fOpacity = 1[, $tMatrix = Null]]]]]]]])
; Parameters ....: $oIRenderTarget            -  An ID2D1RenderTarget Object.
;                  $oGradientStopCollection   -  An ID2D1GradientStopCollection object that describe the colors in the brush's gradient
;                                                and their locations along the gradient.
;                  $fCenterX                  -  The x-coordinate of the center of the gradient ellipse.
;                  $fCenterY                  -  The y-coordinate of the center of the gradient ellipse.
;                  $fRadiusX                  -  The x-radius of the gradient ellipse.
;                  $fRadiusY                  -  The y-radius of the gradient ellipse.
;                  $fOriginX                  -  The x-offset of the gradient origin relative to the gradient ellipse's center.
;                  $fOriginY                  -  The y-offset of the gradient origin relative to the gradient ellipse's center.
;                  $fOpacity                  -  A value between 0.0 and 1.0, inclusive, that specifies the degree of opacity of the brush.
;                  $tMatrix                   -  The transformation that is applied to the brush, or NULL.
; Return values .: Success - An ID2D1RadialGradientBrush object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateRadialGradientBrush($oIRenderTarget, $oGradientStopCollection, $fCenterX = 0, $fCenterY = 0, $fRadiusX = 0, $fRadiusY = 0, $fOriginX = 0, $fOriginY = 0, $fOpacity = 1, $tMatrix = Null)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oGradientStopCollection) Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $tD2D1_BRUSH_PROPERTIES = _D2D1_BRUSH_PROPERTIES($fOpacity, $tMatrix)

	Local $pRadialGradientBrush
	Local $iHResult = $oIRenderTarget.CreateRadialGradientBrush(_D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES($fCenterX, $fCenterY, $fOriginX, $fOriginY, $fRadiusX, $fRadiusY), $tD2D1_BRUSH_PROPERTIES, $oGradientStopCollection, $pRadialGradientBrush)
	If $iHResult Or Not $pRadialGradientBrush Then Return SetError($iHResult, 2, False)

	Local $oRadialGradientBrush = ObjCreateInterface($pRadialGradientBrush, $sIID_ID2D1RadialGradientBrush, $tagID2D1RadialGradientBrush)
	If Not IsObj($oRadialGradientBrush) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oRadialGradientBrush
EndFunc   ;==>_D2D_RenderTarget_CreateRadialGradientBrush


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateCompatibleRenderTarget
; Description ...: Creates a bitmap render target for use during intermediate offscreen drawing that is compatible with the current render target.
; Syntax ........: _D2D_RenderTarget_CreateCompatibleRenderTarget($oIRenderTarget[, $fWidth = 0[, $fHeight = 0[, $iWidthPixel = 0[, $iHeightPixel = 0[, $iFormat = 0[, $iAlphaMode = 0[, $iOptions = 0]]]]]]])
; Parameters ....: $oIRenderTarget   -  An ID2D1RenderTarget Object.
;                  $fWidth           -  The horizontal size of the new render target in device-independent pixels if it should be different
;                                       from the original render target, or NULL.
;                  $fHeight          -  The vertical size of the new render target in device-independent pixels if it should be different from
;                                       the original render target, or NULL.
;                  $iWidthPixel      -  The horizontal size of the new render target in pixels if it should be different from the original
;                                       render target, or NULL.
;                  $iHeightPixel     -  The vertical size of the new render target in pixels if it should be different from the original render
;                                       target, or NULL.
;                  $iFormat          -  The desired pixel format of the new render target, or NULL.
;                  $iAlphaMode       -  The desired alpha mode of the new render target, or NULL.
;                  $iOptions         -  A value that specifies whether the new render target must be compatible with GDI.
; Return values .: Success - An ID2D1BitmapRenderTarget object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: This method creates a render target that can be used for intermediate offscreen drawing. The intermediate render
;                  target is created in the same location (on the same adapter or in system memory) as the original render target,
;                  which allows efficient rendering of the intermediate results to the final target.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateCompatibleRenderTarget($oIRenderTarget, $fWidth = 0, $fHeight = 0, $iWidthPixel = 0, $iHeightPixel = 0, $iFormat = 0, $iAlphaMode = 0, $iOptions = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tDesiredSize = Null, $tDesiredPixelSize = Null, $tDesiredFormat = Null
	If $fWidth > 0 And $fHeight > 0 Then $tDesiredSize = _D2D1_SIZE_F($fWidth, $fHeight)
	If $iWidthPixel > 0 And $iHeightPixel > 0 Then $tDesiredPixelSize = _D2D1_SIZE_U($iWidthPixel, $iHeightPixel)
	If $iFormat <> 0 Or $iAlphaMode <> 0 Then $tDesiredFormat = _D2D1_PIXEL_FORMAT($iFormat, $iAlphaMode)

	Local $pBitmapRenderTarget
	Local $iHResult = $oIRenderTarget.CreateCompatibleRenderTarget($tDesiredSize, $tDesiredPixelSize, $tDesiredFormat, $iOptions, $pBitmapRenderTarget)
	If $iHResult Or Not $pBitmapRenderTarget Then Return SetError($iHResult, 1, False)

	Local $oBitmapRenderTarget = ObjCreateInterface($pBitmapRenderTarget, $sIID_ID2D1BitmapRenderTarget, $tagID2D1BitmapRenderTarget)
	If Not IsObj($oBitmapRenderTarget) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oBitmapRenderTarget
EndFunc   ;==>_D2D_RenderTarget_CreateCompatibleRenderTarget



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateLayer
; Description ...: Creates a layer resource that can be used with this render target and its compatible render targets. The new layer has the specified initial size.
; Syntax ........: _D2D_RenderTarget_CreateLayer($oIRenderTarget[, $fWidth = 0[, $fHeight = 0]])
; Parameters ....: $oIRenderTarget   -  An ID2D1RenderTarget Object.
;                  $fWidth           -  The initial horizontal size of the layer in device-independent pixels, or NULL. If NULL is specified,
;                                       no backing store is created behind the layer resource. The layer resource is allocated to the minimum
;                                       size when PushLayer is called.
;                  $fHeight          -  The initial vertical size of the layer in device-independent pixels, or NULL. If NULL is specified,
;                                       no backing store is created behind the layer resource. The layer resource is allocated to the minimum
;                                       size when PushLayer is called.
; Return values .: Success - An ID2D1Layer object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Regardless of whether a size is initially specified, the layer automatically resizes as needed.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateLayer($oIRenderTarget, $fWidth = 0, $fHeight = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pLayer
	Local $iHResult = $oIRenderTarget.CreateLayer(_D2D1_SIZE_F($fWidth, $fHeight), $pLayer)
	If $iHResult Or Not $pLayer Then Return SetError($iHResult, 1, False)

	Local $oLayer = ObjCreateInterface($pLayer, $sIID_ID2D1Layer, $tagID2D1Layer)
	If Not IsObj($oLayer) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oLayer
EndFunc   ;==>_D2D_RenderTarget_CreateLayer



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_CreateMesh
; Description ...: Create a mesh that uses triangles to describe a shape.
; Syntax ........: _D2D_RenderTarget_CreateMesh($oIRenderTarget)
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
; Return values .: Success - An ID2D1Mesh object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: To populate a mesh, use its Open method to obtain an ID2D1TessellationSink. To draw the mesh, use the render target's FillMesh method.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_RenderTarget_CreateMesh($oIRenderTarget)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pMesh
	Local $iHResult = $oIRenderTarget.CreateMesh($pMesh)
	If $iHResult Or Not $pMesh Then Return SetError($iHResult, 1, False)

	Local $oMesh = ObjCreateInterface($pMesh, $sIID_ID2D1Mesh, $tagID2D1Mesh)
	If Not IsObj($oMesh) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oMesh
EndFunc   ;==>_D2D_RenderTarget_CreateMesh




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawLine
; Description ...: Draws a line between the specified points using the specified stroke style.
; Syntax ........: _D2D_RenderTarget_DrawLine($oIRenderTarget, $fX1, $fY1, $fX2, $fY2, $oBrush[, $fStrokeWidth = 1[, $oStrokeStyle = Null]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fX1            - The x-coordinate of the start point of the line, in device-independent pixels.
;                  $fY1            - The y-coordinate of the start point of the line, in device-independent pixels.
;                  $fX2            - The x-coordinate of the end point of the line, in device-independent pixels.
;                  $fY2            - The y-coordinate of the end point of the line, in device-independent pixels.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the line's stroke.
;                  $fStrokeWidth   - [optional] The width of the stroke, in device-independent pixels. The value must be greater than or equal
;                                               to 0. If this parameter isn't specified, it defaults to 1. The stroke is centered on the line.
;                  $oStrokeStyle   - [optional] An ID2D1StrokeStyle object. The style of stroke to paint, or NULL to paint a solid line.
; Return values .: Success - void
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: This method doesn't return an error code if it fails. To determine whether a drawing operation (such as DrawLine) failed,
;                  check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush methods.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawLine($oIRenderTarget, $fX1, $fY1, $fX2, $fY2, $oBrush, $fStrokeWidth = 1, $oStrokeStyle = Null)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If $oStrokeStyle <> Null And Not IsObj($oStrokeStyle) Then Return SetError($D2DERR_NOOBJ, 2, False)

	$oIRenderTarget.DrawLine(_D2D1_POINT_2F($fX1, $fY1), _D2D1_POINT_2F($fX2, $fY2), $oBrush, $fStrokeWidth, $oStrokeStyle)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawLine




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawRectangle
; Description ...: Draws the outline of a rectangle that has the specified dimensions and stroke style.
; Syntax ........: _D2D_RenderTarget_DrawRectangle($oIRenderTarget, $fLeft, $fTop, $fRight, $fBottom, $oBrush[, $fStrokeWidth = 1[, $oStrokeStyle = Null]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fLeft          - The x-coordinate of the upper-left corner of the rectangle.
;                  $fTop           - The y-coordinate of the upper-left corner of the rectangle.
;                  $fRight         - The x-coordinate of the lower-right corner of the rectangle.
;                  $fBottom        - The y-coordinate of the lower-right corner of the rectangle.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the rectangle's stroke.
;                  $fStrokeWidth   - [optional] The width of the stroke, in device-independent pixels. The value must be greater than or equal
;                                               to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
;                  $oStrokeStyle   - [optional] An ID2D1StrokeStyle object. The style of stroke to paint, or NULL to paint a solid stroke.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: When this method fails, it does not return an error code. To determine whether a drawing method (such as DrawRectangle) failed,
;                  check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush method.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawRectangle($oIRenderTarget, $fLeft, $fTop, $fRight, $fBottom, $oBrush, $fStrokeWidth = 1, $oStrokeStyle = Null)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If $oStrokeStyle <> Null And Not IsObj($oStrokeStyle) Then Return SetError($D2DERR_NOOBJ, 2, False)

	$oIRenderTarget.DrawRectangle(_D2D1_RECT_F($fLeft, $fTop, $fRight, $fBottom), $oBrush, $fStrokeWidth, $oStrokeStyle)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawRectangle





; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_FillRectangle
; Description ...: Paints the interior of the specified rectangle.
; Syntax ........: _D2D_RenderTarget_FillRectangle($oIRenderTarget, $fLeft, $fTop, $fRight, $fBottom, $oBrush)
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fLeft          - The x-coordinate of the upper-left corner of the rectangle.
;                  $fTop           - The y-coordinate of the upper-left corner of the rectangle.
;                  $fRight         - The x-coordinate of the lower-right corner of the rectangle.
;                  $fBottom        - The y-coordinate of the lower-right corner of the rectangle.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the rectangle's interior.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: This method doesn't return an error code if it fails. To determine whether a drawing operation (such as FillRectangle) failed,
;                  check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush methods.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_FillRectangle($oIRenderTarget, $fLeft, $fTop, $fRight, $fBottom, $oBrush)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 1, False)

	$oIRenderTarget.FillRectangle(_D2D1_RECT_F($fLeft, $fTop, $fRight, $fBottom), $oBrush)

	Return True
EndFunc   ;==>_D2D_RenderTarget_FillRectangle



; _D2D_RenderTarget_DrawRoundedRectangle
; _D2D_RenderTarget_FillRoundedRectangle



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawEllipse
; Description ...: Draws the outline of the specified ellipse using the specified stroke style.
; Syntax ........: _D2D_RenderTarget_DrawEllipse($oIRenderTarget, $fX, $fY, $fRadiusX, $fRadiusY, $oBrush[, $fStrokeWidth = 1[, $oStrokeStyle = Null]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fX             - The x-coordinate of the center point of the ellipse.
;                  $fY             - The y-coordinate of the center point of the ellipse.
;                  $fRadiusX       - The X-radius of the ellipse.
;                  $fRadiusY       - The Y-radius of the ellipse.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the ellipse's outline.
;                  $fStrokeWidth   - [optional] The width of the stroke, in device-independent pixels. The value must be greater than or equal
;                                               to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
;                  $oStrokeStyle   - [optional] An ID2D1StrokeStyle object. The style of stroke to apply to the ellipse's outline, or NULL to
;                                               paint a solid stroke.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The DrawEllipse method doesn't return an error code if it fails. To determine whether a drawing operation (such as DrawEllipse)
;                  failed, check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush methods.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawEllipse($oIRenderTarget, $fX, $fY, $fRadiusX, $fRadiusY, $oBrush, $fStrokeWidth = 1, $oStrokeStyle = Null)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If $oStrokeStyle <> Null And Not IsObj($oStrokeStyle) Then Return SetError($D2DERR_NOOBJ, 2, False)

	$oIRenderTarget.DrawEllipse(_D2D1_ELLIPSE($fX, $fY, $fRadiusX, $fRadiusY), $oBrush, $fStrokeWidth, $oStrokeStyle)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawEllipse



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_FillEllipse
; Description ...: Paints the interior of the specified ellipse.
; Syntax ........: _D2D_RenderTarget_FillEllipse($oIRenderTarget, $fX, $fY, $fRadiusX, $fRadiusY, $oBrush)
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fX             - The x-coordinate of the center point of the ellipse.
;                  $fY             - The y-coordinate of the center point of the ellipse.
;                  $fRadiusX       - The X-radius of the ellipse.
;                  $fRadiusY       - The Y-radius of the ellipse.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the interior of the ellipse.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: This method doesn't return an error code if it fails. To determine whether a drawing operation (such as FillEllipse) failed,
;                  check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush methods.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_FillEllipse($oIRenderTarget, $fX, $fY, $fRadiusX, $fRadiusY, $oBrush)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 1, False)

	$oIRenderTarget.FillEllipse(_D2D1_ELLIPSE($fX, $fY, $fRadiusX, $fRadiusY), $oBrush)

	Return True
EndFunc   ;==>_D2D_RenderTarget_FillEllipse




; _D2D_RenderTarget_DrawGeometry
; _D2D_RenderTarget_FillGeometry
; _D2D_RenderTarget_FillMesh
; _D2D_RenderTarget_FillOpacityMask



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawBitmap
; Description ...: Draws the specified bitmap after scaling it to the size of the specified rectangle.
; Syntax ........: _D2D_RenderTarget_DrawBitmap($oIRenderTarget, $oBitmap[, $fDstLeft = 0[, $fDstTop = 0[, $fOpacity = 1[, $iInterpolationMode = 0[, $fDstRight = 0[, $fDstBottom = 0[, $fSrcLeft = 0[, $fSrcTop = 0[, $fSrcRight = 0[, $fSrcBottom = 0]]]]]]]]]])
; Parameters ....: $oIRenderTarget     - This ID2D1RenderTarget object
;                  $oBitmap            - An ID2D1Bitmap object. The bitmap to render.
;                  $fDstLeft           - [optional] The x-coordinate of the upper-left corner of the area to which the bitmap is drawn; NULL
;                                                   to draw the selected portion of the bitmap at the origin of the render target.
;                  $fDstTop            - [optional] The y-coordinate of the upper-left corner of the area to which the bitmap is drawn; NULL
;                                                   to draw the selected portion of the bitmap at the origin of the render target.
;                  $fOpacity           - [optional] A value between 0.0 and 1.0, inclusive, that specifies an opacity value to apply to the bitmap;
;                                                   this value is multiplied against the alpha values of the bitmap's contents. The default value
;                                                   is 1.0.
;                  $iInterpolationMode - [optional] A $D2D1_BITMAP_INTERPOLATION_MODE enumeraion. The interpolation mode to use if the bitmap
;                                                   is scaled or rotated by the drawing operation. The default value is D2D1_BITMAP_INTERPOLATION_MODE_LINEAR.
;                  $fDstRight          - [optional] The x-coordinate of the lower-right corner of the area to which the bitmap is drawn; NULL
;                                                   to draw the selected portion of the bitmap at the origin of the render target.
;                  $fDstBottom         - [optional] The y-coordinate of the lower-right corner of the area to which the bitmap is drawn; NULL
;                                                   to draw the selected portion of the bitmap at the origin of the render target.
;                  $fSrcLeft           - [optional] The x-coordinate of the upper-left corner of the area within the bitmap to be drawn; NULL
;                                                   to draw the entire bitmap.
;                  $fSrcTop            - [optional] The y-coordinate of the upper-left corner of the area within the bitmap to be drawn; NULL
;                                                   to draw the entire bitmap.
;                  $fSrcRight          - [optional] The x-coordinate of the lower-right corner of the area within the bitmap to be drawn; NULL
;                                                   to draw the entire bitmap.
;                  $fSrcBottom         - [optional] The y-coordinate of the lower-right corner of the area within the bitmap to be drawn; NULL
;                                                   to draw the entire bitmap.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: This method doesn't return an error code if it fails. To determine whether a drawing operation (such as DrawBitmap) failed,
;                  check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush methods.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawBitmap($oIRenderTarget, $oBitmap, $fDstLeft = 0, $fDstTop = 0, $fOpacity = 1, $iInterpolationMode = 0, $fDstRight = 0, $fDstBottom = 0, $fSrcLeft = 0, $fSrcTop = 0, $fSrcRight = 0, $fSrcBottom = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBitmap) Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $tDst = Null, $tSrc = Null
	If $fDstLeft Or $fDstTop Or $fDstRight Or $fDstBottom Then
		$tDst = _D2D1_RECT_F($fDstLeft, $fDstTop, $fDstRight, $fDstBottom)
		If $fDstRight = 0 And $fDstBottom = 0 Then
			$oBitmap.GetSize(DllStructGetPtr($tDst, "Right"))
			$tDst.Right += $tDst.Left
			$tDst.Bottom += $tDst.Top
		EndIf
	EndIf
	If $fSrcLeft Or $fSrcTop Or $fSrcRight Or $fSrcBottom Then $tSrc = _D2D1_RECT_F($fSrcLeft, $fSrcTop, $fSrcRight, $fSrcBottom)

	$oIRenderTarget.DrawBitmap($oBitmap, $tDst, $fOpacity, $iInterpolationMode, $tSrc)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawBitmap




; _D2D_RenderTarget_DrawText
; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawText
; Description ...: Draws the specified text using the format information provided by an IDWriteTextFormat object.
; Syntax ........: _D2D_RenderTarget_DrawText($oIRenderTarget, $sString, $oTextFormat, $fLeft, $fTop, $fRight, $fBottom, $oBrush[, $iOptions = 0[, $iMeasuringMode = 0]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $sString        - A string to draw.
;                  $oTextFormat    - An IDWriteTextFormat object. An object that describes formatting details of the text to draw, such as the
;                                    font, the font size, and flow direction.
;                  $fLeft          - The x-coordinate of the upper-left corner of the area in which the text is drawn.
;                  $fTop           - The y-coordinate of the upper-left corner of the area in which the text is drawn.
;                  $fRight         - The x-coordinate of the lower-right corner of the area in which the text is drawn.
;                  $fBottom        - The y-coordinate of the lower-right corner of the area in which the text is drawn.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the text.
;                  $iOptions       - [optional] A $D2D1_DRAW_TEXT_OPTIONS enumeraion. A value that indicates whether the text should be snapped
;                                               to pixel boundaries and whether the text should be clipped to the layout rectangle. The default
;                                               value is D2D1_DRAW_TEXT_OPTIONS_NONE, which indicates that text should be snapped to pixel boundaries
;                                               and it should not be clipped to the layout rectangle.
;                  $iMeasuringMode - [optional] A $DWRITE_MEASURING_MODE enumeraion. A value that indicates how glyph metrics are used to measure
;                                               text when it is formatted. The default value is DWRITE_MEASURING_MODE_NATURAL.
; Return values .: Success - void
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: To create an IDWriteTextFormat object, create an IDWriteFactory and call its CreateTextFormat method.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawText($oIRenderTarget, $sString, $oTextFormat, $fLeft, $fTop, $fRight, $fBottom, $oBrush, $iOptions = 0, $iMeasuringMode = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oTextFormat) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 2, False)

	$oIRenderTarget.DrawText($sString, StringLen($sString), $oTextFormat, _D2D1_RECT_F($fLeft, $fTop, $fRight, $fBottom), $oBrush, $iOptions, $iMeasuringMode)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawText




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawTextLayout
; Description ...: Draws the formatted text described by the specified IDWriteTextLayout object.
; Syntax ........: _D2D_RenderTarget_DrawTextLayout($oIRenderTarget, $fX, $fY, $oTextLayout, $oBrush[, $iOptions = $D2D1_DRAW_TEXT_OPTIONS_NONE])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fX             - The x-coordinate of the point, described in device-independent pixels, at which the upper-left corner of
;                                    the text described by "textLayout" is drawn.
;                  $fY             - The y-coordinate of the point, described in device-independent pixels, at which the upper-left corner of
;                                    the text described by "textLayout" is drawn.
;                  $oTextLayout    - An IDWriteTextLayout object. The formatted text to draw. Any drawing effects that do not inherit from ID2D1Resource
;                                    are ignored. If there are drawing effects that inherit from ID2D1Resource that are not brushes, this method
;                                    fails and the render target is put in an error state.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint any text in "textLayout" that does not already have a brush
;                                    associated with it as a drawing effect (specified by the IDWriteTextLayout::SetDrawingEffect method).
;                  $iOptions       - [optional] A $D2D1_DRAW_TEXT_OPTIONS enumeraion. A value that indicates whether the text should be snapped
;                                               to pixel boundaries and whether the text should be clipped to the layout rectangle. The default
;                                               value is D2D1_DRAW_TEXT_OPTIONS_NONE, which indicates that text should be snapped to pixel boundaries
;                                               and it should not be clipped to the layout rectangle.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: When drawing the same text repeatedly, using the DrawTextLayout method is more efficient than using the DrawText method because
;                  the text doesn't need to be formatted and the layout processed with each call.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawTextLayout($oIRenderTarget, $fX, $fY, $oTextLayout, $oBrush, $iOptions = $D2D1_DRAW_TEXT_OPTIONS_NONE)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oTextLayout) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 2, False)

	$oIRenderTarget.DrawTextLayout(_D2D1_POINT_2F($fX, $fY), $oTextLayout, $oBrush, $iOptions)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawTextLayout





; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_DrawGlyphRun
; Description ...: Draws the specified glyphs.
; Syntax ........: _D2D_RenderTarget_DrawGlyphRun($oIRenderTarget, $tGlyphIndices, $iGlyphCount, $oFontFace, $fFontEmSize, $oBrush, $fBaselineX, $fBaselineY[, $tGlyphAdvances = Null[, $tGlyphOffsets = Null[, $bIsSideways = False[, $iBidiLevel = 0[, $iMeasuringMode = $DWRITE_MEASURING_MODE_NATURAL]]]]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $tGlyphIndices  - A $tagUINT16 structure. A pointer to an array of indices to render for the glyph run.
;                  $iGlyphCount    - The number of glyphs in the glyph run.
;                  $oFontFace      - An IDWriteFontFace object. The physical font face object to draw with.
;                  $fFontEmSize    - The logical size of the font in DIPs (equals 1/96 inch), not points.
;                  $oBrush         - An ID2D1Brush object. The brush used to paint the specified glyphs.
;                  $fBaselineX     - The x-coordinate of the origin, in device-independent pixels, of the glyphs' baseline.
;                  $fBaselineY     - The y-coordinate of the origin, in device-independent pixels, of the glyphs' baseline.
;                  $tGlyphAdvances - [optional] A $tagFLOAT structure. A pointer to an array containing glyph advance widths for the glyph run.
;                  $tGlyphOffsets  - [optional] A $tagDWRITE_GLYPH_OFFSET structure. A pointer to an array containing glyph offsets for the glyph run.
;                  $bIsSideways    - [optional] If true, specifies that glyphs are rotated 90 degrees to the left and vertical metrics are used.
;                                               Vertical writing is achieved by specifying isSideways = true and rotating the entire run 90 degrees
;                                               to the right via a rotate transform.
;                  $iBidiLevel     - [optional] The implicit resolved bidi level of the run. Odd levels indicate right-to-left languages like
;                                               Hebrew and Arabic, while even levels indicate left-to-right languages like English and Japanese (when written horizontally).
;                                               For right-to-left languages, the text origin is on the right, and text should be drawn to the left.
;                  $iMeasuringMode - [optional] A $DWRITE_MEASURING_MODE enumeraion. A value that indicates how glyph metrics are used to measure
;                                               text when it is formatted. The default value is DWRITE_MEASURING_MODE_NATURAL.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: This method doesn't return an error code if it fails. To determine whether a drawing operation (such as DrawGlyphRun) failed,
;                  check the result returned by the ID2D1RenderTarget::EndDraw or ID2D1RenderTarget::Flush methods.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_DrawGlyphRun($oIRenderTarget, $tGlyphIndices, $iGlyphCount, $oFontFace, $fFontEmSize, $oBrush, $fBaselineX, $fBaselineY, $tGlyphAdvances = Null, $tGlyphOffsets = Null, $bIsSideways = False, $iBidiLevel = 0, $iMeasuringMode = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oFontFace) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If Not IsObj($oBrush) Then Return SetError($D2DERR_NOOBJ, 2, False)

	Local $tD2D1_POINT_2F = _D2D1_POINT_2F($fBaselineX, $fBaselineY)
	Local $tDWRITE_GLYPH_RUN = __D2D_GLYPH_RUN($oFontFace, $fFontEmSize, $iGlyphCount, $tGlyphIndices, $tGlyphAdvances, $tGlyphOffsets, $bIsSideways, $iBidiLevel)

	$oIRenderTarget.DrawGlyphRun($tD2D1_POINT_2F, $tDWRITE_GLYPH_RUN, $oBrush, $iMeasuringMode)

	Return True
EndFunc   ;==>_D2D_RenderTarget_DrawGlyphRun




; _D2D_RenderTarget_SetTransform
; _D2D_RenderTarget_GetTransform
; _D2D_RenderTarget_SetAntialiasMode
; _D2D_RenderTarget_GetAntialiasMode
; _D2D_RenderTarget_SetTextAntialiasMode
; _D2D_RenderTarget_GetTextAntialiasMode
; _D2D_RenderTarget_SetTextRenderingParams
; _D2D_RenderTarget_GetTextRenderingParams
; _D2D_RenderTarget_SetTags
; _D2D_RenderTarget_GetTags
; _D2D_RenderTarget_PushLayer
; _D2D_RenderTarget_PopLayer
; _D2D_RenderTarget_Flush
; _D2D_RenderTarget_SaveDrawingState
; _D2D_RenderTarget_RestoreDrawingState



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_PushAxisAlignedClip
; Description ...: Specifies a rectangle to which all subsequent drawing operations are clipped.
; Syntax ........: _D2D_RenderTarget_PushAxisAlignedClip($oIRenderTarget, $fClipLeft, $fClipTop, $fClipRight, $fClipBottom[, $iAntialiasMode = 0])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fClipLeft      - The x-coordinate of the upper-left corner of the rectangle.
;                  $fClipTop       - The y-coordinate of the upper-left corner of the rectangle.
;                  $fClipRight     - The x-coordinate of the lower-right corner of the rectangle.
;                  $fClipBottom    - The y-coordinate of the lower-right corner of the rectangle.
;                  $iAntialiasMode - [optional] A $D2D1_ANTIALIAS_MODE enumeraion. The antialiasing mode that is used to draw the edges of clip
;                                               rects that have subpixel boundaries, and to blend the clip with the scene contents. The blending
;                                               is performed once when the PopAxisAlignedClip method is called, and does not apply to each primitive
;                                               within the layer.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The "clipRect" is transformed by the current world transform set on the render target. After the transform is applied to the
;                  "clipRect" that is passed in, the axis-aligned bounding box for the "clipRect" is computed. For efficiency, the contents are
;                  clipped to this axis-aligned bounding box and not to the original "clipRect" that is passed in.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _D2D_RenderTarget_PushAxisAlignedClip($oIRenderTarget, $fClipLeft, $fClipTop, $fClipRight, $fClipBottom, $iAntialiasMode = 0)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)
	Local $tD2D1_RECT_F = _D2D1_RECT_F($fClipLeft, $fClipTop, $fClipRight, $fClipBottom)

	$oIRenderTarget.PushAxisAlignedClip($tD2D1_RECT_F, $iAntialiasMode)

	Return True
EndFunc







; _D2D_RenderTarget_PopAxisAlignedClip




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_Clear
; Description ...: Clears the drawing area to the specified color.
; Syntax ........: _D2D_RenderTarget_Clear($oIRenderTarget[, $fR = 0[, $fG = 0[, $fB = 0[, $fA = 1]]]])
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
;                  $fR             - [optional] The red value of the color to which the drawing area is cleared.
;                  $fG             - [optional] The green value of the color to which the drawing area is cleared.
;                  $fB             - [optional] The blue value of the color to which the drawing area is cleared.
;                  $fA             - [optional] The alpha channel value of the color to which the drawing area is cleared.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Direct2D interprets the "clearColor" as straight alpha (not premultiplied). If the render target's alpha mode is D2D1_ALPHA_MODE_IGNORE,
;                  the alpha channel of "clearColor" is ignored and replaced with 1.0f (fully opaque).
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_Clear($oIRenderTarget, $fR = 0, $fG = 0, $fB = 0, $fA = 1)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	$oIRenderTarget.Clear(_D2D1_COLOR_F($fR, $fG, $fB, $fA))

	Return True
EndFunc   ;==>_D2D_RenderTarget_Clear



; _D2D_RenderTarget_BeginDraw
; _D2D_RenderTarget_EndDraw
; _D2D_RenderTarget_GetPixelFormat
; _D2D_RenderTarget_SetDpi
; _D2D_RenderTarget_GetDpi




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_RenderTarget_GetSize
; Description ...: Returns the size of the render target in device-independent pixels.
; Syntax ........: _D2D_RenderTarget_GetSize($oIRenderTarget)
; Parameters ....: $oIRenderTarget - This ID2D1RenderTarget object
; Return values .: Success - A $tagD2D1_SIZE_F structure.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_RenderTarget_GetSize($oIRenderTarget)
	If Not IsObj($oIRenderTarget) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tSize = DllStructCreate($tagD2D1_SIZE_F)
	$oIRenderTarget.GetSize($tSize)

	Return $tSize
EndFunc   ;==>_D2D_RenderTarget_GetSize



; _D2D_RenderTarget_GetPixelSize
; _D2D_RenderTarget_GetMaximumBitmapSize
; _D2D_RenderTarget_IsSupported



;#######################################################################################################################################################################
;# ID2D1Resource
;#######################################################################################################################################################################
#cs   ID2D1Resource
	Method ...: GetFactory (ptr*)
	Info .....:     Retrieves the factory associated with this resource.
	Param ....:         $oFactory  [out]  <ID2D1Factory>  When this method returns, contains a pointer to a pointer to the factory that created this resource. This parameter is passed uninitialized.
#ce
; _D2D_Resource_GetFactory



;#######################################################################################################################################################################
;# ID2D1RoundedRectangleGeometry
;#######################################################################################################################################################################
#cs   ID2D1RoundedRectangleGeometry
	Method ...: GetRoundedRect (struct*)
	Info .....:     Retrieves a rounded rectangle that describes this rounded rectangle geometry.
	Param ....:         $tRoundedRect  [out]  <$tagD2D1_ROUNDED_RECT>  A pointer that receives a rounded rectangle that describes this rounded rectangle geometry. You must allocate storage for this parameter.
#ce
; _D2D_RoundedRectangleGeometry_GetRoundedRect



;#######################################################################################################################################################################
;# ID2D1SimplifiedGeometrySink
;#######################################################################################################################################################################
#cs   ID2D1SimplifiedGeometrySink
	Method ...: AddBeziers (struct*, uint)
	Info .....:     Creates a sequence of cubic Bezier curves and adds them to the geometry sink.
	Param ....:         $tBeziers       [in]  <$tagD2D1_BEZIER_SEGMENT>  A pointer to an array of Bezier segments that describes the Bezier curves to create. A curve is drawn from the geometry sink's current point (the end point of the last segment drawn or the location specified by ) to the end point of the first Bezier segment in the array. if the array contains additional Bezier segments, each subsequent Bezier segment uses the end point of the preceding Bezier segment as its start point.
	Param ....:         $iBeziersCount  [in]  <uint>                     The number of Bezier segments in the beziers array.

	Method ...: AddLines (struct*, uint)
	Info .....:     Creates a sequence of lines using the specified points and adds them to the geometry sink.
	Param ....:         $tPoints       [in]  <$tagD2D1_POINT_2F>  A pointer to an array of one or more points that describe the lines to draw. A line is drawn from the geometry sink's current point (the end point of the last segment drawn or the location specified by ) to the first point in the array. if the array contains additional points, a line is drawn from the first point to the second point in the array, from the second point to the third point, and so on.
	Param ....:         $iPointsCount  [in]  <uint>               The number of points in the points array.

	Method ...: BeginFigure (struct, uint)
	Info .....:     Starts a new figure at the specified point.
	Param ....:         $tStartPoint   [in]  <$tagD2D1_POINT_2F>   The point at which to begin the new figure.
	Param ....:         $iFigureBegin  [in]  <$D2D1_FIGURE_BEGIN>  Whether the new figure should be hollow or filled.

	Method ...: Close ()
	Info .....:     Closes the geometry sink, indicates whether it is in an error state, and resets the sink's error state.
	Param ....:         This method has no parameters.

	Method ...: EndFigure (uint)
	Info .....:     Ends the current figure; optionally, closes it.
	Param ....:         $iFigureEnd  [in]  <$D2D1_FIGURE_END>  A value that indicates whether the current figure is closed. If the figure is closed, a line is drawn between the current point and the start point specified by .

	Method ...: SetFillMode (uint)
	Info .....:     Specifies the method used to determine which points are inside the geometry described by this geometry sink and which points are outside.
	Param ....:         $iFillMode  [in]  <$D2D1_FILL_MODE>  The method used to determine whether a given point is part of the geometry.

	Method ...: SetSegmentFlags (uint)
	Info .....:     Specifies stroke and join options to be applied to new segments added to the geometry sink.
	Param ....:         $iVertexFlags  [in]  <$D2D1_PATH_SEGMENT>  Stroke and join options to be applied to new segments added to the geometry sink.
#ce
; _D2D_SimplifiedGeometrySink_SetFillMode
; _D2D_SimplifiedGeometrySink_SetSegmentFlags



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_SimplifiedGeometrySink_BeginFigure
; Description ...: Starts a new figure at the specified point.
; Syntax ........: _D2D_SimplifiedGeometrySink_BeginFigure($oISimplifiedGeometrySink[, $fX = 0[, $fY = 0[, $iFigureBegin = $D2D1_FIGURE_BEGIN_FILLED]]])
; Parameters ....: $oISimplifiedGeometrySink - This ID2D1SimplifiedGeometrySink object
;                  $fX                       - [optional] The x-coordinate of the point at which to begin the new figure.
;                  $fY                       - [optional] The y-coordinate of the point at which to begin the new figure.
;                  $iFigureBegin             - [optional] A $D2D1_FIGURE_BEGIN enumeraion. Whether the new figure should be hollow or filled.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If this method is called while a figure is currently in progress, the interface is invalidated and all future methods will fail.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_SimplifiedGeometrySink_BeginFigure($oISimplifiedGeometrySink, $fX = 0, $fY = 0, $iFigureBegin = $D2D1_FIGURE_BEGIN_FILLED)
	If Not IsObj($oISimplifiedGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)

	$oISimplifiedGeometrySink.BeginFigure(_D2D1_POINT_2F($fX, $fY), $iFigureBegin)

	Return True
EndFunc   ;==>_D2D_SimplifiedGeometrySink_BeginFigure



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_SimplifiedGeometrySink_AddLines
; Description ...:  Creates a sequence of lines using the specified points and adds them to the geometry sink.
; Syntax ........: _D2D_SimplifiedGeometrySink_AddLines($oISimplifiedGeometrySink, $aPoints)
; Parameters ....: $oISimplifiedGeometrySink - This ID2D1SimplifiedGeometrySink object
;                  $aPoints                  - An array of one or more points that describe the lines to draw.
;                                              A line is drawn from the geometry sink's current point (the end point of the last segment drawn or the location specified by BeginFigure)
;                                              to the first point in the array. if the array contains additional points, a line is drawn from
;                                              the first point to the second point in the array, from the second point to the third point, and
;                                              so on.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_SimplifiedGeometrySink_AddLines($oISimplifiedGeometrySink, $aPoints)
	If Not IsObj($oISimplifiedGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsArray($aPoints) Or UBound($aPoints, 0) <> 2 Then Return SetError($D2DERR_PARAM, 1, False)

	Local $iCnt = $aPoints[0][0]
	Local $tPoints = DllStructCreate("float[" & $iCnt * 2 & "];")
	For $i = 0 To $iCnt - 1
		DllStructSetData($tPoints, 1, $aPoints[$i + 1][0], $i * 2 + 1)
		DllStructSetData($tPoints, 1, $aPoints[$i + 1][1], $i * 2 + 2)
	Next

	$oISimplifiedGeometrySink.AddLines($tPoints, $iCnt)

	Return True
EndFunc   ;==>_D2D_SimplifiedGeometrySink_AddLines



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_SimplifiedGeometrySink_AddBeziers
; Description ...: Creates a sequence of cubic Bezier curves and adds them to the geometry sink.
; Syntax ........: _D2D_SimplifiedGeometrySink_AddBeziers($oISimplifiedGeometrySink, $aBeziers)
; Parameters ....: $oISimplifiedGeometrySink - This ID2D1SimplifiedGeometrySink object
;                  $aBeziers                 - An array of Bezier segments that describes the Bezier curves to create.
;                                              A curve is drawn from the geometry sink's current point (the end point of the last segment drawn or the location specified by BeginFigure)
;                                              to the end point of the first Bezier segment in the array. if the array contains additional Bezier
;                                              segments, each subsequent Bezier segment uses the end point of the preceding Bezier segment as its
;                                              start point.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_SimplifiedGeometrySink_AddBeziers($oISimplifiedGeometrySink, $aBeziers)
	If Not IsObj($oISimplifiedGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsArray($aBeziers) Or UBound($aBeziers, 0) <> 2 Then Return SetError($D2DERR_PARAM, 1, False)

	Local $iCnt = $aBeziers[0][0]
	Local $tBeziers = DllStructCreate("float[" & $iCnt * 6 & "];")

	Local $iI
	For $i = 1 To $iCnt
		$iI = ($i - 1) * 6 + 1
		For $j = 0 To 5
			DllStructSetData($tBeziers, 1, $aBeziers[$i][$j], $iI + $j)
		Next
	Next

	$oISimplifiedGeometrySink.AddBeziers($tBeziers, $iCnt)

	Return True
EndFunc   ;==>_D2D_SimplifiedGeometrySink_AddBeziers


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_SimplifiedGeometrySink_EndFigure
; Description ...:  Ends the current figure; optionally, closes it.
; Syntax ........: _D2D_SimplifiedGeometrySink_EndFigure($oISimplifiedGeometrySink[, $iFigureEnd = $D2D1_FIGURE_END_OPEN])
; Parameters ....: $oISimplifiedGeometrySink - This ID2D1SimplifiedGeometrySink object
;                  $iFigureEnd               - [optional] A $D2D1_FIGURE_END enumeraion. A value that indicates whether the current figure is closed.
;                                                         If the figure is closed, a line is drawn between the current point and the start point
;                                                         specified by BeginFigure.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Calling this method without a matching call to BeginFigure places the geometry sink in an error state; subsequent calls are
;                  ignored, and the overall failure will be returned when the Close method is called.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_SimplifiedGeometrySink_EndFigure($oISimplifiedGeometrySink, $iFigureEnd = $D2D1_FIGURE_END_OPEN)
	If Not IsObj($oISimplifiedGeometrySink) Then Return SetError($D2DERR_NOOBJ, 0, False)

	$oISimplifiedGeometrySink.EndFigure($iFigureEnd)

	Return True
EndFunc   ;==>_D2D_SimplifiedGeometrySink_EndFigure



; _D2D_SimplifiedGeometrySink_Close



;#######################################################################################################################################################################
;# ID2D1SolidColorBrush
;#######################################################################################################################################################################
#cs   ID2D1SolidColorBrush
	Method ...: GetColor (struct*)
	Info .....:     Retrieves the color of the solid color brush.
	Param ....:         $tD2D1_COLOR_F  [OUT]  <$tagD2D1_COLOR_F>

	Method ...: SetColor (struct*)
	Info .....:     Specifies the color of this solid color brush.
	Param ....:         $tColor  [in]  <$tagD2D1_COLOR_F>  The color of this solid color brush.
#ce
; _D2D_SolidColorBrush_SetColor
; _D2D_SolidColorBrush_GetColor



;#######################################################################################################################################################################
;# ID2D1StrokeStyle
;#######################################################################################################################################################################
#cs   ID2D1StrokeStyle
	Method ...: GetDashCap ()
	Info .....:     Gets a value that specifies how the ends of each dash are drawn.
	Param ....:         This method has no parameters.

	Method ...: GetDashes (struct*, uint)
	Info .....:     Copies the dash pattern to the specified array.
	Param ....:         $fDashes       [out]  <float>  A pointer to an array that will receive the dash pattern. The array must be able to contain at least as many elements as specified by dashesCount. You must allocate storage for this array.
	Param ....:         $iDashesCount  [in]   <uint>   The number of dashes to copy. If this value is less than the number of dashes in the stroke style's dashes array, the returned dashes are truncated to dashesCount. If this value is greater than the number of dashes in the stroke style's dashes array, the extra dashes are set to 0.0f. To obtain the actual number of dashes in the stroke style's dashes array, use the method.

	Method ...: GetDashesCount ()
	Info .....:     Retrieves the number of entries in the dashes array.
	Param ....:         This method has no parameters.

	Method ...: GetDashOffset ()
	Info .....:     Retrieves a value that specifies how far in the dash sequence the stroke will start.
	Param ....:         This method has no parameters.

	Method ...: GetDashStyle ()
	Info .....:     Gets a value that describes the stroke's dash pattern.
	Param ....:         This method has no parameters.

	Method ...: GetEndCap ()
	Info .....:     Retrieves the type of shape used at the end of a stroke.
	Param ....:         This method has no parameters.

	Method ...: GetLineJoin ()
	Info .....:     Retrieves the type of joint used at the vertices of a shape's outline.
	Param ....:         This method has no parameters.

	Method ...: GetMiterLimit ()
	Info .....:     Retrieves the limit on the ratio of the miter length to half the stroke's thickness.
	Param ....:         This method has no parameters.

	Method ...: GetStartCap ()
	Info .....:     Retrieves the type of shape used at the beginning of a stroke.
	Param ....:         This method has no parameters.
#ce
; _D2D_StrokeStyle_GetStartCap
; _D2D_StrokeStyle_GetEndCap
; _D2D_StrokeStyle_GetDashCap
; _D2D_StrokeStyle_GetMiterLimit
; _D2D_StrokeStyle_GetLineJoin
; _D2D_StrokeStyle_GetDashOffset
; _D2D_StrokeStyle_GetDashStyle
; _D2D_StrokeStyle_GetDashesCount
; _D2D_StrokeStyle_GetDashes



;#######################################################################################################################################################################
;# ID2D1TessellationSink
;#######################################################################################################################################################################
#cs   ID2D1TessellationSink
	Method ...: AddTriangles (struct*, uint)
	Info .....:     Copies the specified triangles to the sink.
	Param ....:         $tTriangles       [in]  <$tagD2D1_TRIANGLE>  An array of structures that describe the triangles to add to the sink.
	Param ....:         $iTrianglesCount  [in]  <uint>               The number of triangles to copy from the triangles array.

	Method ...: Close ()
	Info .....:     Closes the sink and returns its error status.
	Param ....:         This method has no parameters.
#ce
; _D2D_TessellationSink_AddTriangles
; _D2D_TessellationSink_Close



;#######################################################################################################################################################################
;# ID2D1TransformedGeometry
;#######################################################################################################################################################################
#cs   ID2D1TransformedGeometry
	Method ...: GetSourceGeometry (ptr*)
	Info .....:     Retrieves the source geometry of this transformed geometry object.
	Param ....:         $oSourceGeometry  [out]  <ID2D1Geometry>  When this method returns, contains a pointer to a pointer to the source geometry for this transformed geometry object. This parameter is passed uninitialized.

	Method ...: GetTransform (struct*)
	Info .....:     Retrieves the matrix used to transform the object's source geometry.
	Param ....:         $tTransform  [out]  <$tagD2D1_MATRIX_3X2_F>  A pointer that receives the matrix used to transform the object's source geometry. You must allocate storage for this parameter.
#ce
; _D2D_TransformedGeometry_GetSourceGeometry
; _D2D_TransformedGeometry_GetTransform









;############################################################################################################
;# D2D1_BASETYPES Helper
;############################################################################################################
Func _D2D1_MATRIX_3X2_F($fM11 = 1, $fM12 = 0, $fM21 = 0, $fM22 = 1, $fM31 = 0, $fM32 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	$tStruct.M11 = $fM11
	$tStruct.M12 = $fM12
	$tStruct.M21 = $fM21
	$tStruct.M22 = $fM22
	$tStruct.M31 = $fM31
	$tStruct.M32 = $fM32
	Return $tStruct
EndFunc   ;==>_D2D1_MATRIX_3X2_F

Func _D2D1_COLOR_F($fR = 0, $fG = 0, $fB = 0, $fA = 1)
	Local $tStruct = DllStructCreate($tagD2D1_COLOR_F)
	$tStruct.R = $fR
	$tStruct.G = $fG
	$tStruct.B = $fB
	$tStruct.A = $fA
	Return $tStruct
EndFunc   ;==>_D2D1_COLOR_F

Func _D2D1_POINT_2F($fX = 0, $fY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_POINT_2F)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	Return $tStruct
EndFunc   ;==>_D2D1_POINT_2F

Func _D2D1_POINT_2U($iX = 0, $iY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_POINT_2U)
	$tStruct.X = $iX
	$tStruct.Y = $iY
	Return $tStruct
EndFunc   ;==>_D2D1_POINT_2U

Func _D2D1_RECT_F($fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0)
	Local $tStruct = DllStructCreate($tagD2D1_RECT_F)
	$tStruct.Left = $fLeft
	$tStruct.Top = $fTop
	$tStruct.Right = $fRight
	$tStruct.Bottom = $fBottom
	Return $tStruct
EndFunc   ;==>_D2D1_RECT_F

Func _D2D1_RECT_U($iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0)
	Local $tStruct = DllStructCreate($tagD2D1_RECT_U)
	$tStruct.Left = $iLeft
	$tStruct.Top = $iTop
	$tStruct.Right = $iRight
	$tStruct.Bottom = $iBottom
	Return $tStruct
EndFunc   ;==>_D2D1_RECT_U

Func _D2D1_SIZE_F($fWidth = 0, $fHeight = 0)
	Local $tStruct = DllStructCreate($tagD2D1_SIZE_F)
	$tStruct.Width = $fWidth
	$tStruct.Height = $fHeight
	Return $tStruct
EndFunc   ;==>_D2D1_SIZE_F

Func _D2D1_SIZE_U($iWidth = 0, $iHeight = 0)
	Local $tStruct = DllStructCreate($tagD2D1_SIZE_U)
	$tStruct.Width = $iWidth
	$tStruct.Height = $iHeight
	Return $tStruct
EndFunc   ;==>_D2D1_SIZE_U









;############################################################################################################
;# D2D1_BASETYPES Helper
;############################################################################################################
Func _D2D1_SIZEOF($sTag)
	Local $tStruct = DllStructCreate($sTag)
	Return DllStructGetSize($tStruct)
EndFunc   ;==>_D2D1_SIZEOF

Func _D2D1_FLOAT($fX = 0)
	Local $tStruct = DllStructCreate("float X;")
	$tStruct.X = $fX
	Return $tStruct
EndFunc   ;==>_D2D1_FLOAT

Func _D2D1_UINT($iX = 0)
	Local $tStruct = DllStructCreate("uint X;")
	$tStruct.X = $iX
	Return $tStruct
EndFunc   ;==>_D2D1_UINT

Func _D2D1_BOOL($bX = True)
	Local $tStruct = DllStructCreate("bool X;")
	$tStruct.X = $bX
	Return $tStruct
EndFunc   ;==>_D2D1_BOOL






;############################################################################################################
;# D2D1_STRUCTURES Helper
;############################################################################################################
Func _D2D1_ARC_SEGMENT($fX = 0, $fY = 0, $fWidth = 0, $fHeight = 0, $fRotationAngle = 0, $iSweepDirection = 0, $iArcSize = 0)
	Local $tStruct = DllStructCreate($tagD2D1_ARC_SEGMENT)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	$tStruct.Width = $fWidth
	$tStruct.Height = $fHeight
	$tStruct.RotationAngle = $fRotationAngle
	$tStruct.SweepDirection = $iSweepDirection
	$tStruct.ArcSize = $iArcSize
	Return $tStruct
EndFunc   ;==>_D2D1_ARC_SEGMENT

Func _D2D1_BEZIER_SEGMENT($fX1 = 0, $fY1 = 0, $fX2 = 0, $fY2 = 0, $fX3 = 0, $fY3 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_BEZIER_SEGMENT)
	$tStruct.X1 = $fX1
	$tStruct.Y1 = $fY1
	$tStruct.X2 = $fX2
	$tStruct.Y2 = $fY2
	$tStruct.X3 = $fX3
	$tStruct.Y3 = $fY3
	Return $tStruct
EndFunc   ;==>_D2D1_BEZIER_SEGMENT

Func _D2D1_BITMAP_BRUSH_PROPERTIES($iExtendModeX = 0, $iExtendModeY = 0, $iInterpolationMode = 0)
	Local $tStruct = DllStructCreate($tagD2D1_BITMAP_BRUSH_PROPERTIES)
	$tStruct.ExtendModeX = $iExtendModeX
	$tStruct.ExtendModeY = $iExtendModeY
	$tStruct.InterpolationMode = $iInterpolationMode
	Return $tStruct
EndFunc   ;==>_D2D1_BITMAP_BRUSH_PROPERTIES

Func _D2D1_PIXEL_FORMAT($iPixelFormat = 0, $iAlphaMode = 0)
	Local $tStruct = DllStructCreate($tagD2D1_PIXEL_FORMAT)
	$tStruct.PixelFormat = $iPixelFormat
	$tStruct.AlphaMode = $iAlphaMode
	Return $tStruct
EndFunc   ;==>_D2D1_PIXEL_FORMAT

Func _D2D1_BITMAP_PROPERTIES($iPixelFormat = 0, $iAlphaMode = 0, $fDpiX = 0, $fDpiY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_BITMAP_PROPERTIES)
	$tStruct.PixelFormat = $iPixelFormat
	$tStruct.AlphaMode = $iAlphaMode
	$tStruct.DpiX = $fDpiX
	$tStruct.DpiY = $fDpiY
	Return $tStruct
EndFunc   ;==>_D2D1_BITMAP_PROPERTIES

Func _D2D1_BRUSH_PROPERTIES($fOpacity = 0, $tMatrix = Null)
	Local $tStruct = DllStructCreate($tagD2D1_BRUSH_PROPERTIES)
	$tStruct.Opacity = $fOpacity

	If IsDllStruct($tMatrix) Then
		DllCall("kernel32.dll", "none", "RtlMoveMemory", "struct*", DllStructGetPtr($tStruct) + 4, "struct*", $tMatrix, "ulong_ptr", _D2D1_SIZEOF($tagD2D1_MATRIX_3X2_F))
	Else
		$tStruct.M11 = 1
		$tStruct.M22 = 1
	EndIf

	Return $tStruct
EndFunc   ;==>_D2D1_BRUSH_PROPERTIES

Func _D2D1_DRAWING_STATE_DESCRIPTION($iAntialiasMode = 0, $iTextAntialiasMode = 0, $iTag1 = 0, $iTag2 = 0, $fM11 = 0, $fM12 = 0, $fM21 = 0, $fM22 = 0, $fM31 = 0, $fM32 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_DRAWING_STATE_DESCRIPTION)
	$tStruct.AntialiasMode = $iAntialiasMode
	$tStruct.TextAntialiasMode = $iTextAntialiasMode
	$tStruct.Tag1 = $iTag1
	$tStruct.Tag2 = $iTag2
	$tStruct.M11 = $fM11
	$tStruct.M12 = $fM12
	$tStruct.M21 = $fM21
	$tStruct.M22 = $fM22
	$tStruct.M31 = $fM31
	$tStruct.M32 = $fM32
	Return $tStruct
EndFunc   ;==>_D2D1_DRAWING_STATE_DESCRIPTION

Func _D2D1_ELLIPSE($fX = 0, $fY = 0, $fRadiusX = 0, $fRadiusY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_ELLIPSE)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	$tStruct.RadiusX = $fRadiusX
	$tStruct.RadiusY = $fRadiusY
	Return $tStruct
EndFunc   ;==>_D2D1_ELLIPSE

Func _D2D1_FACTORY_OPTIONS($iDebugLevel = 0)
	Local $tStruct = DllStructCreate($tagD2D1_FACTORY_OPTIONS)
	$tStruct.DebugLevel = $iDebugLevel
	Return $tStruct
EndFunc   ;==>_D2D1_FACTORY_OPTIONS

Func _D2D1_GRADIENT_STOP($fPosition = 0, $fR = 0, $fG = 0, $fB = 0, $fA = 1)
	Local $tStruct = DllStructCreate($tagD2D1_GRADIENT_STOP)
	$tStruct.Position = $fPosition
	$tStruct.R = $fR
	$tStruct.G = $fG
	$tStruct.B = $fB
	$tStruct.A = $fA
	Return $tStruct
EndFunc   ;==>_D2D1_GRADIENT_STOP

Func _D2D1_HWND_RENDER_TARGET_PROPERTIES($hWnd, $iWidth = 0, $iHeight = 0, $iPresentOptions = $D2D1_PRESENT_OPTIONS_NONE)
	Local $tStruct = DllStructCreate($tagD2D1_HWND_RENDER_TARGET_PROPERTIES)
	$tStruct.Hwnd = $hWnd
	$tStruct.Width = $iWidth
	$tStruct.Height = $iHeight
	$tStruct.PresentOptions = $iPresentOptions
	Return $tStruct
EndFunc   ;==>_D2D1_HWND_RENDER_TARGET_PROPERTIES

Func _D2D1_LAYER_PARAMETERS($fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0, $pGeometricMask = Null, $iMaskAntialiasMode = 0, $fOpacity = 1, $pOpacityBrush = Null, $iLayerOptions = 0, $fM11 = 1, $fM12 = 0, $fM21 = 0, $fM22 = 1, $fM31 = 0, $fM32 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_LAYER_PARAMETERS)
	$tStruct.Left = $fLeft
	$tStruct.Top = $fTop
	$tStruct.Right = $fRight
	$tStruct.Bottom = $fBottom
	If IsObj($pGeometricMask) Then
		$tStruct.GeometricMask = $pGeometricMask()
	Else
		$tStruct.GeometricMask = $pGeometricMask
	EndIf
	$tStruct.MaskAntialiasMode = $iMaskAntialiasMode
	$tStruct.M11 = $fM11
	$tStruct.M12 = $fM12
	$tStruct.M21 = $fM21
	$tStruct.M22 = $fM22
	$tStruct.M31 = $fM31
	$tStruct.M32 = $fM32
	$tStruct.Opacity = $fOpacity
	If IsObj($pOpacityBrush) Then
		$tStruct.OpacityBrush = $pOpacityBrush()
	Else
		$tStruct.OpacityBrush = $pOpacityBrush
	EndIf
	$tStruct.LayerOptions = $iLayerOptions
	Return $tStruct
EndFunc   ;==>_D2D1_LAYER_PARAMETERS

Func _D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES($fX1 = 0, $fY1 = 0, $fX2 = 0, $fY2 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES)
	$tStruct.X1 = $fX1
	$tStruct.Y1 = $fY1
	$tStruct.X2 = $fX2
	$tStruct.Y2 = $fY2
	Return $tStruct
EndFunc   ;==>_D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES

Func _D2D1_QUADRATIC_BEZIER_SEGMENT($fX1 = 0, $fY1 = 0, $fX2 = 0, $fY2 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_QUADRATIC_BEZIER_SEGMENT)
	$tStruct.X1 = $fX1
	$tStruct.Y1 = $fY1
	$tStruct.X2 = $fX2
	$tStruct.Y2 = $fY2
	Return $tStruct
EndFunc   ;==>_D2D1_QUADRATIC_BEZIER_SEGMENT

Func _D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES($fX = 0, $fY = 0, $fOriginOffsetX = 0, $fOriginOffsetY = 0, $fRadiusX = 0, $fRadiusY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	$tStruct.OriginOffsetX = $fOriginOffsetX
	$tStruct.OriginOffsetY = $fOriginOffsetY
	$tStruct.RadiusX = $fRadiusX
	$tStruct.RadiusY = $fRadiusY
	Return $tStruct
EndFunc   ;==>_D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES

Func _D2D1_RENDER_TARGET_PROPERTIES($iType = $D2D1_RENDER_TARGET_TYPE_HARDWARE, $iPixelFormat = $DXGI_FORMAT_UNKNOWN, $iAlphaMode = $D2D1_ALPHA_MODE_UNKNOWN, $fDpiX = 0, $fDpiY = 0, $iUsage = $D2D1_RENDER_TARGET_USAGE_NONE, $iMinLevel = $D2D1_FEATURE_LEVEL_DEFAULT)
	Local $tStruct = DllStructCreate($tagD2D1_RENDER_TARGET_PROPERTIES)
	$tStruct.Type = $iType
	$tStruct.PixelFormat = $iPixelFormat
	$tStruct.AlphaMode = $iAlphaMode
	$tStruct.DpiX = $fDpiX
	$tStruct.DpiY = $fDpiY
	$tStruct.Usage = $iUsage
	$tStruct.MinLevel = $iMinLevel
	Return $tStruct
EndFunc   ;==>_D2D1_RENDER_TARGET_PROPERTIES

Func _D2D1_ROUNDED_RECT($fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0, $fRadiusX = 0, $fRadiusY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_ROUNDED_RECT)
	$tStruct.Left = $fLeft
	$tStruct.Top = $fTop
	$tStruct.Right = $fRight
	$tStruct.Bottom = $fBottom
	$tStruct.RadiusX = $fRadiusX
	$tStruct.RadiusY = $fRadiusY
	Return $tStruct
EndFunc   ;==>_D2D1_ROUNDED_RECT

Func _D2D1_STROKE_STYLE_PROPERTIES($iStartCap = 0, $iEndCap = 0, $iDashCap = 0, $iLineJoin = 0, $fMiterLimit = 0, $iDashStyle = 0, $fDashOffset = 0)
	Local $tStruct = DllStructCreate($tagD2D1_STROKE_STYLE_PROPERTIES)
	$tStruct.StartCap = $iStartCap
	$tStruct.EndCap = $iEndCap
	$tStruct.DashCap = $iDashCap
	$tStruct.LineJoin = $iLineJoin
	$tStruct.MiterLimit = $fMiterLimit
	$tStruct.DashStyle = $iDashStyle
	$tStruct.DashOffset = $fDashOffset
	Return $tStruct
EndFunc   ;==>_D2D1_STROKE_STYLE_PROPERTIES

Func _D2D1_TRIANGLE($fX1 = 0, $fY1 = 0, $fX2 = 0, $fY2 = 0, $fX3 = 0, $fY3 = 0)
	Local $tStruct = DllStructCreate($tagD2D1_TRIANGLE)
	$tStruct.X1 = $fX1
	$tStruct.Y1 = $fY1
	$tStruct.X2 = $fX2
	$tStruct.Y2 = $fY2
	$tStruct.X3 = $fX3
	$tStruct.Y3 = $fY3
	Return $tStruct
EndFunc   ;==>_D2D1_TRIANGLE









Func __D2D_GLYPH_RUN($oFontFace, $fFontEmSize, $iGlyphCount, $tGlyphIndices, $tGlyphAdvances = Null, $tGlyphOffsets = Null, $bIsSideways = False, $iBidiLevel = 0)
	Local $tStruct = DllStructCreate("struct; ptr FontFace; float FontEmSize; uint GlyphCount; ptr GlyphIndices; ptr GlyphAdvances; ptr GlyphOffsets; bool IsSideways; uint BidiLevel; endstruct;")
	If IsObj($oFontFace) Then
		$tStruct.FontFace = $oFontFace()
	Else
		$tStruct.FontFace = $oFontFace
	EndIf

	$tStruct.FontEmSize = $fFontEmSize
	$tStruct.GlyphCount = $iGlyphCount

	If IsDllStruct($tGlyphIndices) Then
		$tStruct.GlyphIndices = DllStructGetPtr($tGlyphIndices)
	Else
		$tStruct.GlyphIndices = $tGlyphIndices
	EndIf

	If IsDllStruct($tGlyphAdvances) Then
		$tStruct.GlyphAdvances = DllStructGetPtr($tGlyphAdvances)
	Else
		$tStruct.GlyphAdvances = $tGlyphAdvances
	EndIf

	If IsDllStruct($tGlyphOffsets) Then
		$tStruct.GlyphOffsets = DllStructGetPtr($tGlyphOffsets)
	Else
		$tStruct.GlyphOffsets = $tGlyphOffsets
	EndIf

	$tStruct.IsSideways = $bIsSideways
	$tStruct.BidiLevel = $iBidiLevel
	Return $tStruct
EndFunc   ;==>__D2D_GLYPH_RUN










;############################################################################################################
;# D2D1_MATRIX_3X2_F
;############################################################################################################
Func _D2D_Matrix3x2_Identity()
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	$tMX.M11 = 1
	$tMX.M22 = 1
	Return $tMX
EndFunc   ;==>_D2D_Matrix3x2_Identity

Func _D2D_Matrix3x2_Translation($fX, $fY)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	$tMX.M11 = 1
	$tMX.M22 = 1
	$tMX.M31 = $fX
	$tMX.M32 = $fY
	Return $tMX
EndFunc   ;==>_D2D_Matrix3x2_Translation

Func _D2D_Matrix3x2_Scale($fX, $fY, $fCX = 0, $fCY = 0)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	$tMX.M11 = $fX
	$tMX.M22 = $fY
	$tMX.M31 = $fCX - $fX * $fCX
	$tMX.M32 = $fCY - $fY * $fCY
	Return $tMX
EndFunc   ;==>_D2D_Matrix3x2_Scale

Func _D2D_Matrix3x2_Rotation($fA, $fCX = 0, $fCY = 0)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	Local $tCenter = DllStructCreate($tagD2D1_POINT_2F)
	$tCenter.X = $fCX
	$tCenter.Y = $fCY
	DllCall($__g_hD2D1DLL, "none", "D2D1MakeRotateMatrix", "float", $fA, "struct", $tCenter, "struct*", $tMX)
	Return $tMX
EndFunc   ;==>_D2D_Matrix3x2_Rotation

Func _D2D_Matrix3x2_Skew($fX, $fY, $fCX = 0, $fCY = 0)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	Local $tCenter = DllStructCreate($tagD2D1_POINT_2F)
	$tCenter.X = $fCX
	$tCenter.Y = $fCY
	DllCall($__g_hD2D1DLL, "int", "D2D1MakeSkewMatrix", "float", $fX, "float", $fY, "struct", $tCenter, "struct*", $tMX)
	Return $tMX
EndFunc   ;==>_D2D_Matrix3x2_Skew

Func _D2D_Matrix3x2_Determinant($tMX)
	Return ($tMX.M11 * $tMX.M22) - ($tMX.M12 * $tMX.M21)
EndFunc   ;==>_D2D_Matrix3x2_Determinant

Func _D2D_Matrix3x2_IsInvertible($tMX)
	Local $aResult = DllCall($__g_hD2D1DLL, "bool", "D2D1IsMatrixInvertible", "struct*", $tMX)
	If @error Then Return SetError(1, 0, False)
	Return $aResult[0]
EndFunc   ;==>_D2D_Matrix3x2_IsInvertible

Func _D2D_Matrix3x2_Invert(ByRef $tMX)
	DllCall($__g_hD2D1DLL, "int", "D2D1InvertMatrix", "struct*", $tMX)
EndFunc   ;==>_D2D_Matrix3x2_Invert

Func _D2D_Matrix3x2_IsIdentity($tMX)
	Return $tMX.M11 = 1 And $tMX.M12 = 0 And $tMX.M21 = 0 And $tMX.M22 = 1 And $tMX.M31 = 0 And $tMX.M32 = 0
EndFunc   ;==>_D2D_Matrix3x2_IsIdentity

Func _D2D_Matrix3x2_SetProduct($tMXA, $tMXB)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_3X2_F)
	$tMX.M11 = $tMXA.M11 * $tMXB.M11 + $tMXA.M12 * $tMXB.M21
	$tMX.M12 = $tMXA.M11 * $tMXB.M12 + $tMXA.M12 * $tMXB.M22
	$tMX.M21 = $tMXA.M21 * $tMXB.M11 + $tMXA.M22 * $tMXB.M21
	$tMX.M22 = $tMXA.M21 * $tMXB.M12 + $tMXA.M22 * $tMXB.M22
	$tMX.M31 = $tMXA.M31 * $tMXB.M11 + $tMXA.M32 * $tMXB.M21 + $tMXB.M31
	$tMX.M32 = $tMXA.M31 * $tMXB.M12 + $tMXA.M32 * $tMXB.M22 + $tMXB.M32
	Return $tMX
EndFunc   ;==>_D2D_Matrix3x2_SetProduct

Func _D2D_Matrix3x2_TransformPoint($tMX, ByRef $fX, ByRef $fY)
	Local $fTX = $fX, $fTY = $fY
	$fX = $fTX * $tMX.M11 + $fTY * $tMX.M21 + $tMX.M31
	$fY = $fTX * $tMX.M12 + $fTY * $tMX.M22 + $tMX.M32
EndFunc   ;==>_D2D_Matrix3x2_TransformPoint








;#######################################################################################################################################################################
;# "Non" - Interfaces ;)
;#######################################################################################################################################################################

;Use to make an AutoIt-Object from an interface-pointer
;Do not use _D2D_ObjDispose to release $pPtr after you created an object! Pass Zero to $oObj instead ($oObj = 0)
Func __D2D_ObjCreate($pPtr, $sIID = "{00000000-0000-0000-C000-000000000046}", $tagIFDesc = "")
	If Not $pPtr Then Return SetError($D2DERR_NOPTR, 0, False)
	Local $oObj = ObjCreateInterface($pPtr, $sIID, $tagIFDesc)
	If Not IsObj($oObj) Then Return SetError($D2DERR_OBJFAIL, 1, False)
	Return $oObj
EndFunc   ;==>__D2D_ObjCreate


;Use this to release an object, that has no AutoIt-ObjInterface
;e.g.:   $oRenderTarget.GetBitmap($pBitmap)
;        __D2D_ObjDispose($pBitmap)
Func __D2D_ObjDispose(ByRef $pPtr)
	If Not $pPtr Then Return SetError($D2DERR_NOPTR, 0, False)
	Local $tVTBL = DllStructCreate("ptr MP[3];", DllStructGetData(DllStructCreate("ptr", $pPtr), 1))
	Local $aResult = DllCallAddress("int", DllStructGetData($tVTBL, 1, 3), "ptr", $pPtr)
	If @error Then Return SetError($D2DERR_UFAIL, 1, False)
	If $aResult[0] > 0 Then Return SetError($aResult[0], 2, False) ;RefCount = 0
	$pPtr = Null
	Return True
EndFunc   ;==>__D2D_ObjDispose


;retrieves the original pointer, from which the AutoIt-object was created
;e.g.:   A structure cannot hold an object - you have to pass the pointer:
;        Local $tStruct = DllStructCreate($tagD2D1_LAYER_PARAMETERS)
;        $tStruct.GeometricMask = __D2D_ObjGetPointer($oGeometricMask)
;Func __D2D_ObjGetPointer($oObj)
;	If Not IsObj($oObj) Then Return SetError($D2DERR_NOOBJ, 0, False)
;	Local $tObj = DllStructCreate("ptr UnKnown[5]; ptr pObj;", $oObj)
;	Return $tObj.pObj
;EndFunc   ;==>__D2D_ObjGetPointer


;If you have to use "Queryinterface", but you only have the interface-pointer.
Func __D2D_ObjQueryInterface($oObj, $sIID = "{00000000-0000-0000-C000-000000000046}", $tagIFDesc = "")
	If Not IsObj($oObj) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tIID = _WinAPI_GUIDFromString($sIID)
	If Not IsDllStruct($tIID) Then Return SetError($D2DERR_PARAM, 1, False)

	Local $pPtr
	Local $iHresult = $oObj.QueryInterface(DllStructGetPtr($tIID), $pPtr)
	If $iHresult Or Not $pPtr Then Return SetError($iHResult, 2, False)

	Local $oNew = ObjCreateInterface($pPtr, $sIID, $tagIFDesc)
	If Not IsObj($oNew) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oNew
EndFunc





;#######################################################################################################################################################################
;# Debug
;#######################################################################################################################################################################
Func _D2D_ErrorMessage($iHResult, $iCurError = @error, $iCurExtended = @extended)
	Local $sErr
	Switch $iHResult
		Case 0
			$sErr = "OK."
		Case $D2DERR_BAD_NUMBER
			$sErr = "$D2DERR_BAD_NUMBER - The number is invalid."
		Case $D2DERR_BITMAP_BOUND_AS_TARGET
			$sErr = "$D2DERR_BITMAP_BOUND_AS_TARGET - You can't draw with a bitmap that is currently bound as the target bitmap."
		Case $D2DERR_BITMAP_CANNOT_DRAW
			$sErr = "$D2DERR_BITMAP_CANNOT_DRAW - You can't draw with a bitmap that has the D2D1_BITMAP_OPTIONS_CANNOT_DRAW option."
		Case $D2DERR_CYCLIC_GRAPH
			$sErr = "$D2DERR_CYCLIC_GRAPH - A cycle occurred in the graph."
		Case $D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED
			$sErr = "$D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED - The display format to render is not supported by the hardware device."
		Case $D2DERR_DISPLAY_STATE_INVALID
			$sErr = "$D2DERR_DISPLAY_STATE_INVALID - A valid display state could not be determined."
		Case $D2DERR_EFFECT_IS_NOT_REGISTERED
			$sErr = "$D2DERR_EFFECT_IS_NOT_REGISTERED - The class ID of the specified effect is not registered by the operating system."
		Case $D2DERR_EXCEEDS_MAX_BITMAP_SIZE
			$sErr = "$D2DERR_EXCEEDS_MAX_BITMAP_SIZE - The requested size is larger than the guaranteed supported texture size."
		Case $D2DERR_INCOMPATIBLE_BRUSH_TYPES
			$sErr = "$D2DERR_INCOMPATIBLE_BRUSH_TYPES - The brush types are incompatible for the call."
		Case $D2DERR_INSUFFICIENT_BUFFER
			$sErr = "$D2DERR_INSUFFICIENT_BUFFER - (Windows error)"
		Case $D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES
			$sErr = "$D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES - The Direct3D device doesn't have sufficient capabilities to perform the requested action."
		Case $D2DERR_INTERMEDIATE_TOO_LARGE
			$sErr = "$D2DERR_INTERMEDIATE_TOO_LARGE - You can't render the graph with the context's current tiling settings."
		Case $D2DERR_INTERNAL_ERROR
			$sErr = "$D2DERR_INTERNAL_ERROR - The application should close this instance of Direct2D and restart it as a new process."
		Case $D2DERR_INVALID_CALL
			$sErr = "$D2DERR_INVALID_CALL - A call to this method is invalid."
		Case $D2DERR_INVALID_GRAPH_CONFIGURATION
			$sErr = "$D2DERR_INVALID_GRAPH_CONFIGURATION - A configuration error occurred in the graph."
		Case $D2DERR_INVALID_INTERNAL_GRAPH_CONFIGURATION
			$sErr = "$D2DERR_INVALID_INTERNAL_GRAPH_CONFIGURATION - An internal configuration error occurred in the graph."
		Case $D2DERR_INVALID_PROPERTY
			$sErr = "$D2DERR_INVALID_PROPERTY - The specified property doesn't exist."
		Case $D2DERR_INVALID_TARGET
			$sErr = "$D2DERR_INVALID_TARGET - You can't set the image as a target because it is either an effect or a bitmap that doesn't have the D2D1_BITMAP_OPTIONS_TARGET option."
		Case $D2DERR_LAYER_ALREADY_IN_USE
			$sErr = "$D2DERR_LAYER_ALREADY_IN_USE - The application attempted to reuse a layer resource that has not yet been popped off the stack."
		Case $D2DERR_MAX_TEXTURE_SIZE_EXCEEDED
			$sErr = "$D2DERR_MAX_TEXTURE_SIZE_EXCEEDED - The requested DX surface size exceeds the maximum texture size."
		Case $D2DERR_NO_HARDWARE_DEVICE
			$sErr = "$D2DERR_NO_HARDWARE_DEVICE - There is no hardware rendering device available for this operation."
		Case $D2DERR_NO_SUBPROPERTIES
			$sErr = "$D2DERR_NO_SUBPROPERTIES - The specified sub-property doesn't exist."
		Case $D2DERR_NOT_INITIALIZED
			$sErr = "$D2DERR_NOT_INITIALIZED - The object has not yet been initialized."
		Case $D2DERR_ORIGINAL_TARGET_NOT_BOUND
			$sErr = "$D2DERR_ORIGINAL_TARGET_NOT_BOUND - The operation failed because the original target isn't currently bound as a target."
		Case $D2DERR_OUTSTANDING_BITMAP_REFERENCES
			$sErr = "$D2DERR_OUTSTANDING_BITMAP_REFERENCES - The operation can't complete while you have outstanding references to the target bitmap."
		Case $D2DERR_POP_CALL_DID_NOT_MATCH_PUSH
			$sErr = "$D2DERR_POP_CALL_DID_NOT_MATCH_PUSH - The application attempted to pop a layer off the stack when a clip was at the top, or pop a clip off the stack when a layer was at the top."
		Case $D2DERR_PRINT_FORMAT_NOT_SUPPORTED
			$sErr = "$D2DERR_PRINT_FORMAT_NOT_SUPPORTED - This error occurs during print control creation (ID2D1Device::CreatePrintControl) to indicate that the Direct2D print control (ID2D1PrintControl) can't support any of the package target types that represent printer formats."
		Case $D2DERR_PRINT_JOB_CLOSED
			$sErr = "$D2DERR_PRINT_JOB_CLOSED - The application called ID2D1PrintControl::AddPage or ID2D1PrintControl::Close after the print job is already finished."
		Case $D2DERR_PUSH_POP_UNBALANCED
			$sErr = "$D2DERR_PUSH_POP_UNBALANCED - The application did not pop all clips and layers off the stack, or it attempted to pop too many clips or layers off the stack."
		Case $D2DERR_RECREATE_TARGET
			$sErr = "$D2DERR_RECREATE_TARGET - A presentation error has occurred that may be recoverable. The caller needs to re-create the render target then attempt to render the frame again."
		Case $D2DERR_RENDER_TARGET_HAS_LAYER_OR_CLIPRECT
			$sErr = "$D2DERR_RENDER_TARGET_HAS_LAYER_OR_CLIPRECT - The requested operation cannot be performed until all layers and clips have been popped off the stack."
		Case $D2DERR_SCANNER_FAILED
			$sErr = "$D2DERR_SCANNER_FAILED - The geometry scanner failed to process the data."
		Case $D2DERR_SCREEN_ACCESS_DENIED
			$sErr = "$D2DERR_SCREEN_ACCESS_DENIED - Direct2D could not access the screen."
		Case $D2DERR_SHADER_COMPILE_FAILED
			$sErr = "$D2DERR_SHADER_COMPILE_FAILED - Shader compilation failed."
		Case $D2DERR_TARGET_NOT_GDI_COMPATIBLE
			$sErr = "$D2DERR_TARGET_NOT_GDI_COMPATIBLE - The render target is not compatible with GDI."
		Case $D2DERR_TEXT_EFFECT_IS_WRONG_TYPE
			$sErr = "$D2DERR_TEXT_EFFECT_IS_WRONG_TYPE - A text client drawing effect object is of the wrong type."
		Case $D2DERR_TEXT_RENDERER_NOT_RELEASED
			$sErr = "$D2DERR_TEXT_RENDERER_NOT_RELEASED - An application is holding a reference to the IDWriteTextRenderer interface after the corresponding DrawText or DrawTextLayout call has $sErr =ed."
		Case $D2DERR_TOO_MANY_SHADER_ELEMENTS
			$sErr = "$D2DERR_TOO_MANY_SHADER_ELEMENTS - Shader construction failed because it was too complex."
		Case $D2DERR_TOO_MANY_TRANSFORM_INPUTS
			$sErr = "$D2DERR_TOO_MANY_TRANSFORM_INPUTS - An effect attempted to use a transform with too many inputs."
		Case $D2DERR_UNSUPPORTED_OPERATION
			$sErr = "$D2DERR_UNSUPPORTED_OPERATION - The requested operation is not supported."
		Case $D2DERR_UNSUPPORTED_PIXEL_FORMAT
			$sErr = "$D2DERR_UNSUPPORTED_PIXEL_FORMAT - (error in wincodec.h)"
		Case $D2DERR_UNSUPPORTED_VERSION
			$sErr = "$D2DERR_UNSUPPORTED_VERSION - The requested Direct2D version is not supported."
		Case $D2DERR_WIN32_ERROR
			$sErr = "$D2DERR_WIN32_ERROR - An unknown Win32 failure occurred."
		Case $D2DERR_WRONG_FACTORY
			$sErr = "$D2DERR_WRONG_FACTORY - Objects used together were not all created from the same factory instance."
		Case $D2DERR_WRONG_RESOURCE_DOMAIN
			$sErr = "$D2DERR_WRONG_RESOURCE_DOMAIN - The resource used was created by a render target in a different resource domain."
		Case $D2DERR_WRONG_STATE
			$sErr = "$D2DERR_WRONG_STATE - The object was not in the correct state to process the method."
		Case $D2DERR_ZERO_VECTOR
			$sErr = "$D2DERR_ZERO_VECTOR - The supplied vector is zero."

		Case Else
			Local $tBufferPtr = DllStructCreate("ptr")

			Local $nCount = _WinAPI_FormatMessage(BitOR($FORMAT_MESSAGE_ALLOCATE_BUFFER, $FORMAT_MESSAGE_FROM_SYSTEM), 0, $iHResult, 0, $tBufferPtr, 0, 0)
			If @error Then Return SetError($iCurError, $iCurExtended, "0x" & Hex($iHResult, 8) & " - Unknown error...")

			Local $sText = ""
			Local $pBuffer = DllStructGetData($tBufferPtr, 1)
			If $pBuffer Then
				If $nCount > 0 Then
					Local $tBuffer = DllStructCreate("wchar[" & ($nCount + 1) & "]", $pBuffer)
					$sText = DllStructGetData($tBuffer, 1)
				EndIf
				_WinAPI_LocalFree($pBuffer)
			EndIf

			$sErr = "0x" & Hex($iHResult) & " - " & $sText
	EndSwitch

	$sErr = StringRegExpReplace($sErr, "(?m)\R$", "")

	Return SetError($iCurError, $iCurExtended, $sErr) ; restore caller @error and @extended
EndFunc   ;==>_D2D_ErrorMessage
