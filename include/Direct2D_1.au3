#include-once
#include <Direct2D.au3>
#include <Direct2D_1Constants.au3>

Global $__g_hD3D11DLL = DllOpen("d3d11.dll")




Func _D2D_CreateHWNDContext($oID2D1Factory1, $hWnd, ByRef $oID2D1DeviceContext, ByRef $oIDXGISwapChain)
	Local Const $D3D_DRIVER_TYPE_HARDWARE = 1
	Local Const $D3D11_CREATE_DEVICE_BGRA_SUPPORT = 0x20
	Local Const $D3D11_SDK_VERSION = 7
	Local Const $DXGI_USAGE_RENDER_TARGET_OUTPUT = 0x00000020

	Local Const $DXGI_SCALING_STRETCH = 0 ;Windows 7 SP1 + Platform Update
	;Local Const $DXGI_SCALING_NONE = 1 ;Windows 8+

	Local Const $DXGI_SWAP_EFFECT_DISCARD = 0 ;Windows 7 SP1 + Platform Update
	;Local Const $DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL = 3 ;Windows 8+


	Local Const $tagDXGI_SWAP_CHAIN_DESC1 = "struct; uint Width; uint Height; uint Format; bool Stereo; struct; uint SampleDescCount; uint SampleDescQuality; endstruct; uint BufferUsage; uint BufferCount; uint Scaling; uint SwapEffect; uint AlphaMode; uint Flags; endstruct;"


	Local Const $sIID_ID3D11Device = "{db6f6ddb-ac77-4e88-8253-819df9bbf140}"
	Local Const $sIID_IDXGIDevice1 = "{77db970f-6276-48ba-ba28-070143b4392c}"
	Local Const $sIID_IDXGIAdapter = "{2411e7e1-12ac-4ccf-bd14-9798e8534dc0}"
	Local Const $sIID_IDXGIFactory2 = "{50c83a1c-e072-4c48-87b0-3630fa36a6d0}"
	Local Const $sIID_IDXGISwapChain = "{310d36a0-d2e7-4c0a-aa04-6a9d23b8886a}"
	Local Const $sIID_ID3D11Texture2D = "{6f15aaf2-d208-4e89-9ab4-489535d34f9c}"
	Local Const $sIID_IDXGISurface = "{cafcb56c-6ac3-4889-bf47-9e23bbd260ec}"


	Local Const $tagIDXGIDevice1 = "SetPrivateData hresult(wstr;uint;struct*);" & _
			"SetPrivateDataInterface hresult(wstr;struct*);" & _
			"GetPrivateData hresult(wstr;uint*;struct*);" & _
			"GetParent hresult(struct*;ptr*);" & _
			"GetAdapter hresult(ptr*);" & _
			"CreateSurface hresult(struct*;uimt;uint;struct*;ptr*);" & _
			"QueryResourceResidency hresult(struct*;struct*;uint);" & _
			"SetGPUThreadPriority hresult(int);" & _
			"GetGPUThreadPriority hresult(int*);" & _
			"SetMaximumFrameLatency hresult(uint);" & _
			"GetMaximumFrameLatency hresult(uint*);"

	Local Const $tagIDXGIAdapter = "SetPrivateData hresult(wstr;uint;struct*);" & _
			"SetPrivateDataInterface hresult(wstr;struct*);" & _
			"GetPrivateData hresult(wstr;uint*;struct*);" & _
			"GetParent hresult(struct*;ptr*);" & _
			"EnumOutputs hresult(uint;ptr*);" & _
			"GetDesc hresult(struct*);" & _
			"CheckInterfaceSupport hresult(wstr;int64*);"

	Local Const $tagIDXGIFactory1 = "SetPrivateData hresult(wstr;uint;struct*);" & _
			"SetPrivateDataInterface hresult(wtsr;struct*);" & _
			"GetPrivateData hresult(wstr;uint*;struct*);" & _
			"GetParent hresult(struct*;ptr*);" & _
			"EnumAdapters hresult(uint;ptr*);" & _
			"MakeWindowAssociation hresult(hwnd;uint);" & _
			"GetWindowAssociation hresult(hwnd*);" & _
			"CreateSwapChain hresult(struct*;struct*;ptr*);" & _
			"CreateSoftwareAdapter hresult(hwnd;ptr*);" & _
			"EnumAdapters1 hresult(uint;ptr*);" & _
			"IsCurrent bool();"

	Local Const $tagIDXGIFactory2 = $tagIDXGIFactory1 & _
			"IsWindowedStereoEnabled bool();" & _
			"CreateSwapChainForHwnd hresult(struct*;hwnd;struct*;struct*;struct*;ptr*);" & _
			"CreateSwapChainForCoreWindow hresult(struct*;struct*;struct*;struct*;ptr*);" & _
			"GetSharedResourceAdapterLuid hresult(handle;struct*);" & _
			"RegisterStereoStatusWindow hresult(hwnd;uint;uint*);" & _
			"RegisterStereoStatusEvent hresult(handle;uint*);" & _
			"UnregisterStereoStatus void(uint);" & _
			"RegisterOcclusionStatusWindow hresult(hwnd;uint;uint*);" & _
			"RegisterOcclusionStatusEvent hresult(handle;uint*);" & _
			"UnregisterOcclusionStatus void(uint);" & _
			"CreateSwapChainForComposition hresult(struct*;struct*;struct*;ptr*);"

	Local Const $tagIDXGISwapChain = "SetPrivateData hresult(wstr;uint;struct*);" & _
			"SetPrivateDataInterface hresult(wstr;struct*);" & _
			"GetPrivateData hresult(wstr;uint*;struct*);" & _
			"GetParent hresult(struct*;ptr*);" & _
			"GetDevice hresult(struct*;ptr*);" & _
			"Present hresult(uint;uint);" & _
			"GetBuffer hresult(uint;struct*;ptr*);" & _
			"SetFullscreenState hresult(bool;struct*);" & _
			"GetFullscreenState hresult(bool*;ptr*);" & _
			"GetDesc hresult(struct*);" & _
			"ResizeBuffers hresult(uint;uint;uint;uint;uint);" & _
			"ResizeTarget hresult(struct*);" & _
			"GetContainingOutput hresult(ptr*);" & _
			"GetFrameStatistics hresult(struct*);" & _
			"GetLastPresentCount hresult(uint*);"


	Local $tFeatureLevels = DllStructCreate("uint Val[7];")
	$tFeatureLevels.Val(1) = 0xB100
	$tFeatureLevels.Val(2) = 0xB000
	$tFeatureLevels.Val(3) = 0xA100
	$tFeatureLevels.Val(4) = 0xA000
	$tFeatureLevels.Val(5) = 0x9300
	$tFeatureLevels.Val(6) = 0x9200
	$tFeatureLevels.Val(7) = 0x9100


	;Create the DX11 API device object, and get a corresponding context.
	Local $aResult = DllCall($__g_hD3D11DLL, "uint", "D3D11CreateDevice", "ptr", Null, "uint", $D3D_DRIVER_TYPE_HARDWARE, "ptr", Null, "uint", $D3D11_CREATE_DEVICE_BGRA_SUPPORT, "struct*", $tFeatureLevels, "uint", 7, "uint", $D3D11_SDK_VERSION, "ptr*", 0, "uint*", 0, "ptr*", 0)
	If @error Or Not $aResult[8] Then Return SetError($D2DERR_NOPTR, 0, False)
	Local $pID3D11Device = $aResult[8]
	Local $oID3D11Device = ObjCreateInterface($pID3D11Device, $sIID_ID3D11Device, "")


	;Obtain the underlying DXGI device of the Direct3D11 device.
	Local $tCLSID_IDXGIDevice = _WinAPI_GUIDFromString($sIID_IDXGIDevice1)
	Local $pIDXGIDevice1
	$oID3D11Device.QueryInterface(DllStructGetPtr($tCLSID_IDXGIDevice), $pIDXGIDevice1)
	If Not $pIDXGIDevice1 Then Return SetError($D2DERR_NOPTR, 1, False)
	Local $oIDXGIDevice1 = ObjCreateInterface($pIDXGIDevice1, $sIID_IDXGIDevice1, $tagIDXGIDevice1)


	;Obtain the Direct2D device for 2-D rendering.
	Local $pID2D1Device
	$oID2D1Factory1.CreateDevice($pIDXGIDevice1, $pID2D1Device)
	If Not $pID2D1Device Then Return SetError($D2DERR_NOPTR, 2, False)
	Local $oID2D1Device = ObjCreateInterface($pID2D1Device, $sIID_ID2D1Device, $tagID2D1Device)


	;Get Direct2D device's corresponding device context object.
	Local $pID2D1DeviceContext
	$oID2D1Device.CreateDeviceContext($D2D1_DEVICE_CONTEXT_OPTIONS_NONE, $pID2D1DeviceContext)
	If Not $pID2D1DeviceContext Then Return SetError($D2DERR_NOPTR, 3, False)
	$oID2D1DeviceContext = ObjCreateInterface($pID2D1DeviceContext, $sIID_ID2D1DeviceContext, $tagID2D1DeviceContext)


	;Allocate a descriptor.
	Local $tDXGI_SWAP_CHAIN_DESC1 = DllStructCreate($tagDXGI_SWAP_CHAIN_DESC1)
	$tDXGI_SWAP_CHAIN_DESC1.Width = 0
	$tDXGI_SWAP_CHAIN_DESC1.Height = 0
	$tDXGI_SWAP_CHAIN_DESC1.Format = $DXGI_FORMAT_B8G8R8A8_UNORM
	$tDXGI_SWAP_CHAIN_DESC1.Stereo = False
	$tDXGI_SWAP_CHAIN_DESC1.SampleDescCount = 1
	$tDXGI_SWAP_CHAIN_DESC1.SampleDescQuality = 0
	$tDXGI_SWAP_CHAIN_DESC1.BufferUsage = $DXGI_USAGE_RENDER_TARGET_OUTPUT
	$tDXGI_SWAP_CHAIN_DESC1.BufferCount = 2
	$tDXGI_SWAP_CHAIN_DESC1.Scaling = $DXGI_SCALING_STRETCH
	$tDXGI_SWAP_CHAIN_DESC1.SwapEffect = $DXGI_SWAP_EFFECT_DISCARD
	$tDXGI_SWAP_CHAIN_DESC1.Flags = 0


	;Identify the physical adapter (GPU or card) this device is runs on.
	Local $pIDXGIAdapter
	$oIDXGIDevice1.GetAdapter($pIDXGIAdapter)
	If Not $pIDXGIAdapter Then Return SetError($D2DERR_NOPTR, 4, False)
	Local $oIDXGIAdapter = ObjCreateInterface($pIDXGIAdapter, $sIID_IDXGIAdapter, $tagIDXGIAdapter)


	;Get the factory object that created the DXGI device.
	Local $tCLSID_IDXGIFactory2 = _WinAPI_GUIDFromString($sIID_IDXGIFactory2)
	Local $pIDXGIFactory2
	$oIDXGIAdapter.GetParent($tCLSID_IDXGIFactory2, $pIDXGIFactory2)
	If Not $pIDXGIFactory2 Then Return SetError($D2DERR_NOPTR, 5, False)
	Local $oIDXGIFactory2 = ObjCreateInterface($pIDXGIFactory2, $sIID_IDXGIFactory2, $tagIDXGIFactory2)


	;Get the final swap chain for this window from the DXGI factory.
	Local $pIDXGISwapChain
	$oIDXGIFactory2.CreateSwapChainForHwnd($pID3D11Device, $hWnd, $tDXGI_SWAP_CHAIN_DESC1, Null, Null, $pIDXGISwapChain)
	If Not $pIDXGISwapChain Then Return SetError($D2DERR_NOPTR, 6, False)
	$oIDXGISwapChain = ObjCreateInterface($pIDXGISwapChain, $sIID_IDXGISwapChain, $tagIDXGISwapChain)


	;Ensure that DXGI doesn't queue more than one frame at a time.
	$oIDXGIDevice1.SetMaximumFrameLatency(1)


	;Get the backbuffer for this window which is be the final 3D render target.
	Local $tCLSID_ID3D11Texture2D = _WinAPI_GUIDFromString($sIID_ID3D11Texture2D)
	Local $pID3D11Texture2D ;backBuffer
	$oIDXGISwapChain.GetBuffer(0, $tCLSID_ID3D11Texture2D, $pID3D11Texture2D)
	If Not $pID3D11Texture2D Then Return SetError($D2DERR_NOPTR, 7, False)

	;Now we set up the Direct2D render target bitmap linked to the swapchain.
	;Whenever we render to this bitmap, it is directly rendered to the
	;swap chain associated with the window.
	Local $tD2D1_BITMAP_PROPERTIES1 = DllStructCreate($tagD2D1_BITMAP_PROPERTIES1)
	$tD2D1_BITMAP_PROPERTIES1.Pixelformat = $DXGI_FORMAT_B8G8R8A8_UNORM
	$tD2D1_BITMAP_PROPERTIES1.AlphaMode = $D2D1_ALPHA_MODE_PREMULTIPLIED;$D2D1_ALPHA_MODE_IGNORE
	$tD2D1_BITMAP_PROPERTIES1.Bitmapoptions = BitOR($D2D1_BITMAP_OPTIONS_TARGET, $D2D1_BITMAP_OPTIONS_CANNOT_DRAW)

	;Direct2D needs the dxgi version of the backbuffer surface pointer.
	Local $tCLSID_IDXGISurface = _WinAPI_GUIDFromString($sIID_IDXGISurface)
	Local $pIDXGISurface ;dxgiBackBuffer
	$oIDXGISwapChain.GetBuffer(0, $tCLSID_IDXGISurface, $pIDXGISurface)
	If Not $pIDXGISurface Then Return SetError($D2DERR_NOPTR, 8, False)

	;Get a D2D surface from the DXGI back buffer to use as the D2D render target.
	Local $pD2DTargetBitmap
	$oID2D1DeviceContext.CreateBitmapFromDxgiSurface($pIDXGISurface, $tD2D1_BITMAP_PROPERTIES1, $pD2DTargetBitmap)
	If Not $pD2DTargetBitmap Then Return SetError($D2DERR_NOPTR, 9, False)

	;Now we can set the Direct2D render target.
	Local $iHResult = $oID2D1DeviceContext.SetTarget($pD2DTargetBitmap)
	If $iHResult Then Return SetError($D2DERR_UFAIL, 10, False)
EndFunc   ;==>_Direct2D_1_CreateHWNDContext



;#######################################################################################################################################################################
;# ID2D1Bitmap1
;#######################################################################################################################################################################
#cs   ID2D1Bitmap1
	Method ...: GetColorContext (ptr*)
	Info .....:     Gets the color context information associated with the bitmap.
	Param ....:         $oColorContext  [out, optional]  <ID2D1ColorContext>  When this method returns, contains the address of a pointer to the color context interface associated with the bitmap.

	Method ...: GetOptions ()
	Info .....:     Gets the options used in creating the bitmap.
	Param ....:         This method has no parameters.

	Method ...: GetSurface (ptr*)
	Info .....:     Gets either the surface that was specified when the bitmap was created, or the default surface created when the bitmap was created.
	Param ....:         $oDxgiSurface  [out, optional]  <IDXGISurface>  The underlying DXGI surface for the bitmap.

	Method ...: Map (uint, struct*)
	Info .....:     Maps the given bitmap into memory.
	Param ....:         $iOptions     [in]   <$D2D1_MAP_OPTIONS>     The options used in mapping the bitmap into memory.
	Param ....:         $tMappedRect  [out]  <$tagD2D1_MAPPED_RECT>  When this method returns, contains a reference to the rectangle that is mapped into memory.

	Method ...: Unmap ()
	Info .....:     Unmaps the bitmap from memory.
	Param ....:         This method has no parameters.
#ce
; _D2D_Bitmap1_GetColorContext
; _D2D_Bitmap1_GetOptions
; _D2D_Bitmap1_GetSurface
; _D2D_Bitmap1_Map
; _D2D_Bitmap1_Unmap





;#######################################################################################################################################################################
;# ID2D1BitmapBrush1
;#######################################################################################################################################################################
#cs   ID2D1BitmapBrush1
	Method ...: GetInterpolationMode1 ()
	Info .....:     Returns the current interpolation mode of the brush.
	Param ....:         This method has no parameters.

	Method ...: SetInterpolationMode1 (uint)
	Info .....:     Sets the interpolation mode for the brush.
	Param ....:         $iInterpolationMode  [in]  <$D2D1_INTERPOLATION_MODE>  The mode to use.
#ce
; _D2D_BitmapBrush1_GetInterpolationMode1
; _D2D_BitmapBrush1_SetInterpolationMode1





;#######################################################################################################################################################################
;# ID2D1ColorContext
;#######################################################################################################################################################################
#cs   ID2D1ColorContext
	Method ...: GetProfileSize ()
	Info .....:     Gets the size of the color profile associated with the bitmap.
	Param ....:         This method has no parameters.

	Method ...: GetProfile (struct*, uint)
	Info .....:     Gets the color profile bytes for an .
	Param ....:         $tProfile      [out]  <struct>  When this method returns, contains the color profile.
	Param ....:         $iProfileSize  [in]   <uint>    The size of the profile buffer.
#ce
; _D2D_ColorContext_GetProfileSize
; _D2D_ColorContext_GetProfile





;#######################################################################################################################################################################
;# ID2D1CommandList
;#######################################################################################################################################################################
#cs   ID2D1CommandList
	Method ...: Close ()
	Info .....:     Instructs the command list to stop accepting commands so that you can use it as an input to an effect or in a call to . You should call the method after it has been attached to an and written to but before the command list is used.
	Param ....:         This method has no parameters.

	Method ...: Stream (struct*)
	Info .....:     Streams the contents of the command list to the specified command sink.
	Param ....:         $oSink  [in]  <ID2D1CommandSink>  The sink into which the command list will be streamed.
#ce
; _D2D_CommandList_Close
; _D2D_CommandList_Stream





;#######################################################################################################################################################################
;# ID2D1CommandSink
;#######################################################################################################################################################################
#cs   ID2D1CommandSink
	Method ...: BeginDraw ()
	Info .....:     Notifies the implementation of the command sink that drawing is about to commence.
	Param ....:         This method has no parameters.

	Method ...: EndDraw ()
	Info .....:     Indicates when processing has completed.
	Param ....:         This method has no parameters.

	Method ...: SetAntialiasMode (uint)
	Info .....:     Sets the antialiasing mode that will be used to render any subsequent geometry.
	Param ....:         $iAntialiasMode  [in]  <$D2D1_ANTIALIAS_MODE>  The antialiasing mode selected for the command list.

	Method ...: SetTags (uint64, uint64)
	Info .....:     Sets the tags that correspond to the tags in the command sink.
	Param ....:         $iTag1  [in]  <$D2D1_TAG>  The first tag to associate with the primitive.
	Param ....:         $iTag2  [in]  <$D2D1_TAG>  The second tag to associate with the primitive.

	Method ...: SetTextAntialiasMode (uint)
	Info .....:     Indicates the new default antialiasing mode for text.
	Param ....:         $iTextAntialiasMode  [in]  <$D2D1_TEXT_ANTIALIAS_MODE>  The antialiasing mode for the text.

	Method ...: SetTextRenderingParams (struct*)
	Info .....:     Indicates more detailed text rendering parameters.
	Param ....:         $oTextRenderingParams  [in]  <IDWriteRenderingParams>  The parameters to use for text rendering.

	Method ...: SetTransform (struct*)
	Info .....:     Sets a new transform.
	Param ....:         $tTransform  [in]  <$tagD2D1_MATRIX_3X2_F>  The transform to be set.

	Method ...: SetUnitMode (uint)
	Info .....:     The unit mode changes the meaning of subsequent units from device-independent pixels (DIPs) to pixels or the other way. The command sink does not record a DPI, this is implied by the playback context or other playback interface such as .
	Param ....:         $iUnitMode  [in]  <$D2D1_UNIT_MODE>  The enumeration that specifies how units are to be interpreted.

	Method ...: SetPrimitiveBlend (uint)
	Info .....:     Sets a new primitive blend mode.
	Param ....:         $iPrimitiveBlend  [in]  <$D2D1_PRIMITIVE_BLEND>  The primitive blend that will apply to subsequent primitives.

	Method ...: Clear (struct*)
	Info .....:     Clears the drawing area to the specified color.
	Param ....:         $tClearColor  [in, optional]  <$tagD2D1_COLOR_F>  The color to which the command sink should be cleared.

	Method ...: DrawBitmap (struct*, struct*, float, uint, struct*, struct*)
	Info .....:     Draws a bitmap to the render target.
	Param ....:         $oBitmap                [in]            <ID2D1Bitmap>               The bitmap to draw.
	Param ....:         $tDestinationRectangle  [in, optional]  <$tagD2D1_RECT_F>           The destination rectangle. The default is the size of the bitmap and the location is the upper left corner of the render target.
	Param ....:         $fOpacity               [in]            <float>                     The opacity of the bitmap.
	Param ....:         $iInterpolationMode     [in]            <$D2D1_INTERPOLATION_MODE>  The interpolation mode to use.
	Param ....:         $tSourceRectangle       [in, optional]  <$tagD2D1_RECT_F>           An optional source rectangle.
	Param ....:         $iPerspectiveTransform  [in, optional]  <$D2D1_MATRIX_4X4_F>        An optional perspective transform.

	Method ...: DrawGlyphRun (float, float, struct*, struct*, struct*, uint)
	Info .....:     Indicates the glyphs to be drawn.
	Param ....:         $tBaselineOrigin       [in]            <$tagD2D1_POINT_2F>             The upper left corner of the baseline.
	Param ....:         $oGlyphRun             [in]            <DWRITE_GLYPH_RUN>              The sequence of glyphs to be sent.
	Param ....:         $oGlyphRunDescription  [in, optional]  <DWRITE_GLYPH_RUN_DESCRIPTION>  Additional non-rendering information about the glyphs.
	Param ....:         $oForegroundBrush      [in]            <ID2D1Brush>                    The brush used to fill the glyphs.
	Param ....:         $oMeasuringMode        [in]            <DWRITE_MEASURING_MODE>         The measuring mode to apply to the glyphs.

	Method ...: DrawLine (float, float, float, float, struct*, float, struct*)
	Info .....:     Draws a line drawn between two points.
	Param ....:         $tPoint0       [in]            <$tagD2D1_POINT_2F>  The start point of the line.
	Param ....:         $tPoint1       [in]            <$tagD2D1_POINT_2F>  The end point of the line.
	Param ....:         $oBrush        [in]            <ID2D1Brush>         The brush used to fill the line.
	Param ....:         $fStrokeWidth  [in]            <float>              The width of the stroke to fill the line.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>   The style of the stroke. If not specified, the stroke is solid.

	Method ...: DrawGeometry (struct*, struct*, float, struct*)
	Info .....:     Indicates the geometry to be drawn to the command sink.
	Param ....:         $oGeometry     [in]            <ID2D1Geometry>     The geometry to be stroked.
	Param ....:         $oBrush        [in]            <ID2D1Brush>        The brush that will be used to fill the stroked geometry.
	Param ....:         $fStrokeWidth  [in]            <float>             The width of the stroke.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>  The style of the stroke.

	Method ...: DrawGdiMetafile (struct*, struct*)
	Info .....:     Draw a metafile to the device context.
	Param ....:         $oGdiMetafile   [in]            <ID2D1GdiMetafile>   The metafile to draw.
	Param ....:         $tTargetOffset  [in, optional]  <$tagD2D1_POINT_2F>  The offset from the upper left corner of the render target.

	Method ...: DrawRectangle (struct*, struct*, float, struct*)
	Info .....:     Draws a rectangle.
	Param ....:         $tRect         [in]            <$tagD2D1_RECT_F>   The rectangle to be drawn to the command sink.
	Param ....:         $oBrush        [in]            <ID2D1Brush>        The brush used to stroke the geometry.
	Param ....:         $fStrokeWidth  [in]            <float>             The width of the stroke.
	Param ....:         $oStrokeStyle  [in, optional]  <ID2D1StrokeStyle>  The style of the stroke.

	Method ...: DrawImage (struct*, struct*, struct*, uint, uint)
	Info .....:     Draws the provided image to the command sink.
	Param ....:         $oImage              [in]            <ID2D1Image>                The image to be drawn to the command sink.
	Param ....:         $tTargetOffset       [in, optional]  <$tagD2D1_POINT_2F>         This defines the offset in the destination space that the image will be rendered to. The entire logical extent of the image will be rendered to the corresponding destination. If not specified, the destination origin will be (0, 0). The top-left corner of the image will be mapped to the target offset. This will not necessarily be the origin.
	Param ....:         $tImageRectangle     [in, optional]  <$tagD2D1_RECT_F>           The corresponding rectangle in the image space will be mapped to the provided origins when processing the image.
	Param ....:         $iInterpolationMode  [in]            <$D2D1_INTERPOLATION_MODE>  The interpolation mode to use to scale the image if necessary.
	Param ....:         $iCompositeMode      [in]            <$D2D1_COMPOSITE_MODE>      If specified, the composite mode that will be applied to the limits of the currently selected clip.

	Method ...: FillMesh (struct*, struct*)
	Info .....:     Indicates a mesh to be filled by the command sink.
	Param ....:         $oMesh   [in]  <ID2D1Mesh>   The mesh object to be filled.
	Param ....:         $oBrush  [in]  <ID2D1Brush>  The brush with which to fill the mesh.

	Method ...: FillOpacityMask (struct*, struct*, struct*, struct*)
	Info .....:     Fills an opacity mask on the command sink.
	Param ....:         $oOpacityMask           [in]            <ID2D1Bitmap>      The bitmap whose alpha channel will be sampled to define the opacity mask.
	Param ....:         $oBrush                 [in]            <ID2D1Brush>       The brush with which to fill the mask.
	Param ....:         $tDestinationRectangle  [in, optional]  <$tagD2D1_RECT_F>  The destination rectangle in which to fill the mask. If not specified, this is the origin.
	Param ....:         $tSourceRectangle       [in, optional]  <$tagD2D1_RECT_F>  The source rectangle within the opacity mask. If not specified, this is the entire mask.

	Method ...: FillGeometry (struct*, struct*, struct*)
	Info .....:     Indicates to the command sink a geometry to be filled.
	Param ....:         $oGeometry      [in]            <ID2D1Geometry>  The geometry that should be filled.
	Param ....:         $oBrush         [in]            <ID2D1Brush>     The primary brush used to fill the geometry.
	Param ....:         $oOpacityBrush  [in, optional]  <ID2D1Brush>     A brush whose alpha channel is used to modify the opacity of the primary fill brush.

	Method ...: FillRectangle (struct*, struct*)
	Info .....:     Indicates to the command sink a rectangle to be filled.
	Param ....:         $tRect   [in]  <$tagD2D1_RECT_F>  The rectangle to fill.
	Param ....:         $oBrush  [in]  <ID2D1Brush>       The brush with which to fill the rectangle.

	Method ...: PushAxisAlignedClip (struct*, uint)
	Info .....:     Pushes a clipping rectangle onto the clip and layer stack.
	Param ....:         $tClipRect       [in]  <$tagD2D1_RECT_F>       The rectangle that defines the clip.
	Param ....:         $iAntialiasMode  [in]  <$D2D1_ANTIALIAS_MODE>  The antialias mode for the clip.

	Method ...: PushLayer (struct*, struct*)
	Info .....:     Pushes a layer onto the clip and layer stack.
	Param ....:         $tLayerParameters  [in]  <$tagD2D1_LAYER_PARAMETERS1>  The parameters that define the layer.
	Param ....:         $oLayer            [in]  <ID2D1Layer>                  The layer resource that receives subsequent drawing operations.

	Method ...: PopAxisAlignedClip ()
	Info .....:     Removes an axis-aligned clip from the layer and clip stack.
	Param ....:         This method has no parameters.

	Method ...: PopLayer ()
	Info .....:     Removes a layer from the layer and clip stack.
	Param ....:         This method has no parameters.
#ce
; _D2D_CommandSink_BeginDraw
; _D2D_CommandSink_EndDraw
; _D2D_CommandSink_SetAntialiasMode
; _D2D_CommandSink_SetTags
; _D2D_CommandSink_SetTextAntialiasMode
; _D2D_CommandSink_SetTextRenderingParams
; _D2D_CommandSink_SetTransform
; _D2D_CommandSink_SetUnitMode
; _D2D_CommandSink_SetPrimitiveBlend
; _D2D_CommandSink_Clear
; _D2D_CommandSink_DrawBitmap
; _D2D_CommandSink_DrawGlyphRun
; _D2D_CommandSink_DrawLine
; _D2D_CommandSink_DrawGeometry
; _D2D_CommandSink_DrawGdiMetafile
; _D2D_CommandSink_DrawRectangle
; _D2D_CommandSink_DrawImage
; _D2D_CommandSink_FillMesh
; _D2D_CommandSink_FillOpacityMask
; _D2D_CommandSink_FillGeometry
; _D2D_CommandSink_FillRectangle
; _D2D_CommandSink_PushAxisAlignedClip
; _D2D_CommandSink_PushLayer
; _D2D_CommandSink_PopAxisAlignedClip
; _D2D_CommandSink_PopLayer





;#######################################################################################################################################################################
;# ID2D1Device
;#######################################################################################################################################################################
#cs   ID2D1Device
	Method ...: ClearResources (uint)
	Info .....:     Clears all of the rendering resources used by Direct2D.
	Param ....:         $iMillisecondsSinceUse  [in]  <uint>  Discards only resources that haven't been used for greater than the specified time in milliseconds. The default is 0 milliseconds.

	Method ...: CreateDeviceContext (uint, ptr*)
	Info .....:     Creates a new device context from a Direct2D device.
	Param ....:         $iOptions        [in]   <$D2D1_DEVICE_CONTEXT_OPTIONS>  The options to be applied to the created device context.
	Param ....:         $oDeviceContext  [out]  <ID2D1DeviceContext>            When this method returns, contains the address of a pointer to the new device context.

	Method ...: CreatePrintControl (struct*, struct*, struct*, ptr*)
	Info .....:     Creates an object that converts primitives stored in into a fixed page representation. The print sub-system then consumes the primitives.
	Param ....:         $oWicFactory              [in]            <IWICImagingFactory>                 A WIC imaging factory.
	Param ....:         $oDocumentTarget          [in]            <IPrintDocumentPackageTarget>        The target print job for this control.
	Param ....:         $tPrintControlProperties  [in, optional]  <$tagD2D1_PRINT_CONTROL_PROPERTIES>  The options to be applied to the print control.
	Param ....:         $oPrintControl            [out]           <ID2D1PrintControl>                  When this method returns, contains the address of a pointer to an object.

	Method ...: GetMaximumTextureMemory (struct*)
	Info .....:     Sets the maximum amount of texture memory Direct2D accumulates before it purges the image caches and cached texture allocations.
	Param ....:         This method has no parameters.

	Method ...: SetMaximumTextureMemory (uint64)
	Info .....:     Sets the maximum amount of texture memory Direct2D accumulates before it purges the image caches and cached texture allocations.
	Param ....:         $iMaximumInBytes  [in]  <uint64>  The new maximum texture memory in bytes.
#ce
; _D2D_Device_ClearResources
; _D2D_Device_CreateDeviceContext
; _D2D_Device_CreatePrintControl
; _D2D_Device_GetMaximumTextureMemory
; _D2D_Device_SetMaximumTextureMemory





;#######################################################################################################################################################################
;# ID2D1DeviceContext
;#######################################################################################################################################################################
#cs   ID2D1DeviceContext
	Method ...: CreateBitmap0
	Info .....:     Creates a bitmap that can be used as a target surface, for reading back to the CPU, or as a source for the and APIs. In addition, color context information can be passed to the bitmap.
	Param ....:         $tSize              [in]            <$tagD2D1_SIZE_U>              The pixel size of the bitmap to be created.
	Param ....:         $pSrcData           [in, optional]  <ptr>                          The initial data that will be loaded into the bitmap.
	Param ....:         $iPitch             [in]            <uint>                         The pitch of the source data, if specified.
	Param ....:         $tBitmapProperties  [in]            <$tagD2D1_BITMAP_PROPERTIES1>  The properties of the bitmap to be created.
	Param ....:         $oBitmap            [out]           <ID2D1Bitmap1>                 When this method returns, contains the address of a pointer to a new bitmap object.

	Method ...: CreateBitmapBrush0
	Info .....:     Creates a bitmap brush, the input image is a Direct2D bitmap object.
	Param ....:         $oBitmap                 [in]            <ID2D1Bitmap>                        The bitmap to use as the brush.
	Param ....:         $tBitmapBrushProperties  [in, optional]  <$tagD2D1_BITMAP_BRUSH_PROPERTIES1>  A bitmap brush properties structure.
	Param ....:         $tBrushProperties        [in, optional]  <$tagD2D1_BRUSH_PROPERTIES>          A brush properties structure.
	Param ....:         $oBitmapBrush            [out]           <ID2D1BitmapBrush1>                  The address of the newly created bitmap brush object.

	Method ...: CreateBitmapFromDxgiSurface (struct*, struct*, ptr*)
	Info .....:     Creates a bitmap from a DXGI surface that can be set as a target surface or have additional color context information specified.
	Param ....:         $oSurface           [in]            <IDXGISurface>                 The DXGI surface from which the bitmap can be created.
	Param ....:         $tBitmapProperties  [in, optional]  <$tagD2D1_BITMAP_PROPERTIES1>  The bitmap properties specified in addition to the surface.
	Param ....:         $oBitmap            [out]           <ID2D1Bitmap1>                 When this method returns, contains the address of a pointer to a new bitmap object.

	Method ...: CreateBitmapFromWicBitmap0
	Info .....:     Creates a Direct2D bitmap by copying a WIC bitmap.
	Param ....:         $oWicBitmapSource   [in]            <IWICBitmapSource>             The WIC bitmap source to copy from.
	Param ....:         $tBitmapProperties  [in, optional]  <$tagD2D1_BITMAP_PROPERTIES1>  A bitmap properties structure that specifies bitmap creation options.
	Param ....:         $oBitmap            [out]           <ID2D1Bitmap1>                 The address of the newly created bitmap object.

	Method ...: CreateColorContext (uint, struct*, uint, ptr*)
	Info .....:     Creates a color context.
	Param ....:         $iSpace         [in]            <$D2D1_COLOR_SPACE>  The space of color context to create.
	Param ....:         $tProfile       [in, optional]  <struct>             A buffer containing the ICC profile bytes used to initialize the color context when space is D2D1_COLOR_SPACE_CUSTOM. For other types, the parameter is ignored and should be set to NULL.
	Param ....:         $iProfileSize   [in]            <uint>               The size in bytes of Profile.
	Param ....:         $oColorContext  [out]           <ID2D1ColorContext>  When this method returns, contains the address of a pointer to a new color context object.

	Method ...: CreateColorContextFromFilename (wstr, ptr*)
	Info .....:     Creates a color context by loading it from the specified filename. The profile bytes are the contents of the file specified by Filename.
	Param ....:         $sFilename      [in]   <wchar>              The path to the file containing the profile bytes to initialize the color context with.
	Param ....:         $oColorContext  [out]  <ID2D1ColorContext>  When this method returns, contains the address of a pointer to a new color context.

	Method ...: CreateColorContextFromWicColorContext (struct*, ptr*)
	Info .....:     Creates a color context from an . The space of the resulting context varies, see Remarks for more info.
	Param ....:         $oWicColorContext  [in]   <IWICColorContext>   The used to initialize the color context.
	Param ....:         $oColorContext     [out]  <ID2D1ColorContext>  When this method returns, contains the address of a pointer to a new color context.

	Method ...: CreateCommandList (ptr*)
	Info .....:     Creates a object.
	Param ....:         $oCommandList  [out]  <ID2D1CommandList>  When this method returns, contains the address of a pointer to a command list.

	Method ...: CreateEffect (struct*, ptr*)
	Info .....:     Creates an effect from a class ID.
	Param ....:         $tEffectId  [in]   <struct>       The class ID of the effect to create.
	Param ....:         $oEffect    [out]  <ID2D1Effect>  When this method returns, contains the address of a pointer to a new effect.

	Method ...: CreateGradientStopCollection0
	Info .....:     Creates a gradient stop collection, enabling the gradient to contain color channels with values outside of [0,1] and also enabling rendering to a high-color render target with interpolation in sRGB space.
	Param ....:         $tGradientStops           [in]   <$tagD2D1_GRADIENT_STOP>          An array of color values and offsets.
	Param ....:         $iGradientStopsCount      [in]   <uint>                            The number of elements in the gradientStops array.
	Param ....:         $iPreInterpolationSpace   [in]   <$D2D1_COLOR_SPACE>               Specifies both the input color space and the space in which the color interpolation occurs.
	Param ....:         $iPostInterpolationSpace  [in]   <$D2D1_COLOR_SPACE>               The color space that colors will be converted to after interpolation occurs.
	Param ....:         $iBufferPrecision         [in]   <$D2D1_BUFFER_PRECISION>          The precision of the texture used to hold interpolated values.
	Param ....:         $iExtendMode              [in]   <$D2D1_EXTEND_MODE>               Defines how colors outside of the range defined by the stop collection are determined.
	Param ....:         $iColorInterpolationMode  [in]   <$D2D1_COLOR_INTERPOLATION_MODE>  Defines how colors are interpolated. D2D1_COLOR_INTERPOLATION_MODE_PREMULTIPLIED is the default, see Remarks for more info.
	Param ....:         $oGradientStopCollection  [out]  <ID2D1GradientStopCollection1>    The new gradient stop collection.

	Method ...: CreateImageBrush (struct*, struct*, struct*, ptr*)
	Info .....:     Creates an image brush. The input image can be any type of image, including a bitmap, effect, or a command list.
	Param ....:         $oImage                 [in]            <ID2D1Image>                       The image to be used as a source for the image brush.
	Param ....:         $tImageBrushProperties  [in]            <$tagD2D1_IMAGE_BRUSH_PROPERTIES>  The properties specific to an image brush.
	Param ....:         $tBrushProperties       [in, optional]  <$tagD2D1_BRUSH_PROPERTIES>        Properties common to all brushes.
	Param ....:         $oImageBrush            [out]           <ID2D1ImageBrush>                  When this method returns, contains the address of a pointer to the input rectangles.

	Method ...: DrawBitmap0
	Info .....:     Draws a bitmap to the render target.
	Param ....:         $oBitmap                [in]            <ID2D1Bitmap>               The bitmap to draw.
	Param ....:         $tDestinationRectangle  [in, optional]  <$tagD2D1_RECT_F>           The destination rectangle. The default is the size of the bitmap and the location is the upper left corner of the render target.
	Param ....:         $fOpacity               [in]            <float>                     The opacity of the bitmap.
	Param ....:         $iInterpolationMode     [in]            <$D2D1_INTERPOLATION_MODE>  The interpolation mode to use.
	Param ....:         $tSourceRectangle       [in, optional]  <$tagD2D1_RECT_F>           An optional source rectangle.
	Param ....:         $iPerspectiveTransform  [in, optional]  <$D2D1_MATRIX_4X4_F>        An optional perspective transform.

	Method ...: DrawGdiMetafile (struct*, struct*)
	Info .....:     Draw a metafile to the device context.
	Param ....:         $oGdiMetafile   [in]            <ID2D1GdiMetafile>   The metafile to draw.
	Param ....:         $tTargetOffset  [in, optional]  <$tagD2D1_POINT_2F>  The offset from the upper left corner of the render target.

	Method ...: DrawGlyphRun0
	Info .....:     Draws a series of glyphs to the device context.
	Param ....:         $tBaselineOrigin       [in]            <$tagD2D1_POINT_2F>             Origin of first glyph in the series.
	Param ....:         $oGlyphRun             [in]            <DWRITE_GLYPH_RUN>              Glyph information including glyph indices, advances, and offsets.
	Param ....:         $oGlyphRunDescription  [in, optional]  <DWRITE_GLYPH_RUN_DESCRIPTION>  Supplementary glyph series information.
	Param ....:         $oForegroundBrush      [in]            <ID2D1Brush>                    The brush that defines the text color.
	Param ....:         $oMeasuringMode        [in]            <DWRITE_MEASURING_MODE>         The measuring mode of the glyph series, used to determine the advances and offsets. The default value is DWRITE_MEASURING_MODE_NATURAL.

	Method ...: DrawImage (struct*, struct*, struct*, uint, uint)
	Info .....:     Draws an image to the device context.
	Param ....:         $oImage              [in]            <ID2D1Image>                The image to be drawn to the device context.
	Param ....:         $tTargetOffset       [in, optional]  <$tagD2D1_POINT_2F>         The offset in the destination space that the image will be rendered to. The entire logical extent of the image will be rendered to the corresponding destination. If not specified, the destination origin will be (0, 0). The top-left corner of the image will be mapped to the target offset. This will not necessarily be the origin. This default value is NULL.
	Param ....:         $tImageRectangle     [in, optional]  <$tagD2D1_RECT_F>           The corresponding rectangle in the image space will be mapped to the given origins when processing the image. This default value is NULL.
	Param ....:         $iInterpolationMode  [in]            <$D2D1_INTERPOLATION_MODE>  The interpolation mode that will be used to scale the image if necessary. The default value is D2D1_IMAGE_INTERPOLATION_BILINEAR.
	Param ....:         $iCompositeMode      [in]            <$D2D1_COMPOSITE_MODE>      The composite mode that will be applied to the limits of the currently selected clip. The default value is D2D1_COMPOSITE_MODE_DEFAULT

	Method ...: FillOpacityMask0
	Info .....:     Fill using the alpha channel of the supplied opacity mask bitmap. The brush opacity will be modulated by the mask. The render target antialiasing mode must be set to aliased.
	Param ....:         $oOpacityMask           [in]            <ID2D1Bitmap>      The bitmap that acts as the opacity mask
	Param ....:         $oBrush                 [in]            <ID2D1Brush>       The brush to use for filling the primitive.
	Param ....:         $tDestinationRectangle  [in, optional]  <$tagD2D1_RECT_F>  The destination rectangle to output to in the render target
	Param ....:         $tSourceRectangle       [in, optional]  <$tagD2D1_RECT_F>  The source rectangle from the opacity mask bitmap.

	Method ...: GetDevice (ptr*)
	Info .....:     Gets the device associated with a device context.
	Param ....:         $oDevice  [out]  <ID2D1Device>  When this method returns, contains the address of a pointer to a Direct2D device associated with this device context.

	Method ...: GetEffectInvalidRectangleCount (struct*, uint*)
	Info .....:     Gets the number of invalid output rectangles that have accumulated on the effect.
	Param ....:         $oEffect          [in]   <ID2D1Effect>  The effect to count the invalid rectangles on.
	Param ....:         $iRectangleCount  [out]  <uint>         The returned rectangle count.

	Method ...: GetEffectInvalidRectangles (struct*, struct*, uint)
	Info .....:     Gets the invalid rectangles that have accumulated since the last time the effect was drawn and was then called on the device context.
	Param ....:         $oEffect           [in]   <ID2D1Effect>      The effect to get the invalid rectangles from.
	Param ....:         $tD2D1_RECT_F      [out]  <$tagD2D1_RECT_F>  An array of structures. You must allocate this to the correct size. You can get the count of the invalid rectangles using the method.
	Param ....:         $iRectanglesCount  [in]   <uint>             The number of rectangles to get.

	Method ...: GetEffectRequiredInputRectangles (struct*, struct*, struct*, struct*, uint)
	Info .....:     Gets the maximum region of each specified input which would be used during a subsequent rendering operation. This method returns the rectangles of effect inputs which Direct2D will use for a certain rendering operation. In cases when the app re-renders the effect inputs to bitmap during each frame, you can use this API to minimize unnecessary rendering on the part of the app.
	Param ....:         $oRenderEffect          [in]            <ID2D1Effect>                        The effect whose output is being rendered.
	Param ....:         $tRenderImageRectangle  [in, optional]  <$tagD2D1_RECT_F>                    This specified the rectangle in local space which will be rendered.
	Param ....:         $tInputDescriptions     [in]            <$tagD2D1_EFFECT_INPUT_DESCRIPTION>  This parameter is completely optional. The rectangles in the structure are useful when the app is querying for information about an input which is not yet bound in the effect graph, but will be bound prior to rendering that effect graph.
	Param ....:         $tRequiredInputRects    [out]           <$tagD2D1_RECT_F>                    The returned input rectangles.
	Param ....:         $iInputCount            [in]            <uint>                               The number of required input rectangles.

	Method ...: GetGlyphRunWorldBounds (float, float, struct*, uint, struct*)
	Info .....:     Gets the world-space bounds in DIPs of the glyph run using the device context DPI.
	Param ....:         $tBaselineOrigin  [in]   <$tagD2D1_POINT_2F>      The origin of the baseline for the glyph run.
	Param ....:         $oGlyphRun        [in]   <DWRITE_GLYPH_RUN>       The glyph run to render.
	Param ....:         $oMeasuringMode   [in]   <DWRITE_MEASURING_MODE>  The DirectWrite measuring mode that indicates how glyph metrics are used to measure text when it is formatted.
	Param ....:         $tBounds          [out]  <$tagD2D1_RECT_F>        The bounds of the glyph run in DIPs and in world space.

	Method ...: GetImageLocalBounds (struct*, struct*)
	Info .....:     Gets the local bounds of an image.
	Param ....:         $oImage        [in]   <ID2D1Image>       The image whose bounds will be calculated.
	Param ....:         $tLocalBounds  [out]  <$tagD2D1_RECT_F>  When this method returns, contains a pointer to the bounds of the image in device independent pixels (DIPs) and in local space.

	Method ...: GetImageWorldBounds (struct*, struct*)
	Info .....:     Gets the world bounds of an image.
	Param ....:         $oImage        [in]   <ID2D1Image>       The image whose bounds will be calculated.
	Param ....:         $tWorldBounds  [out]  <$tagD2D1_RECT_F>  When this method returns, contains a pointer to the bounds of the image in device independent pixels (DIPs).

	Method ...: GetPrimitiveBlend ()
	Info .....:     Returns the currently set primitive blend used by the device context.
	Param ....:         This method has no parameters.

	Method ...: GetRenderingControls (struct*)
	Info .....:     Gets the rendering controls that have been applied to the context.
	Param ....:         $tRenderingControls  [out]  <$tagD2D1_RENDERING_CONTROLS>  When this method returns, contains a pointer to the rendering controls for this context.

	Method ...: GetTarget (ptr*)
	Info .....:     Gets the target currently associated with the device context.
	Param ....:         $oTarget  [out, optional]  <ID2D1Image>  When this method returns, contains the address of a pointer to the target currently associated with the device context.

	Method ...: GetUnitMode ()
	Info .....:     Gets the mode that is being used to interpret values by the device context.
	Param ....:         This method has no parameters.

	Method ...: InvalidateEffectInputRectangle (struct*, uint, struct*)
	Info .....:     This indicates that a portion of an effect's input is invalid. This method can be called many times.
	Param ....:         $oEffect          [in]  <ID2D1Effect>      The effect to invalidate.
	Param ....:         $iInput           [in]  <uint>             The input index.
	Param ....:         $tInputRectangle  [in]  <$tagD2D1_RECT_F>  The rect to invalidate.

	Method ...: IsBufferPrecisionSupported (uint)
	Info .....:     Indicates whether the buffer precision is supported by the underlying Direct3D
	Param ....:         $iBufferPrecision  [in]  <$D2D1_BUFFER_PRECISION>  The buffer precision to check.

	Method ...: IsDxgiFormatSupported (uint)
	Info .....:     Indicates whether the format is supported by the device context. The formats supported are usually determined by the underlying hardware.
	Param ....:         $iDXGI_FORMAT  [in]  <$DXGI_FORMAT>  The DXGI format to check.

	Method ...: PushLayer0
	Info .....:     Push a layer onto the clip and layer stack of the device context.
	Param ....:         $tLayerParameters  [in]            <$tagD2D1_LAYER_PARAMETERS1>  The parameters that defines the layer.
	Param ....:         $oLayer            [in, optional]  <ID2D1Layer>                  The layer resource to push on the device context that receives subsequent drawing operations.

	Method ...: SetPrimitiveBlend (uint)
	Info .....:     Changes the primitive blend mode that is used for all rendering operations in the device context.
	Param ....:         $iPrimitiveBlend  [in]  <$D2D1_PRIMITIVE_BLEND>  The primitive blend to use.

	Method ...: SetRenderingControls (struct*)
	Info .....:     Sets the rendering controls for the given device context.
	Param ....:         $tRenderingControls  [in]  <$tagD2D1_RENDERING_CONTROLS>  The rendering controls to be applied.

	Method ...: SetTarget (struct*)
	Info .....:     The bitmap or command list to which the device context will now render.
	Param ....:         $oTarget  [in, optional]  <ID2D1Image>  The surface or command list to which the Direct2D device context will render.

	Method ...: SetUnitMode (uint)
	Info .....:     Sets what units will be used to interpret values passed into the device context.
	Param ....:         $iUnitMode  [in]  <$D2D1_UNIT_MODE>  An enumeration defining how passed-in units will be interpreted by the device context.
#ce
; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DeviceContext_CreateBitmap
; Description ...: Creates a bitmap that can be used as a target surface, for reading back to the CPU, or as a source for the DrawBitmap and ID2D1BitmapBrush APIs. In addition, color context information can be passed to the bitmap.
; Syntax ........: _D2D_DeviceContext_CreateBitmap($oIDeviceContext, $iWidth, $iHeight[, $iBitmapOptions = 0[, $iFormat = 0[, $iAlphaMode = 0[, $pSrcData = Null[, $iPitch = 0[, $fDpiX = 0[, $fDpiY = 0[, $oColorContext = 0]]]]]]]])
; Parameters ....: $oIDeviceContext - This ID2D1DeviceContext object
;                  $iWidth          - The horizontal size of the bitmap to be created.
;                  $iHeight         - The vertical size of the bitmap to be created.
;                  $iBitmapOptions  - [optional] A $D2D1_BITMAP_OPTIONS enumeraion. The special creation options of the bitmap.
;                  $iFormat         - [optional] The DXGI format to create the bitmap with.
;                  $iAlphaMode      - [optional] A $D2D1_ALPHA_MODE enumeraion. The alpha mode to create the bitmap with.
;                  $pSrcData        - [optional] The initial data that will be loaded into the bitmap.
;                  $iPitch          - [optional] The pitch of the source data, if specified.
;                  $fDpiX           - [optional] The bitmap dpi in the x direction.
;                  $fDpiY           - [optional] The bitmap dpi in the y direction.
;                  $oColorContext   - [optional] An ID2D1ColorContext object. The optionally specified color context information.
; Return values .: Success - An ID2D1Bitmap1 object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The new bitmap can be used as a target for SetTarget if it is created with D2D1_BITMAP_OPTIONS_TARGET.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DeviceContext_CreateBitmap($oIDeviceContext, $iWidth, $iHeight, $iBitmapOptions = 0, $iFormat = 0, $iAlphaMode = 0, $pSrcData = Null, $iPitch = 0, $fDpiX = 0, $fDpiY = 0, $oColorContext = Null)
    If Not IsObj($oIDeviceContext) Then Return SetError($D2DERR_NOOBJ, 0, False)

    Local $tD2D1_BITMAP_PROPERTIES1 = _D2D1_BITMAP_PROPERTIES1($iFormat, $iAlphaMode, $fDpiX, $fDpiY, $iBitmapOptions, $oColorContext)
    If $iFormat = 0 Then $oIDeviceContext.GetPixelFormat($tD2D1_BITMAP_PROPERTIES1)

    Local $pBitmap
    Local $iHResult = $oIDeviceContext.CreateBitmap1(_D2D1_SIZE_U($iWidth, $iHeight), $pSrcData, $iPitch, $tD2D1_BITMAP_PROPERTIES1, $pBitmap)
    If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 1, False)

    Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_ID2D1Bitmap1, $tagID2D1Bitmap1)
    If Not IsObj($oBitmap) Then Return SetError($D2DERR_OBJFAIL, 2, False)
    Return $oBitmap
EndFunc   ;==>_D2D_DeviceContext_CreateBitmap


; _D2D_DeviceContext_CreateBitmapBrush0
; _D2D_DeviceContext_CreateBitmapFromDxgiSurface
; _D2D_DeviceContext_CreateBitmapFromWicBitmap0
; _D2D_DeviceContext_CreateColorContext
; _D2D_DeviceContext_CreateColorContextFromFilename
; _D2D_DeviceContext_CreateColorContextFromWicColorContext
; _D2D_DeviceContext_CreateCommandList




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DeviceContext_CreateEffect
; Description ...: Creates an effect from a class ID.
; Syntax ........: _D2D_DeviceContext_CreateEffect($oIDeviceContext, $tEffectId)
; Parameters ....: $oIDeviceContext - This ID2D1DeviceContext object
;                  $sIID_Effect     - The class ID of the effect to create.
; Return values .: Success - An ID2D1Effect object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If the created effect is a custom effect that is implemented in a DLL, this doesn't increment the reference count for that DLL.
;                  If the application deletes an effect while that effect is loaded, the resulting behavior is unpredictable.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DeviceContext_CreateEffect($oIDeviceContext, $sIID_Effect)
	If Not IsObj($oIDeviceContext) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $tEffectId = _WinAPI_GUIDFromString($sIID_Effect)
	If @error Or Not IsDllStruct($tEffectId) Then Return SetError($D2DERR_PARAM, 1, False)

	Local $pEffect
	Local $iHResult = $oIDeviceContext.CreateEffect($tEffectId, $pEffect)
	If $iHResult Or Not $pEffect Then Return SetError($iHResult, 2, False)

	Local $oEffect = ObjCreateInterface($pEffect, $sIID_ID2D1Effect, $tagID2D1Effect)
	If Not IsObj($oEffect) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oEffect
EndFunc



; _D2D_DeviceContext_CreateGradientStopCollection0




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DeviceContext_CreateImageBrush
; Description ...: Creates an image brush. The input image can be any type of image, including a bitmap, effect, or a command list.
; Syntax ........: _D2D_DeviceContext_CreateImageBrush($oIDeviceContext, $oImage, $fSrcLeft, $fSrcTop, $fSrcRight, $fSrcBottom[, $iExtendModeX = $D2D1_EXTEND_MODE_WRAP[, $iExtendModeY = $D2D1_EXTEND_MODE_WRAP[, $iInterpolationMode = $D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR[, $fOpacity = 1[, $tTransform = Null]]]]])
; Parameters ....: $oIDeviceContext    - This ID2D1DeviceContext object
;                  $oImage             - An ID2D1Image object. The image to be used as a source for the image brush.
;                  $fSrcLeft           - The x-coordinate of the upper-left corner of the source rectangle in the image space from which the
;                                        image will be tiled or interpolated.
;                  $fSrcTop            - The y-coordinate of the upper-left corner of the source rectangle in the image space from which the
;                                        image will be tiled or interpolated.
;                  $fSrcRight          - The x-coordinate of the lower-right corner of the source rectangle in the image space from which the
;                                        image will be tiled or interpolated.
;                  $fSrcBottom         - The y-coordinate of the lower-right corner of the source rectangle in the image space from which the
;                                        image will be tiled or interpolated.
;                  $iExtendModeX       - [optional] A $D2D1_EXTEND_MODE enumeraion. The extend mode in the image x-axis.
;                  $iExtendModeY       - [optional] A $D2D1_EXTEND_MODE enumeraion. The extend mode in the image y-axis.
;                  $iInterpolationMode - [optional] A $D2D1_INTERPOLATION_MODE enumeraion. The interpolation mode to use when scaling the image brush.
;                  $fOpacity           - [optional] A value between 0.0 and 1.0, inclusive, that specifies the degree of opacity of the brush.
;                  $tTransform         - [optional] A $tagD2D1_MATRIX_3X2_F structure. The transformation that is applied to the brush.
; Return values .: Success - An ID2D1ImageBrush object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The image brush can be used to fill an arbitrary geometry, an opacity mask or text.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DeviceContext_CreateImageBrush($oIDeviceContext, $oImage, $fSrcLeft, $fSrcTop, $fSrcRight, $fSrcBottom, $iExtendModeX = $D2D1_EXTEND_MODE_WRAP, $iExtendModeY = $D2D1_EXTEND_MODE_WRAP, $iInterpolationMode = $D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR, $fOpacity = 1, $tTransform = Null)
	If Not IsObj($oIDeviceContext) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not $oImage And Not IsObj($oImage) Then Return SetError($D2DERR_NOOBJ, 1, False)
	Local $tD2D1_IMAGE_BRUSH_PROPERTIES = _D2D1_IMAGE_BRUSH_PROPERTIES($fSrcLeft, $fSrcTop, $fSrcRight, $fSrcBottom, $iExtendModeX, $iExtendModeY, $iInterpolationMode)
	Local $tD2D1_BRUSH_PROPERTIES = _D2D1_BRUSH_PROPERTIES($fOpacity, $tTransform)

	Local $pImageBrush
	Local $iHResult = $oIDeviceContext.CreateImageBrush($oImage, $tD2D1_IMAGE_BRUSH_PROPERTIES, $tD2D1_BRUSH_PROPERTIES, $pImageBrush)
	If $iHResult Or Not $pImageBrush Then Return SetError($iHResult, 2, False)

	Local $oImageBrush = ObjCreateInterface($pImageBrush, $sIID_ID2D1ImageBrush, $tagID2D1ImageBrush)
	If Not IsObj($oImageBrush) Then Return SetError($D2DERR_OBJFAIL, 3, False)
	Return $oImageBrush
EndFunc




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DeviceContext_DrawBitmap
; Description ...: Draws a bitmap to the render target.
; Syntax ........: _D2D_DeviceContext_DrawBitmap($oIDeviceContext, $oBitmap[, $fDstLeft = 0[, $fDstTop = 0[, $fOpacity = 1[, $iInterpolationMode = 0[, $tTransform = Null[, $fDstRight = 0[, $fDstBottom = 0[, $fSrcLeft = 0[, $fSrcTop = 0[, $fSrcRight = 0[, $fSrcBottom = 0]]]]]]]]]]])
; Parameters ....: $oIDeviceContext    - This ID2D1DeviceContext object
;                  $oBitmap            - An ID2D1Bitmap object. The bitmap to draw.
;                  $fDstLeft           - [optional] The x-coordinate of the upper-left corner of the destination rectangle.
;                  $fDstTop            - [optional] The y-coordinate of the upper-left corner of the destination rectangle.
;                  $fOpacity           - [optional] The opacity of the bitmap.
;                  $iInterpolationMode - [optional] A $D2D1_INTERPOLATION_MODE enumeraion. The interpolation mode to use.
;                  $tTransform         - [optional] A $tagD2D1_MATRIX_4X4_F structure. An optional perspective transform.
;                  $fDstRight          - [optional] The x-coordinate of the lower-right corner of the destination rectangle.
;                  $fDstBottom         - [optional] The y-coordinate of the lower-right corner of the destination rectangle.
;                  $fSrcLeft           - [optional] The x-coordinate of the upper-left corner of the rectangle.
;                  $fSrcTop            - [optional] The y-coordinate of the upper-left corner of the rectangle.
;                  $fSrcRight          - [optional] The x-coordinate of the lower-right corner of the rectangle.
;                  $fSrcBottom         - [optional] The y-coordinate of the lower-right corner of the rectangle.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The destinationRectangle parameter defines the rectangle in the target where the bitmap will appear (in device-independent pixels (DIPs)).
;                  This is affected by the currently set transform and the perspective transform, if set. If NULL is specified, then the destination
;                  rectangle is (left=0, top=0, right = width(sourceRectangle), bottom = height(sourceRectangle)).
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DeviceContext_DrawBitmap($oIDeviceContext, $oBitmap, $fDstLeft = 0, $fDstTop = 0, $fOpacity = 1, $iInterpolationMode = 0, $tTransform = Null, $fDstRight = 0, $fDstBottom = 0, $fSrcLeft = 0, $fSrcTop = 0, $fSrcRight = 0, $fSrcBottom = 0)
	If Not IsObj($oIDeviceContext) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oBitmap) Then Return SetError($D2DERR_NOOBJ, 1, False)
	If $tTransform And Not IsDllStruct($tTransform) Then Return SetError($D2DERR_PARAM, 2, False)

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

	$oIDeviceContext.DrawBitmap1($oBitmap, $tDst, $fOpacity, $iInterpolationMode, $tSrc, $tTransform)

	Return True
EndFunc






; _D2D_DeviceContext_DrawGdiMetafile
; _D2D_DeviceContext_DrawGlyphRun0




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DeviceContext_DrawImage
; Description ...: Draws an image to the device context.
; Syntax ........: _D2D_DeviceContext_DrawImage($oIDeviceContext, $oImage[, $fOffsetX = 0[, $fOffsetY = 0[, $iInterpolationMode = $D2D1_INTERPOLATION_MODE_CUBIC[, $iCompositeMode = $D2D1_COMPOSITE_MODE_SOURCE_OVER[, $fLeft = 0[, $fTop = 0[, $fRight = 0[, $fBottom = 0]]]]]]]])
; Parameters ....: $oIDeviceContext    - This ID2D1DeviceContext object
;                  $oImage             - An ID2D1Image object. The image to be drawn to the device context.
;                  $fOffsetX           - [optional] The x-coordinate of the offset in the destination space that the image will be rendered to.
;                  $fOffsetY           - [optional] The y-coordinate of the offset in the destination space that the image will be rendered to.
;                  $iInterpolationMode - [optional] A $D2D1_INTERPOLATION_MODE enumeraion. The interpolation mode that will be used to scale
;                                                   the image if necessary. The default value is D2D1_INTERPOLATION_MODE_CUBIC.
;                  $iCompositeMode     - [optional] A $D2D1_COMPOSITE_MODE enumeraion. The composite mode that will be applied to the limits
;                                                   of the currently selected clip. The default value is D2D1_COMPOSITE_MODE_SOURCE_OVER
;                  $fLeft              - [optional] The x-coordinate of the upper-left corner of the rectangle. - The corresponding rectangle
;                                                   in the image space will be mapped to the given origins when processing the image.
;                  $fTop               - [optional] The y-coordinate of the upper-left corner of the rectangle.
;                  $fRight             - [optional] The x-coordinate of the lower-right corner of the rectangle.
;                  $fBottom            - [optional] The y-coordinate of the lower-right corner of the rectangle.
; Return values .: Success - void
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If "interpolationMode" is D2D1_INTERPOLATION_MODE_HIGH_QUALITY, different scalers will be used depending on the scale factor
;                  implied by the world transform.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DeviceContext_DrawImage($oIDeviceContext, $oImage, $fOffsetX = 0, $fOffsetY = 0, $iInterpolationMode = $D2D1_INTERPOLATION_MODE_CUBIC, $iCompositeMode = $D2D1_COMPOSITE_MODE_SOURCE_OVER, $fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0)
	If Not IsObj($oIDeviceContext) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oImage) And Not $oImage Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $tD2D1_POINT_2F = Null
	If $fOffsetX Or $fOffsetY Then $tD2D1_POINT_2F = _D2D1_POINT_2F($fOffsetX, $fOffsetY)

	Local $tD2D1_RECT_F = Null
	If $fLeft Or $fTop Or $fRight Or $fBottom Then $tD2D1_RECT_F = _D2D1_RECT_F($fLeft, $fTop, $fRight, $fBottom)

	$oIDeviceContext.DrawImage($oImage, $tD2D1_POINT_2F, $tD2D1_RECT_F, $iInterpolationMode, $iCompositeMode)

	Return True
EndFunc


; _D2D_DeviceContext_FillOpacityMask0
; _D2D_DeviceContext_GetDevice
; _D2D_DeviceContext_GetEffectInvalidRectangleCount
; _D2D_DeviceContext_GetEffectInvalidRectangles
; _D2D_DeviceContext_GetEffectRequiredInputRectangles
; _D2D_DeviceContext_GetGlyphRunWorldBounds
; _D2D_DeviceContext_GetImageLocalBounds
; _D2D_DeviceContext_GetImageWorldBounds
; _D2D_DeviceContext_GetPrimitiveBlend
; _D2D_DeviceContext_GetRenderingControls



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_DeviceContext_GetTarget
; Description ...: Gets the target currently associated with the device context.
; Syntax ........: _D2D_DeviceContext_GetTarget($oIDeviceContext)
; Parameters ....: $oIDeviceContext - This ID2D1DeviceContext object
; Return values .: Success - An ID2D1Image object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If a target is not associated with the device context, "target" will contain NULL when the methods returns.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_DeviceContext_GetTarget($oIDeviceContext)
    If Not IsObj($oIDeviceContext) Then Return SetError($D2DERR_NOOBJ, 0, False)

    Local $pTarget
    $oIDeviceContext.GetTarget($pTarget)
    If Not $pTarget Then Return SetError($D2DERR_UFAIL, 1, False)

    Local $oTarget = ObjCreateInterface($pTarget, $sIID_ID2D1Bitmap1, $tagID2D1Bitmap1)
    If Not IsObj($oTarget) Then Return SetError($D2DERR_OBJFAIL, 2, False)
    Return $oTarget
EndFunc   ;==>_D2D_DeviceContext_GetTarget



; _D2D_DeviceContext_GetUnitMode
; _D2D_DeviceContext_InvalidateEffectInputRectangle
; _D2D_DeviceContext_IsBufferPrecisionSupported
; _D2D_DeviceContext_IsDxgiFormatSupported
; _D2D_DeviceContext_PushLayer0
; _D2D_DeviceContext_SetPrimitiveBlend
; _D2D_DeviceContext_SetRenderingControls
; _D2D_DeviceContext_SetTarget
; _D2D_DeviceContext_SetUnitMode





;#######################################################################################################################################################################
;# ID2D1DrawingStateBlock1
;#######################################################################################################################################################################
#cs   ID2D1DrawingStateBlock1
	Method ...: GetDescription1 (struct*)
	Info .....:     Gets the antialiasing mode, transform, tags, primitive blend, and unit mode portion of the drawing state.
	Param ....:         $tStateDescription  [out]  <$tagD2D1_DRAWING_STATE_DESCRIPTION1>  When this method returns, contains the antialiasing mode, transform, tags, primitive blend, and unit mode portion of the drawing state. You must allocate storage for this parameter.

	Method ...: SetDescription1 (struct*)
	Info .....:     Sets the associated with this drawing state block.
	Param ....:         $tStateDescription1  [in]  <$tagD2D1_DRAWING_STATE_DESCRIPTION1>  The D2D1_DRAWING_STATE_DESCRIPTION1 to be set associated with this drawing state block.
#ce
; _D2D_DrawingStateBlock1_GetDescription1
; _D2D_DrawingStateBlock1_SetDescription1





;#######################################################################################################################################################################
;# ID2D1Effect
;#######################################################################################################################################################################
#cs   ID2D1Effect
	Method ...: GetInput (uint, ptr*)
	Info .....:     Gets the given input image by index.
	Param ....:         $iIndex  [in]             <uint>        The index of the image to retrieve.
	Param ....:         $oInput  [out, optional]  <ID2D1Image>  When this method returns, contains the address of a pointer to the image that is identified by Index.

	Method ...: GetInputCount ()
	Info .....:     Gets the number of inputs to the effect.
	Param ....:         This method has no parameters.

	Method ...: GetOutput (ptr*)
	Info .....:     Gets the output image from the effect.
	Param ....:         $oOutputImage  [out]  <ID2D1Image>  When this method returns, contains the address of a pointer to the output image for the effect.

	Method ...: SetInput (uint, struct*, bool)
	Info .....:     Sets the given input image by index.
	Param ....:         $iIndex       [in]            <uint>        The index of the image to set.
	Param ....:         $oInput       [in, optional]  <ID2D1Image>  The input image to set.
	Param ....:         $bInvalidate  [in]            <bool>        Whether to invalidate the graph at the location of the effect input

	Method ...: SetInputCount (uint)
	Info .....:     Allows the application to change the number of inputs to an effect.
	Param ....:         $iInputCount  [in]  <uint>  The number of inputs to the effect.
#ce
; _D2D_Effect_GetInput
; _D2D_Effect_GetInputCount




; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Effect_GetOutput
; Description ...: Gets the output image from the effect.
; Syntax ........: _D2D_Effect_GetOutput($oIEffect)
; Parameters ....: $oIEffect - This ID2D1Effect object
; Return values .: Success - An ID2D1Image object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The output image can be set as an input to another effect, or can be directly passed into the ID2D1DeviceContext in order
;                  to render the effect.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Effect_GetOutput($oIEffect)
	If Not IsObj($oIEffect) Then Return SetError($D2DERR_NOOBJ, 0, False)

	Local $pOutputImage
	$oIEffect.GetOutput($pOutputImage)
	If Not $pOutputImage Then Return SetError($D2DERR_UFAIL, 1, False)

	Local $oOutputImage = ObjCreateInterface($pOutputImage, $sIID_ID2D1Image, $tagID2D1Image)
	If Not IsObj($oOutputImage) Then Return SetError($D2DERR_OBJFAIL, 2, False)
	Return $oOutputImage
EndFunc



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Effect_SetInput
; Description ...: Sets the given input image by index.
; Syntax ........: _D2D_Effect_SetInput($oIEffect, $oInput[, $iIndex = 0[, $bInvalidate = TRUE]])
; Parameters ....: $oIEffect    - This ID2D1Effect object
;                  $oInput      - An ID2D1Image object. The input image to set.
;                  $iIndex      - [optional] The index of the image to set.
;                  $bInvalidate - [optional] Whether to invalidate the graph at the location of the effect input
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If the input index is out of range, the input image is ignored.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Effect_SetInput($oIEffect, $oInput, $iIndex = 0, $bInvalidate = TRUE)
	If Not IsObj($oIEffect) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oInput) Then Return SetError($D2DERR_NOOBJ, 1, False)

	$oIEffect.SetInput($iIndex, $oInput, $bInvalidate)

	Return True
EndFunc



; _D2D_Effect_SetInputCount


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Effect_SetInputEffect
; Description ...: Sets the given input effect by index.
; Syntax ........: _D2D_Effect_SetInputEffect($oIEffect, $oInput[, $iIndex = 0[, $bInvalidate = True]])
; Parameters ....: $oIEffect    - This ID2D1Effect object
;                  $oInput      - An ID2D1Effect object. The input effect to set.
;                  $iIndex      - [optional] The index of the input to set.
;                  $bInvalidate - [optional] Whether to invalidate the graph at the location of the effect input
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
Func _D2D_Effect_SetInputEffect($oIEffect, $oInputEffect, $iIndex = 0, $bInvalidate = True)
	If Not IsObj($oIEffect) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsObj($oInputEffect) Then Return SetError($D2DERR_NOOBJ, 1, False)

	Local $pOutput
	$oInputEffect.GetOutput($pOutPut)
	If Not $pOutPut Then Return SetError($D2DERR_OBJFAIL, 2, False)

	$oIEffect.SetInput($iIndex, $pOutput, $bInvalidate)
	Return True
EndFunc





;#######################################################################################################################################################################
;# ID2D1Factory1
;#######################################################################################################################################################################
#cs   ID2D1Factory1
	Method ...: RegisterEffectFromStream (struct*, struct*, struct*, uint, struct*)
	Info .....:     Registers an effect within the factory instance with the property XML specified as a stream.
	Param ....:         $tClassId        [in]            <struct>                  The identifier of the effect to be registered.
	Param ....:         $oPropertyXml    [in]            <IStream>                 A list of the effect properties, types, and metadata.
	Param ....:         $iBindings       [in, optional]  <$D2D1_PROPERTY_BINDING>  An array of properties and methods.
	Param ....:         $iBindingsCount  [in]            <uint>                    Type:
	Param ....:         $iEffectFactory  [in]            <$PD2D1_EFFECT_FACTORY>   Type:

	Method ...: CreateGdiMetafile (struct*, ptr*)
	Info .....:     Creates a new object that you can use to replay metafile content.
	Param ....:         $oMetafileStream  [in]   <IStream>           A stream object that has the metafile data.
	Param ....:         $oMetafile        [out]  <ID2D1GdiMetafile>  The address of the newly created GDI metafile object.

	Method ...: CreateDrawingStateBlock0
	Info .....:     Creates a new drawing state block, this can be used in subsequent SaveDrawingState and RestoreDrawingState operations on the render target.
	Param ....:         $tDrawingStateDescription  [in, optional]  <$tagD2D1_DRAWING_STATE_DESCRIPTION1>  The drawing state description structure.
	Param ....:         $oTextRenderingParams      [in, optional]  <IDWriteRenderingParams>               The DirectWrite rendering params interface.
	Param ....:         $oDrawingStateBlock        [out]           <ID2D1DrawingStateBlock1>              The address of the newly created drawing state block.

	Method ...: CreateDevice (struct*, ptr*)
	Info .....:     Creates a device that represents a display adapter.
	Param ....:         $oDxgiDevice  [in]   <IDXGIDevice>  The object used when creating the .
	Param ....:         $oD2dDevice   [out]  <ID2D1Device>  The requested object.

	Method ...: RegisterEffectFromString (struct*, wstr, struct*, uint, struct*)
	Info .....:     Registers an effect within the factory instance with the property XML specified as a string.
	Param ....:         $tClassId        [in]            <struct>                  The identifier of the effect to be registered.
	Param ....:         $sPropertyXml    [in]            <wchar>                   A list of the effect properties, types, and metadata.
	Param ....:         $iBindings       [in, optional]  <$D2D1_PROPERTY_BINDING>  An array of properties and methods.
	Param ....:         $iBindingsCount  [in]            <uint>                    Type:
	Param ....:         $iEffectFactory  [in]            <$PD2D1_EFFECT_FACTORY>   Type:

	Method ...: UnregisterEffect (struct*)
	Info .....:     Unregisters an effect within the factory instance that corresponds to the classId provided.
	Param ....:         $tClassId  [in]  <struct>  The identifier of the effect to be unregistered.

	Method ...: GetRegisteredEffects (struct*, uint, uint*, uint*)
	Info .....:     Returns the class IDs of the currently registered effects and global effects on this factory.
	Param ....:         $tEffects            [out]            <struct>  When this method returns, contains an array of effects. NULL if no effects are retrieved.
	Param ....:         $iEffectCount        [in]             <uint>    The capacity of the effects array.
	Param ....:         $iEffectsReturned    [out]            <uint>    When this method returns, contains the number of effects copied into effects.
	Param ....:         $iEffectsRegistered  [out, optional]  <uint>    When this method returns, contains the number of effects currently registered in the system.

	Method ...: GetEffectProperties (struct*, ptr*)
	Info .....:     Retrieves the properties of an effect.
	Param ....:         $tEffectId    [in]   <struct>           The ID of the effect to retrieve properties from.
	Param ....:         $oProperties  [out]  <ID2D1Properties>  When this method returns, contains the address of a pointer to the property interface that can be used to query the metadata of the effect.

	Method ...: CreateStrokeStyle0
	Info .....:     Creates a object.
	Param ....:         $tStrokeStyleProperties  [in]   <$tagD2D1_STROKE_STYLE_PROPERTIES1>  The stroke style properties to apply.
	Param ....:         $fDashes                 [in]   <float>                              An array of widths for the dashes and gaps.
	Param ....:         $iDashesCount            [in]   <uint>                               The size of the dash array.
	Param ....:         $oStrokeStyle            [out]  <ID2D1StrokeStyle1>                  When this method returns, contains the address of a pointer to the newly created stroke style.

	Method ...: CreatePathGeometry0
	Info .....:     Creates an object.
	Param ....:         $oPathGeometry  [out]  <ID2D1PathGeometry>  When this method returns, contains the address of a pointer to the newly created path geometry.
#ce


; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Factory1_Create
; Description ...: Creates a factory object that can be used to create Direct2D resources.
; Syntax ........: _D2D_Factory1_Create()
; Parameters ....:
; Return values .: Success - An ID2D1Factory1 Object.
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
Func _D2D_Factory1_Create()
	Local $tIID_ID2D1Factory1 = _WinAPI_GUIDFromString($sIID_ID2D1Factory1)

	Local $aResult = DllCall($__g_hD2D1DLL, "int", "D2D1CreateFactory", "uint", 0, "struct*", $tIID_ID2D1Factory1, "uint*", 0, "ptr*", 0)
	If @error Or $aResult[0] Then Return SetError(1, 1, False)

	Local $oObj = ObjCreateInterface($aResult[4], $sIID_ID2D1Factory1, $tagID2D1Factory1)
	If Not IsObj($oObj) Then Return SetError($D2DERR_OBJFAIL, 2, False)

	Return $oObj
EndFunc   ;==>_ID2D1Factory1_Create



; _D2D_Factory1_RegisterEffectFromStream
; _D2D_Factory1_CreateGdiMetafile
; _D2D_Factory1_CreateDrawingStateBlock0
; _D2D_Factory1_CreateDevice
; _D2D_Factory1_RegisterEffectFromString
; _D2D_Factory1_UnregisterEffect
; _D2D_Factory1_GetRegisteredEffects
; _D2D_Factory1_GetEffectProperties
; _D2D_Factory1_CreateStrokeStyle0
; _D2D_Factory1_CreatePathGeometry0





;#######################################################################################################################################################################
;# ID2D1GdiMetafile
;#######################################################################################################################################################################
#cs   ID2D1GdiMetafile
	Method ...: GetBounds (struct*)
	Info .....:     Gets the bounds of the metafile, in device-independent pixels (DIPs), as reported in the metafile’s header.
	Param ....:         $tBounds  [out]  <$tagD2D1_RECT_F>  The bounds, in DIPs, of the metafile.

	Method ...: Stream (struct*)
	Info .....:     This method streams the contents of the command to the given metafile sink.
	Param ....:         $oMetafileSink  [in]  <ID2D1GdiMetafileSink>  The sink into which Direct2D will call back.
#ce
; _D2D_GdiMetafile_GetBounds
; _D2D_GdiMetafile_Stream





;#######################################################################################################################################################################
;# ID2D1GdiMetafileSink
;#######################################################################################################################################################################
#cs   ID2D1GdiMetafileSink
	Method ...: ProcessRecord (uint, struct*, uint)
	Info .....:     This method is called once for each record stored in a metafile.
	Param ....:         $iRecordType      [in]   <uint>  The type of the record.
	Param ....:         $pRecordData      [out]  <ptr>   The data for the record.
	Param ....:         $iRecordDataSize  [in]   <uint>  The byte size of the record data.
#ce
; _D2D_GdiMetafileSink_ProcessRecord





;#######################################################################################################################################################################
;# ID2D1GradientStopCollection1
;#######################################################################################################################################################################
#cs   ID2D1GradientStopCollection1
	Method ...: GetGradientStops1 (struct*, uint)
	Info .....:     Copies the gradient stops from the collection into memory.
	Param ....:         $tGradientStops       [out]  <$tagD2D1_GRADIENT_STOP>  When this method returns, contains a pointer to a one-dimensional array of structures.
	Param ....:         $iGradientStopsCount  [in]   <uint>                    The number of gradient stops to copy.

	Method ...: GetPreInterpolationSpace ()
	Info .....:     Gets the color space of the input colors as well as the space in which gradient stops are interpolated.
	Param ....:         This method has no parameters.

	Method ...: GetPostInterpolationSpace ()
	Info .....:     Gets the color space after interpolation has occurred.
	Param ....:         This method has no parameters.

	Method ...: GetBufferPrecision ()
	Info .....:     Gets the precision of the gradient buffer.
	Param ....:         This method has no parameters.

	Method ...: GetColorInterpolationMode ()
	Info .....:     Retrieves the color interpolation mode that the gradient stop collection uses.
	Param ....:         This method has no parameters.
#ce
; _D2D_GradientStopCollection1_GetGradientStops1
; _D2D_GradientStopCollection1_GetPreInterpolationSpace
; _D2D_GradientStopCollection1_GetPostInterpolationSpace
; _D2D_GradientStopCollection1_GetBufferPrecision
; _D2D_GradientStopCollection1_GetColorInterpolationMode





;#######################################################################################################################################################################
;# ID2D1ImageBrush
;#######################################################################################################################################################################
#cs   ID2D1ImageBrush
	Method ...: GetExtendModeX ()
	Info .....:     Gets the extend mode of the image brush on the x-axis.
	Param ....:         This method has no parameters.

	Method ...: GetExtendModeY ()
	Info .....:     Gets the extend mode of the image brush on the y-axis of the image.
	Param ....:         This method has no parameters.

	Method ...: GetImage (ptr*)
	Info .....:     Gets the image associated with the image brush.
	Param ....:         $oImage  [out]  <ID2D1Image>  When this method returns, contains the address of a pointer to the image associated with this brush.

	Method ...: GetInterpolationMode ()
	Info .....:     Gets the interpolation mode of the image brush.
	Param ....:         This method has no parameters.

	Method ...: GetSourceRectangle (struct*)
	Info .....:     Gets the rectangle that will be used as the bounds of the image when drawn as an image brush.
	Param ....:         $tSourceRectangle  [out]  <$tagD2D1_RECT_F>  When this method returns, contains the address of the output source rectangle.

	Method ...: SetExtendModeX (uint)
	Info .....:     Sets how the content inside the source rectangle in the image brush will be extended on the x-axis.
	Param ....:         $iExtendModeX  [in]  <$D2D1_EXTEND_MODE>  The extend mode on the x-axis of the image.

	Method ...: SetExtendModeY (uint)
	Info .....:     Sets the extend mode on the y-axis.
	Param ....:         $iExtendModeY  [in]  <$D2D1_EXTEND_MODE>  The extend mode on the y-axis of the image.

	Method ...: SetImage (struct*)
	Info .....:     Sets the image associated with the provided image brush.
	Param ....:         $oImage  [in]  <ID2D1Image>  The image to be associated with the image brush.

	Method ...: SetInterpolationMode (uint)
	Info .....:     Sets the interpolation mode for the image brush.
	Param ....:         $iInterpolationMode  [in]  <$D2D1_INTERPOLATION_MODE>  How the contents of the image will be interpolated to handle the brush transform.

	Method ...: SetSourceRectangle (struct*)
	Info .....:     Sets the source rectangle in the image brush.
	Param ....:         $tSourceRectangle  [in]  <$tagD2D1_RECT_F>  The source rectangle that defines the portion of the image to tile.
#ce
; _D2D_ImageBrush_GetExtendModeX
; _D2D_ImageBrush_GetExtendModeY
; _D2D_ImageBrush_GetImage
; _D2D_ImageBrush_GetInterpolationMode
; _D2D_ImageBrush_GetSourceRectangle
; _D2D_ImageBrush_SetExtendModeX
; _D2D_ImageBrush_SetExtendModeY
; _D2D_ImageBrush_SetImage
; _D2D_ImageBrush_SetInterpolationMode
; _D2D_ImageBrush_SetSourceRectangle





;#######################################################################################################################################################################
;# ID2D1PathGeometry1
;#######################################################################################################################################################################
#cs   ID2D1PathGeometry1
	Method ...: ComputePointAndSegmentAtLength (float, uint, struct*, float, struct*)
	Info .....:     Computes the point that exists at a given distance along the path geometry along with the index of the segment the point is on and the directional vector at that point.
	Param ....:         $fLength               [in]            <float>                       The distance to walk along the path.
	Param ....:         $iStartSegment         [in]            <uint>                        The index of the segment at which to begin walking. Note: This index is global to the entire path, not just a particular figure.
	Param ....:         $tWorldTransform       [in, optional]  <$tagD2D1_MATRIX_3X2_F>       The transform to apply to the path prior to walking.
	Param ....:         $fFlatteningTolerance  [in]            <float>                       The flattening tolerance to use when walking along an arc or Bezier segment. The flattening tolerance is the maximum error allowed when constructing a polygonal approximation of the geometry. No point in the polygonal representation will diverge from the original geometry by more than the flattening tolerance. Smaller values produce more accurate results but cause slower execution.
	Param ....:         $tPointDescription     [out]           <$tagD2D1_POINT_DESCRIPTION>  When this method returns, contains a description of the point that can be found at the given location.
#ce
; _D2D_PathGeometry1_ComputePointAndSegmentAtLength





;#######################################################################################################################################################################
;# ID2D1PrintControl
;#######################################################################################################################################################################
#cs   ID2D1PrintControl
	Method ...: AddPage (struct*, float, float, struct*, uint64*, uint64*)
	Info .....:     Converts Direct2D primitives in the passed-in command list into a fixed page representation for use by the print subsystem.
	Param ....:         $oCommandList            [in]             <ID2D1CommandList>  The command list that contains the rendering operations.
	Param ....:         $iPageSize               [in]             <$D2D_SIZE_F>       The size of the page to add.
	Param ....:         $oPagePrintTicketStream  [in, out]        <IStream>           The print ticket stream.
	Param ....:         $iTag1                   [out, optional]  <$D2D1_TAG>         Contains the first label for subsequent drawing operations. This parameter is passed uninitialized. If NULL is specified, no value is retrieved for this parameter.
	Param ....:         $iTag2                   [out, optional]  <$D2D1_TAG>         Contains the second label for subsequent drawing operations. This parameter is passed uninitialized. If NULL is specified, no value is retrieved for this parameter.

	Method ...: Close ()
	Info .....:     Passes all remaining resources to the print sub-system, then clean up and close the current print job.
	Param ....:         This method has no parameters.
#ce
; _D2D_PrintControl_AddPage
; _D2D_PrintControl_Close





;#######################################################################################################################################################################
;# ID2D1Properties
;#######################################################################################################################################################################
#cs   ID2D1Properties
	Method ...: GetPropertyCount ()
	Info .....:     Gets the number of top-level properties.
	Param ....:         This method has no parameters.

	Method ...: GetPropertyIndex (wstr)
	Info .....:     Gets the index corresponding to the given property name.
	Param ....:         $sName  [in]  <wchar>  The name of the property to retrieve.

	Method ...: GetPropertyName (uint, wstr, uint)
	Info .....:     Gets the property name that corresponds to the given index.
	Param ....:         $iIndex      [in]   <uint>   The index of the property for which the name is being returned.
	Param ....:         $sName       [out]  <wchar>  When this method returns, contains the name being retrieved.
	Param ....:         $iNameCount  [in]   <uint>   The number of characters in the name buffer.

	Method ...: GetPropertyNameLength (uint)
	Info .....:     Gets the number of characters for the given property name.
	Param ....:         $iIndex  [in]  <uint>  The index of the property name to retrieve.

	Method ...: GetSubProperties (uint, ptr*)
	Info .....:     Gets the sub-properties of the provided property by index.
	Param ....:         $iIndex          [in]   <uint>             The index of the sub-properties to be retrieved.
	Param ....:         $oSubProperties  [out]  <ID2D1Properties>  When this method returns, contains the address of a pointer to the sub-properties.

	Method ...: GetType (uint)
	Info .....:     Gets the of the selected property.
	Param ....:         $iIndex  [in]  <uint>  The index of the property for which the type will be retrieved.

	Method ...: GetValue (uint, uint, struct*, uint)
	Info .....:     Gets the value of the specified property by index.
	Param ....:         $iIndex     [in]   <uint>                 The index of the property from which the data is to be obtained.
	Param ....:         $iType      [in]   <$D2D1_PROPERTY_TYPE>  A -typed value that specifies the type of property to get.
	Param ....:         $tData      [out]  <struct>               When this method returns, contains a pointer to the data requested.
	Param ....:         $iDataSize  [in]   <uint>                 The number of bytes in the data to be retrieved.

	Method ...: GetValueByName (wstr, uint, struct*, uint)
	Info .....:     Gets the property value by name.
	Param ....:         $sName      [in]   <wchar>                The property name to get.
	Param ....:         $iType      [in]   <$D2D1_PROPERTY_TYPE>  A -typed value that specifies the type of property to get.
	Param ....:         $tData      [out]  <struct>               When this method returns, contains the buffer with the data value.
	Param ....:         $iDataSize  [in]   <uint>                 The number of bytes in the data to be retrieved.

	Method ...: GetValueSize (uint)
	Info .....:     Gets the size of the property value in bytes, using the property index.
	Param ....:         $iIndex  [in]  <uint>  The index of the property.

	Method ...: SetValue (uint, uint, struct*, uint)
	Info .....:     Sets the given value by using the property index.
	Param ....:         $iIndex     [in]  <uint>                 The index of the property to set.
	Param ....:         $iType      [in]  <$D2D1_PROPERTY_TYPE>  A -typed value that specifies the type of property to set.
	Param ....:         $tData      [in]  <struct>               The data to set.
	Param ....:         $iDataSize  [in]  <uint>                 The number of bytes in the data to set.

	Method ...: SetValueByName (wstr, uint, struct*, uint)
	Info .....:     Sets the named property to the given value.
	Param ....:         $sName      [in]  <wchar>   The name of the property to set.
	Param ....:         $tData      [in]  <struct>  The data to set.
	Param ....:         $iDataSize  [in]  <uint>    The number of bytes in the data to set.
#ce
; _D2D_Properties_GetPropertyCount
; _D2D_Properties_GetPropertyIndex
; _D2D_Properties_GetPropertyName
; _D2D_Properties_GetPropertyNameLength
; _D2D_Properties_GetSubProperties
; _D2D_Properties_GetType
; _D2D_Properties_GetValue
; _D2D_Properties_GetValueByName
; _D2D_Properties_GetValueSize



; #FUNCTION# ====================================================================================================================
; Name ..........: _D2D_Properties_SetValue
; Description ...: Sets the given value by using the property index.
; Syntax ........: _D2D_Properties_SetValue($oIProperties, $iIndex, $iType, $tData)
; Parameters ....: $oIProperties - This ID2D1Properties object
;                  $iIndex       - The index of the property to set.
;                  $iType        - A $D2D1_PROPERTY_TYPE-typed value that specifies the type of property to set.
;                  $tData        - A $tagD2D1_... structure. The data to set.
; Return values .: Success - True
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If the property does not exist, the request is ignored and D2DERR_INVALID_PROPERTY is returned.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _D2D_Properties_SetValue($oIProperties, $iIndex, $iType, $tData)
	If Not IsObj($oIProperties) Then Return SetError($D2DERR_NOOBJ, 0, False)
	If Not IsDllStruct($tData) Then Return SetError($D2DERR_PARAM, 1, False)

	Local $iHResult = $oIProperties.SetValue($iIndex, $iType, $tData, DllStructGetSize($tData))
	If $iHResult Then Return SetError($iHResult, 2, False)

	Return True
EndFunc


; _D2D_Properties_SetValueByName





;#######################################################################################################################################################################
;# ID2D1StrokeStyle1
;#######################################################################################################################################################################
#cs   ID2D1StrokeStyle1
	Method ...: GetStrokeTransformType ()
	Info .....:     Gets the stroke transform type.
	Param ....:         This method has no parameters.
#ce
; _D2D_StrokeStyle1_GetStrokeTransformType












;############################################################################################################
;# D2D1_BASETYPES Helper
;############################################################################################################
Func _D2D1_RECT_L($iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0)
	Local $tStruct = DllStructCreate($tagD2D1_RECT_L)
	$tStruct.Left = $iLeft
	$tStruct.Top = $iTop
	$tStruct.Right = $iRight
	$tStruct.Bottom = $iBottom
	Return $tStruct
EndFunc

Func _D2D1_POINT_2L($iX = 0, $iY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_POINT_2L)
	$tStruct.X = $iX
	$tStruct.Y = $iY
	Return $tStruct
EndFunc

Func _D2D1_VECTOR_2F($fX = 0, $fY = 0)
	Local $tStruct = DllStructCreate($tagD2D1_VECTOR_2F)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	Return $tStruct
EndFunc

Func _D2D1_VECTOR_3F($fX = 0, $fY = 0, $fZ = 0)
	Local $tStruct = DllStructCreate($tagD2D1_VECTOR_3F)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	$tStruct.Z = $fZ
	Return $tStruct
EndFunc

Func _D2D1_VECTOR_4F($fX = 0, $fY = 0, $fZ = 0, $fW = 0)
	Local $tStruct = DllStructCreate($tagD2D1_VECTOR_4F)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	$tStruct.Z = $fZ
	$tStruct.W = $fW
	Return $tStruct
EndFunc










;############################################################################################################
;# D2D1_STRUCTURES Helper
;############################################################################################################
Func _D2D1_BITMAP_PROPERTIES1($iPixelformat = 0, $iAlphaMode = 0, $fDpiX = 0, $fDpiY = 0, $iBitmapoptions = 0, $pColorcontext = 0)
	Local $tStruct = DllStructCreate($tagD2D1_BITMAP_PROPERTIES1)
	$tStruct.Pixelformat = $iPixelformat
	$tStruct.AlphaMode = $iAlphaMode
	$tStruct.DpiX = $fDpiX
	$tStruct.DpiY = $fDpiY
	$tStruct.Bitmapoptions = $iBitmapoptions
	If IsObj($pColorcontext) Then
		$tStruct.Colorcontext = $pColorcontext()
	Else
		$tStruct.Colorcontext = $pColorcontext
	EndIf
	Return $tStruct
EndFunc

Func _D2D1_MAPPED_RECT($iPitch = 0, $pBits = 0)
	Local $tStruct = DllStructCreate($tagD2D1_MAPPED_RECT)
	$tStruct.Pitch = $iPitch
	$tStruct.Bits = $pBits
	Return $tStruct
EndFunc

Func _D2D1_RENDERING_CONTROLS($iBufferprecision = 0, $iTilesizeW = 0, $iTilesizeH = 0)
	Local $tStruct = DllStructCreate($tagD2D1_RENDERING_CONTROLS)
	$tStruct.Bufferprecision = $iBufferprecision
	$tStruct.TilesizeW = $iTilesizeW
	$tStruct.TilesizeH = $iTilesizeH
	Return $tStruct
EndFunc

Func _D2D1_EFFECT_INPUT_DESCRIPTION($pEffect = 0, $iInputindex = 0, $fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0)
	Local $tStruct = DllStructCreate($tagD2D1_EFFECT_INPUT_DESCRIPTION)
	$tStruct.Effect = $pEffect
	$tStruct.Inputindex = $iInputindex
	$tStruct.Left = $fLeft
	$tStruct.Top = $fTop
	$tStruct.Right = $fRight
	$tStruct.Bottom = $fBottom
	Return $tStruct
EndFunc

Func _D2D1_POINT_DESCRIPTION($fX = 0, $fY = 0, $fVX = 0, $fVY = 0, $iEndsegment = 0, $iEndfigure = 0, $fLengthtoendsegment = 0)
	Local $tStruct = DllStructCreate($tagD2D1_POINT_DESCRIPTION)
	$tStruct.X = $fX
	$tStruct.Y = $fY
	$tStruct.VX = $fVX
	$tStruct.VY = $fVY
	$tStruct.Endsegment = $iEndsegment
	$tStruct.Endfigure = $iEndfigure
	$tStruct.Lengthtoendsegment = $fLengthtoendsegment
	Return $tStruct
EndFunc

Func _D2D1_IMAGE_BRUSH_PROPERTIES($fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0, $iExtendmodeX = 0, $iExtendmodeY = 0, $iInterpolationmode = 0)
	Local $tStruct = DllStructCreate($tagD2D1_IMAGE_BRUSH_PROPERTIES)
	$tStruct.Left = $fLeft
	$tStruct.Top = $fTop
	$tStruct.Right = $fRight
	$tStruct.Bottom = $fBottom
	$tStruct.ExtendmodeX = $iExtendmodeX
	$tStruct.ExtendmodeY = $iExtendmodeY
	$tStruct.Interpolationmode = $iInterpolationmode
	Return $tStruct
EndFunc

Func _D2D1_BITMAP_BRUSH_PROPERTIES1($iExtendmodeX = 0, $iExtendmodeY = 0, $iInterpolationmode = 0)
	Local $tStruct = DllStructCreate($tagD2D1_BITMAP_BRUSH_PROPERTIES1)
	$tStruct.ExtendmodeX = $iExtendmodeX
	$tStruct.ExtendmodeY = $iExtendmodeY
	$tStruct.Interpolationmode = $iInterpolationmode
	Return $tStruct
EndFunc

Func _D2D1_STROKE_STYLE_PROPERTIES1($iStartcap = 0, $iEndcap = 0, $iDashcap = 0, $iLinejoin = 0, $fMiterlimit = 0, $iDashstyle = 0, $fDashoffset = 0, $iTransformtype = 0)
	Local $tStruct = DllStructCreate($tagD2D1_STROKE_STYLE_PROPERTIES1)
	$tStruct.Startcap = $iStartcap
	$tStruct.Endcap = $iEndcap
	$tStruct.Dashcap = $iDashcap
	$tStruct.Linejoin = $iLinejoin
	$tStruct.Miterlimit = $fMiterlimit
	$tStruct.Dashstyle = $iDashstyle
	$tStruct.Dashoffset = $fDashoffset
	$tStruct.Transformtype = $iTransformtype
	Return $tStruct
EndFunc

Func _D2D1_LAYER_PARAMETERS1($fLeft = 0, $fTop = 0, $fRight = 0, $fBottom = 0, $pGeometricmask = 0, $iMaskantialiasmode = 0, $fM11 = 0, $fM12 = 0, $fM21 = 0, $fM22 = 0, $fM31 = 0, $fM32 = 0, $fOpacity = 0, $pOpacitybrush = 0, $iLayeroptions = 0)
	Local $tStruct = DllStructCreate($tagD2D1_LAYER_PARAMETERS1)
	$tStruct.Left = $fLeft
	$tStruct.Top = $fTop
	$tStruct.Right = $fRight
	$tStruct.Bottom = $fBottom
	$tStruct.Geometricmask = $pGeometricmask
	$tStruct.Maskantialiasmode = $iMaskantialiasmode
	$tStruct.M11 = $fM11
	$tStruct.M12 = $fM12
	$tStruct.M21 = $fM21
	$tStruct.M22 = $fM22
	$tStruct.M31 = $fM31
	$tStruct.M32 = $fM32
	$tStruct.Opacity = $fOpacity
	$tStruct.Opacitybrush = $pOpacitybrush
	$tStruct.Layeroptions = $iLayeroptions
	Return $tStruct
EndFunc

Func _D2D1_DRAWING_STATE_DESCRIPTION1($iAntialiasmode = 0, $iTextantialiasmode = 0, $iTag1 = 0, $iTag2 = 0, $fM11 = 0, $fM12 = 0, $fM21 = 0, $fM22 = 0, $fM31 = 0, $fM32 = 0, $iPrimitiveblend = 0, $iUnitmode = 0)
	Local $tStruct = DllStructCreate($tagD2D1_DRAWING_STATE_DESCRIPTION1)
	$tStruct.Antialiasmode = $iAntialiasmode
	$tStruct.Textantialiasmode = $iTextantialiasmode
	$tStruct.Tag1 = $iTag1
	$tStruct.Tag2 = $iTag2
	$tStruct.M11 = $fM11
	$tStruct.M12 = $fM12
	$tStruct.M21 = $fM21
	$tStruct.M22 = $fM22
	$tStruct.M31 = $fM31
	$tStruct.M32 = $fM32
	$tStruct.Primitiveblend = $iPrimitiveblend
	$tStruct.Unitmode = $iUnitmode
	Return $tStruct
EndFunc

Func _D2D1_PRINT_CONTROL_PROPERTIES($iFontsubset = 0, $fRasterdpi = 0, $iColorspace = 0)
	Local $tStruct = DllStructCreate($tagD2D1_PRINT_CONTROL_PROPERTIES)
	$tStruct.Fontsubset = $iFontsubset
	$tStruct.Rasterdpi = $fRasterdpi
	$tStruct.Colorspace = $iColorspace
	Return $tStruct
EndFunc

Func _D2D1_CREATION_PROPERTIES($iThreadingmode = 0, $iDebuglevel = 0, $iOptions = 0)
	Local $tStruct = DllStructCreate($tagD2D1_CREATION_PROPERTIES)
	$tStruct.Threadingmode = $iThreadingmode
	$tStruct.Debuglevel = $iDebuglevel
	$tStruct.Options = $iOptions
	Return $tStruct
EndFunc










Func _D2D1_MATRIX_4X4_F($fM11 = 1, $fM12 = 0, $fM13 = 0, $fM14 = 0, $fM21 = 0, $fM22 = 1, $fM23 = 0, $fM24 = 0, $fM31 = 0, $fM32 = 0, $fM33 = 1, $fM34 = 0, $fM41 = 0, $fM42 = 0, $fM43 = 0, $fM44 = 1)
	Local $tStruct = DllStructCreate($tagD2D1_MATRIX_4X4_F)
	$tStruct.M1(1) = $fM11
	$tStruct.M1(2) = $fM12
	$tStruct.M1(3) = $fM13
	$tStruct.M1(4) = $fM14

	$tStruct.M2(1) = $fM21
	$tStruct.M2(2) = $fM22
	$tStruct.M2(3) = $fM23
	$tStruct.M2(4) = $fM24

	$tStruct.M3(1) = $fM31
	$tStruct.M3(2) = $fM32
	$tStruct.M3(3) = $fM33
	$tStruct.M3(4) = $fM34

	$tStruct.M4(1) = $fM41
	$tStruct.M4(2) = $fM42
	$tStruct.M4(3) = $fM43
	$tStruct.M4(4) = $fM44

	Return $tStruct
EndFunc   ;==>_D2D1_MATRIX_4X4_F







;############################################################################################################
;# D2D1_MATRIX_4X4_F
;############################################################################################################
Func _D2D_Matrix4x4_Translation($fX = 0, $fY = 0, $fZ = 0)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_4X4_F)

	$tMX.M1(1) = 1
	$tMX.M2(2) = 1
	$tMX.M3(3) = 1
	$tMX.M4(1) = $fX
	$tMX.M4(2) = $fY
	$tMX.M4(3) = $fZ
	$tMX.M4(4) = 1

	Return $tMX
EndFunc   ;==>_D2D_Matrix4x4_Translation


Func _D2D_Matrix4x4_Scale($fX = 1, $fY = 1, $fZ = 1)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_4X4_F)

	$tMX.M1(1) = $fX
	$tMX.M2(2) = $fY
	$tMX.M3(3) = $fZ
	$tMX.M4(4) = 1

	Return $tMX
EndFunc   ;==>_D2D_Matrix4x4_Scale


Func _D2D_Matrix4x4_RotationX($fAngle = 0)
	Local $fRad = $fAngle * 0.0174532925222222
	Local $fSin = Sin($fRad)
	Local $fCos = Cos($fRad)

	Return _D2D1_MATRIX_4X4_F(1, 0, 0, 0, 0, $fCos, $fSin, 0, 0, -$fSin, $fCos, 0, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_RotationX


Func _D2D_Matrix4x4_RotationY($fAngle = 0)
	Local $fRad = $fAngle * 0.0174532925222222
	Local $fSin = Sin($fRad)
	Local $fCos = Cos($fRad)

	Return _D2D1_MATRIX_4X4_F($fCos, 0, -$fSin, 0, 0, 1, 0, 0, $fSin, 0, $fCos, 0, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_RotationY


Func _D2D_Matrix4x4_RotationZ($fAngle = 0)
	Local $fRad = $fAngle * 0.0174532925222222
	Local $fSin = Sin($fRad)
	Local $fCos = Cos($fRad)

	Return _D2D1_MATRIX_4X4_F($fCos, $fSin, 0, 0, -$fSin, $fCos, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_RotationZ


;3D Rotation matrix for an arbitrary axis specified by x, y and z
Func _D2D_Matrix4x4_RotationArbitraryAxis($fX = 0, $fY = 0, $fZ = 0, $fAngle = 0)
	;Normalize the vector represented by x, y, and z
	Local $aResult = DllCall($__g_hD2D1DLL, "float", "D2D1Vec3Length", "float", $fX, "float", $fY, "float", $fZ)
	If @error Then Return SetError($D2DERR_UFAIL, 0, False)
	$fX /= $aResult[0]
	$fY /= $aResult[0]
	$fZ /= $aResult[0]


	Local $fRad = $fAngle * 0.0174532925222222
	Local $fSin = Sin($fRad)
	Local $fCos = Cos($fRad)
	Local $fCos1 = 1 - $fCos

	Return _D2D1_MATRIX_4X4_F(1 + $fCos1 * ($fX * $fX - 1), $fZ * $fSin + $fCos1 * $fX * $fY, -$fY * $fSin + $fCos1 * $fX * $fZ, 0, -$fZ * $fSin + $fCos1 * $fY * $fX, 1 + $fCos1 * ($fY * $fY - 1), $fX * $fSin + $fCos1 * $fY * $fZ, 0, $fY * $fSin + $fCos1 * $fZ * $fX, -$fX * $fSin + $fCos1 * $fZ * $fY, 1 + $fCos1 * ($fZ * $fZ - 1), 0, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_RotationArbitraryAxis


Func _D2D_Matrix4x4_SkewX($fAngle = 0)
	Local $fRad = $fAngle * 0.0174532925222222
	Local $fTan = Tan($fRad)

	Return _D2D1_MATRIX_4X4_F(1, 0, 0, 0, $fTan, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_SkewX


Func _D2D_Matrix4x4_SkewY($fAngle = 0)
	Local $fRad = $fAngle * 0.0174532925222222
	Local $fTan = Tan($fRad)

	Return _D2D1_MATRIX_4X4_F(1, $fTan, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_SkewY


Func _D2D_Matrix4x4_PerspectiveProjection($fDepth = 0)
	Local $fProj = 0
	If $fDepth > 0 Then $fProj = -1 / $fDepth

	Return _D2D1_MATRIX_4X4_F(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, $fProj, 0, 0, 0, 1)
EndFunc   ;==>_D2D_Matrix4x4_PerspectiveProjection


Func _D2D_MATRIX4X4_SetProduct($tA, $tB)
	Local $tMX = DllStructCreate($tagD2D1_MATRIX_4X4_F)

	$tMX.M1(1) = $tA.M1(1) * $tB.M1(1) + $tA.M1(2) * $tB.M2(1) + $tA.M1(3) * $tB.M3(1) + $tA.M1(4) * $tB.M4(1)
	$tMX.M1(2) = $tA.M1(1) * $tB.M1(2) + $tA.M1(2) * $tB.M2(2) + $tA.M1(3) * $tB.M3(2) + $tA.M1(4) * $tB.M4(2)
	$tMX.M1(3) = $tA.M1(1) * $tB.M1(3) + $tA.M1(2) * $tB.M2(3) + $tA.M1(3) * $tB.M3(3) + $tA.M1(4) * $tB.M4(3)
	$tMX.M1(4) = $tA.M1(1) * $tB.M1(4) + $tA.M1(2) * $tB.M2(4) + $tA.M1(3) * $tB.M3(4) + $tA.M1(4) * $tB.M4(4)

	$tMX.M2(1) = $tA.M2(1) * $tB.M1(1) + $tA.M2(2) * $tB.M2(1) + $tA.M2(3) * $tB.M3(1) + $tA.M2(4) * $tB.M4(1)
	$tMX.M2(2) = $tA.M2(1) * $tB.M1(2) + $tA.M2(2) * $tB.M2(2) + $tA.M2(3) * $tB.M3(2) + $tA.M2(4) * $tB.M4(2)
	$tMX.M2(3) = $tA.M2(1) * $tB.M1(3) + $tA.M2(2) * $tB.M2(3) + $tA.M2(3) * $tB.M3(3) + $tA.M2(4) * $tB.M4(3)
	$tMX.M2(4) = $tA.M2(1) * $tB.M1(4) + $tA.M2(2) * $tB.M2(4) + $tA.M2(3) * $tB.M3(4) + $tA.M2(4) * $tB.M4(4)

	$tMX.M3(1) = $tA.M3(1) * $tB.M1(1) + $tA.M3(2) * $tB.M2(1) + $tA.M3(3) * $tB.M3(1) + $tA.M3(4) * $tB.M4(1)
	$tMX.M3(2) = $tA.M3(1) * $tB.M1(2) + $tA.M3(2) * $tB.M2(2) + $tA.M3(3) * $tB.M3(2) + $tA.M3(4) * $tB.M4(2)
	$tMX.M3(3) = $tA.M3(1) * $tB.M1(3) + $tA.M3(2) * $tB.M2(3) + $tA.M3(3) * $tB.M3(3) + $tA.M3(4) * $tB.M4(3)
	$tMX.M3(4) = $tA.M3(1) * $tB.M1(4) + $tA.M3(2) * $tB.M2(4) + $tA.M3(3) * $tB.M3(4) + $tA.M3(4) * $tB.M4(4)

	$tMX.M4(1) = $tA.M4(1) * $tB.M1(1) + $tA.M4(2) * $tB.M2(1) + $tA.M4(3) * $tB.M3(1) + $tA.M4(4) * $tB.M4(1)
	$tMX.M4(2) = $tA.M4(1) * $tB.M1(2) + $tA.M4(2) * $tB.M2(2) + $tA.M4(3) * $tB.M3(2) + $tA.M4(4) * $tB.M4(2)
	$tMX.M4(3) = $tA.M4(1) * $tB.M1(3) + $tA.M4(2) * $tB.M2(3) + $tA.M4(3) * $tB.M3(3) + $tA.M4(4) * $tB.M4(3)
	$tMX.M4(4) = $tA.M4(1) * $tB.M1(4) + $tA.M4(2) * $tB.M2(4) + $tA.M4(3) * $tB.M3(4) + $tA.M4(4) * $tB.M4(4)

	Return $tMX
EndFunc   ;==>_D2D_MATRIX4X4_SetProduct












