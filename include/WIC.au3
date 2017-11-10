#include-once
#include <WICConstants.au3>
#include <WinApi.au3>


; #INDEX# =======================================================================================================================
; Title .........: Windows Imaging Component
; AutoIt Version : 3.3.7.20++
; Language ......: English
; Description ...: The Windows Imaging Component (WIC) provides an extensible framework for working with images and image metadata.
; Author ........: trancexx, Eukalyptus
; Modified ......:
; Dll ...........: Windowscodecs.dll
; ===============================================================================================================================




;#######################################################################################################################################################################
;# IWICPlanarFormatConverter
;#######################################################################################################################################################################
#cs    IWICPlanarFormatConverter
	Method ...: CanConvert (?)
	Info .....:     Query if the format converter can convert from one format to another.
	Param ....:         PSrcPixelFormats  <WICPixelFormatGUID>     An array of WIC pixel formats that represents source image planes.
	Param ....:         CSrcPlanes        <UINT>                   The number of source pixel formats specified by the "pSrcFormats" parameter.
	Param ....:         DstPixelFormat    <REFWICPixelFormatGUID>  The destination interleaved pixel format.
	Param ....:         PfCanConvert      <BOOL>                   True if the conversion is supported.

	Method ...: Initialize (?)
	Info .....:     Initializes a format converter with a planar source, and specifies the interleaved output pixel format.
	Param ....:         PpPlanes               <IWICBitmapSource>       An array of IWICBitmapSource that represents image planes.
	Param ....:         CPlanes                <UINT>                   The number of component planes specified by the planes parameter.
	Param ....:         DstFormat              <REFWICPixelFormatGUID>  The destination interleaved pixel format.
	Param ....:         Dither                 <WICBitmapDitherType>    The WICBitmapDitherType used for conversion.
	Param ....:         PIPalette              <IWICPalette>            The palette to use for conversion.
	Param ....:         AlphaThresholdPercent  <double>                 The alpha threshold to use for conversion.
	Param ....:         PaletteTranslate       <WICBitmapPaletteType>   The palette translation type to use for conversion.

#ce
; _WIC_PlanarFormatConverter_CanConvert
; _WIC_PlanarFormatConverter_Initialize





;#######################################################################################################################################################################
;# IWICDdsDecoder
;#######################################################################################################################################################################
#cs    IWICDdsDecoder
	Method ...: GetFrame (?)
	Info .....:     Retrieves the specified frame of the DDS image.
	Param ....:         ArrayIndex      <UINT>                   The requested index within the texture array.
	Param ....:         MipLevel        <UINT>                   The requested mip level.
	Param ....:         SliceIndex      <UINT>                   The requested slice within the 3D texture.
	Param ....:         PpIBitmapFrame  <IWICBitmapFrameDecode>  A pointer to a IWICBitmapFrameDecode object.

	Method ...: GetParameters (?)
	Info .....:     Gets DDS-specific data.
	Param ....:         PParameters  <WICDdsParameters>  A pointer to the structure where the information is returned.

#ce
; _WIC_DdsDecoder_GetFrame
; _WIC_DdsDecoder_GetParameters





;#######################################################################################################################################################################
;# IWICDdsEncoder
;#######################################################################################################################################################################
#cs    IWICDdsEncoder
	Method ...: CreateNewFrame (?)
	Info .....:     Creates a new frame to encode.
	Param ....:         PpIFrameEncode  <IWICBitmapFrameEncode>  A pointer to the newly created frame object.
	Param ....:         PArrayIndex     <UINT>                   Points to the location where the array index is returned.
	Param ....:         PMipLevel       <UINT>                   Points to the location where the mip level index is returned.
	Param ....:         PSliceIndex     <UINT>                   Points to the location where the slice index is returned.

	Method ...: GetParameters (?)
	Info .....:     Gets DDS-specific data.
	Param ....:         PParameters  <WICDdsParameters>  Points to the structure where the information is returned.

	Method ...: SetParameters (?)
	Info .....:     Sets DDS-specific data.
	Param ....:         PParameters  <WICDdsParameters>  Points to the structure where the information is described.

#ce
; _WIC_DdsEncoder_CreateNewFrame
; _WIC_DdsEncoder_GetParameters
; _WIC_DdsEncoder_SetParameters





;#######################################################################################################################################################################
;# IWICDdsFrameDecode
;#######################################################################################################################################################################
#cs    IWICDdsFrameDecode
	Method ...: CopyBlocks (?)
	Info .....:     Requests pixel data as it is natively stored within the DDS file.
	Param ....:         PrcBoundsInBlocks  <WICRect>  If the texture uses a block-compressed DXGI_FORMAT, all values of the rectangle are expressed in number of blocks, not pixels.
	Param ....:         CbStride           <UINT>     The stride, in bytes, of the destination buffer. This represents the number of bytes from the buffer pointer to the next row of data. If the texture uses a block-compressed DXGI_FORMAT, a "row of data" is defined as a row of blocks which contains multiple pixel scanlines.
	Param ....:         CbBufferSize       <UINT>     The size, in bytes, of the destination buffer.
	Param ....:         PbBuffer           <BYTE>     A pointer to the destination buffer.

	Method ...: GetFormatInfo (?)
	Info .....:     Gets information about the format in which the DDS image is stored.
	Param ....:         PFormatInfo  <WICDdsFormatInfo>  Information about the DDS format.

	Method ...: GetSizeInBlocks (?)
	Info .....:     Gets the width and height, in blocks, of the DDS image.
	Param ....:         PWidthInBlocks  <UINT>     The width of the DDS image in blocks.
	Param ....:         PHeight         <pHeight>  pHeight|pHeight    InBlocks|The height of the DDS image in blocks.|*

#ce
; _WIC_DdsFrameDecode_CopyBlocks
; _WIC_DdsFrameDecode_GetFormatInfo
; _WIC_DdsFrameDecode_GetSizeInBlocks





;#######################################################################################################################################################################
;# IWICPlanarBitmapFrameEncode
;#######################################################################################################################################################################
#cs    IWICPlanarBitmapFrameEncode
	Method ...: WritePixels (?)
	Info .....:     Writes lines from the source planes to the encoded format.
	Param ....:         LineCount  <UINT>            The number of lines to encode. See the Remarks section for WIC Jpeg specific line count restrictions.
	Param ....:         PPlanes    <WICBitmapPlane>  Specifies the source buffers for each component plane encoded.
	Param ....:         CPlanes    <UINT>            The number of component planes specified by the "pPlanes" parameter.

	Method ...: WriteSource (?)
	Info .....:     Writes lines from the source planes to the encoded format.
	Param ....:         PpPlanes   <IWICBitmapSource>  Specifies an array of IWICBitmapSource that represent image planes.
	Param ....:         CPlanes    <UINT>              The number of component planes specified by the planes parameter.
	Param ....:         PrcSource  <WICRect>           The source rectangle of pixels to encode from the IWICBitmapSource planes. Null indicates the entire source. The source rect width must match the width set through SetSize. Repeated WriteSource calls can be made as long as the total accumulated source rect height is the same as set through SetSize.

#ce
; _WIC_PlanarBitmapFrameEncode_WritePixels
; _WIC_PlanarBitmapFrameEncode_WriteSource





;#######################################################################################################################################################################
;# IWICPlanarBitmapSourceTransform
;#######################################################################################################################################################################
#cs    IWICPlanarBitmapSourceTransform
	Method ...: CopyPixels (?)
	Info .....:     Copies pixels into the destination planes. Configured by the supplied input parameters.
	Param ....:         PrcSource         <WICRect>                    The source rectangle of pixels to copy.
	Param ....:         UiWidth           <UINT>                       The width to scale the source bitmap. This parameter must be equal to a value obtainable through IWICPlanarBitmapSourceTransform:: DoesSupportTransform.
	Param ....:         UiHeight          <UINT>                       The height to scale the source bitmap. This parameter must be equal to a value obtainable through IWICPlanarBitmapSourceTransform:: DoesSupportTransform.
	Param ....:         DstTransform      <WICBitmapTransformOptions>  The desired rotation or flip to perform prior to the pixel copy. A rotate can be combined with a flip horizontal or a flip vertical, see WICBitmapTransformOptions.
	Param ....:         DstPlanarOptions  <WICPlanarOptions>           WIC JPEG Decoder: WICPlanarOptionsPreserveSubsampling can be specified to retain the subsampling ratios when downscaling. By default, the JPEG decoder attempts to preserve quality by downscaling only the Y plane in some cases, changing the image to 4:4:4 chroma subsampling.
	Param ....:         PDstPlanes        <WICBitmapPlane>             Specifies the pixel format and output buffer for each component plane. The number of planes and pixel format of each plane must match values obtainable through IWICPlanarBitmapSourceTransform::DoesSupportTransform.
	Param ....:         CPlanes           <UINT>                       The number of component planes specified by the "pDstPlanes" parameter.

	Method ...: DoesSupportTransform (?)
	Info .....:     Use this method to determine if a desired planar output is supported and allow the caller to choose an optimized code path if it is. Otherwise, callers should fall back to IWICBitmapSourceTransform or IWICBitmapSource and retrieve interleaved pixels.
	Param ....:         PuiWidth          <UINT>                       On input, the desired width. On output, the closest supported width to the desired width; this is the same size or larger than the desired width.
	Param ....:         PuiHeight         <UINT>                       On input, the desired height. On output, the closest supported height to the desired height; this is the same size or larger than the desired width.
	Param ....:         DstTransform      <WICBitmapTransformOptions>  The desired rotation or flip operation. Multiple WICBitmapTransformOptions can be combined in this flag parameter, see WICBitmapTransformOptions.
	Param ....:         DstPlanarOptions  <WICPlanarOptions>            WICPlanarOptionsPreserveSubsampling can be specified to retain the subsampling ratios when downscaling. By default, the JPEG decoder attempts to preserve quality by downscaling only the Y plane in some cases, changing the image to 4:4:4 chroma subsampling.
	Param ....:         PguidDstFormats   <WICPixelFormatGUID>         The requested pixel formats of the respective planes.
	Param ....:         PguidDstFormats   <WICBitmapPlaneDescription>  WIC JPEG Decoder: The Cb and Cr planes can be a different size from the values returned by "puiWidth" and "puiHeight" due to chroma subsampling.
	Param ....:         CPlanes           <UINT>                       The number of component planes requested.
	Param ....:         PfIsSupported     <BOOL>                       Set to TRUE if the requested transforms are natively supported.

#ce
; _WIC_PlanarBitmapSourceTransform_CopyPixels
; _WIC_PlanarBitmapSourceTransform_DoesSupportTransform





;#######################################################################################################################################################################
;# IWICImageEncoder
;#######################################################################################################################################################################
#cs    IWICImageEncoder
	Method ...: WriteFrame (?)
	Info .....:     Encodes the image to the frame given by the IWICBitmapFrameEncode.
	Param ....:         PImage            <ID2D1Image>             The Direct2D image that will be encoded.
	Param ....:         PFrameEncode      <IWICBitmapFrameEncode>  The frame encoder to which the image is written.
	Param ....:         PImageParameters  <WICImageParameters>     Additional parameters to control encoding.

	Method ...: WriteFrameThumbnail (?)
	Info .....:     Encodes the image as a thumbnail to the frame given by the IWICBitmapFrameEncode.
	Param ....:         PImage            <ID2D1Image>             The Direct2D image that will be encoded.
	Param ....:         PFrameEncode      <IWICBitmapFrameEncode>  The frame encoder on which the thumbnail is set.
	Param ....:         PImageParameters  <WICImageParameters>     Additional parameters to control encoding.

	Method ...: WriteThumbnail (?)
	Info .....:     Encodes the given image as the thumbnail to the given WIC bitmap encoder.
	Param ....:         PImage            <ID2D1Image>          The Direct2D image that will be encoded.
	Param ....:         PEncoder          <IWICBitmapEncoder>   The encoder on which the thumbnail is set.
	Param ....:         PImageParameters  <WICImageParameters>  Additional parameters to control encoding.

#ce
; _WIC_ImageEncoder_WriteFrame
; _WIC_ImageEncoder_WriteFrameThumbnail
; _WIC_ImageEncoder_WriteThumbnail





;#######################################################################################################################################################################
;# IWICBitmapEncoder
;#######################################################################################################################################################################
#cs    IWICBitmapEncoder
	Method ...: Commit ()
	Info .....:     Commits all changes for the image and closes the stream.
	Param ....:         This method has no parameters.

	Method ...: CreateNewFrame (ptr*;ptr*)
	Info .....:     Creates a new IWICBitmapFrameEncode instance.
	Param ....:         PpIFrameEncode     <IWICBitmapFrameEncode>  A pointer that receives a pointer to the new instance of an IWICBitmapFrameEncode.
	Param ....:         PpIEncoderOptions  <IPropertyBag2>          Optional. Receives the named properties to use for subsequent frame initialization. See Remarks.

	Method ...: GetContainerFormat (ptr*)
	Info .....:     Retrieves the encoder's container format.
	Param ....:         PguidContainerFormat  <GUID>  A pointer that receives the encoder's container format GUID.

	Method ...: GetEncoderInfo (ptr*)
	Info .....:     Retrieves an IWICBitmapEncoderInfo for the encoder.
	Param ....:         PpIEncoderInfo  <IWICBitmapEncoderInfo>  A pointer that receives a pointer to an IWICBitmapEncoderInfo.

	Method ...: GetMetadataQueryWriter (ptr*)
	Info .....:     Retrieves a metadata query writer for the encoder.
	Param ....:         PpIMetadataQueryWriter  <IWICMetadataQueryWriter>  When this method returns, contains a pointer to the encoder's metadata query writer.

	Method ...: Initialize (struct*;uint)
	Info .....:     Initializes the encoder with an IStream which tells the encoder where to encode the bits.
	Param ....:         PIStream     <IStream>                      The output stream.
	Param ....:         CacheOption  <WICBitmapEncoderCacheOption>  The WICBitmapEncoderCacheOption used on initialization.

	Method ...: SetColorContexts (uint;struct*)
	Info .....:     Sets the IWICColorContext objects for the encoder.
	Param ....:         CCount           <UINT>              The number of IWICColorContext to set.
	Param ....:         PpIColorContext  <IWICColorContext>  A pointer an IWICColorContext pointer containing the color contexts to set for the encoder.

	Method ...: SetPalette (struct*)
	Info .....:     Sets the global palette for the image.
	Param ....:         PIPalette  <IWICPalette>  The IWICPalette to use as the global palette.

	Method ...: SetPreview (struct*)
	Info .....:     Sets the global preview for the image.
	Param ....:         PIPreview  <IWICBitmapSource>  The IWICBitmapSource to use as the global preview.

	Method ...: SetThumbnail (struct*)
	Info .....:     Sets the global thumbnail for the image.
	Param ....:         PIThumbnail  <IWICBitmapSource>  The IWICBitmapSource to set as the global thumbnail.

#ce
; _WIC_BitmapEncoder_Commit



; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_BitmapEncoder_CreateNewFrame
; Description ...: Creates a new IWICBitmapFrameEncode instance.
; Syntax ........: _WIC_BitmapEncoder_CreateNewFrame($oIBitmapEncoder, $oEncoderOptions)
; Parameters ....: $oIBitmapEncoder - This IWICBitmapEncoder object
;                  $oEncoderOptions - An IPropertyBag2 object. Optional. Receives the named properties to use for subsequent frame initialization.
;                                     See Remarks.
; Return values .: Success - An IWICBitmapFrameEncode object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: The parameter "ppIEncoderOptions" can be used to receive an IPropertyBag2 that can then be used to specify encoder options.
;                  This is done by passing a pointer to a NULL IPropertyBag2 pointer in "ppIEncoderOptions". The returned IPropertyBag2 is initialized
;                  with all encoder options that are available for the given format, at their default values. To specify non-default encoding
;                  behavior, set the needed encoder options on the IPropertyBag2 and pass it to IWICBitmapFrameEncode::Initialize.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _WIC_BitmapEncoder_CreateNewFrame($oIBitmapEncoder, ByRef $oEncoderOptions)
	If Not IsObj($oIBitmapEncoder) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pFrameEncode, $pEncoderOptions
	Local $iHResult = $oIBitmapEncoder.CreateNewFrame($pFrameEncode, $pEncoderOptions)
	If $iHResult Or Not $pFrameEncode Then Return SetError($iHResult, 1, False)

	Local $oFrameEncode = ObjCreateInterface($pFrameEncode, $sIID_IWICBitmapFrameEncode, $tagIWICBitmapFrameEncode)
	If Not IsObj($oFrameEncode) Then Return SetError($WICERR_OBJFAIL, 2, False)

	$oEncoderOptions = ObjCreateInterface($pEncoderOptions, $sIID_IPropertyBag2, $tagIPropertyBag2)
	If Not IsObj($oEncoderOptions) Then Return SetError($WICERR_OBJFAIL, 3, $oFrameEncode)

	Return $oFrameEncode
EndFunc


; _WIC_BitmapEncoder_GetContainerFormat
; _WIC_BitmapEncoder_GetEncoderInfo
; _WIC_BitmapEncoder_GetMetadataQueryWriter
; _WIC_BitmapEncoder_Initialize
; _WIC_BitmapEncoder_SetColorContexts
; _WIC_BitmapEncoder_SetPalette
; _WIC_BitmapEncoder_SetPreview
; _WIC_BitmapEncoder_SetThumbnail





;#######################################################################################################################################################################
;# IWICImagingFactory2
;#######################################################################################################################################################################
#cs    IWICImagingFactory2
	Method ...: CreateImageEncoder (?)
	Info .....:     Creates a new image encoder object.
	Param ....:         PD2DDevice         <ID2D1Device>       The ID2D1Device object on which the corresponding image encoder is created.
	Param ....:         PpWICImageEncoder  <IWICImageEncoder>  A pointer to a variable that receives a pointer to the IWICImageEncoder interface for the encoder object that you can use to encode Direct2D images.

#ce
; _WIC_ImagingFactory2_CreateImageEncoder





;#######################################################################################################################################################################
;# IWICImageEncoder
;#######################################################################################################################################################################
#cs    IWICImageEncoder
	Method ...: WriteFrame (?)
	Info .....:     Encodes the image to the frame given by the IWICBitmapFrameEncode.
	Param ....:         PImage            <ID2D1Image>             The Direct2D image that will be encoded.
	Param ....:         PFrameEncode      <IWICBitmapFrameEncode>  The frame encoder to which the image is written.
	Param ....:         PImageParameters  <WICImageParameters>     Additional parameters to control encoding.

	Method ...: WriteFrameThumbnail (?)
	Info .....:     Encodes the image as a thumbnail to the frame given by the IWICBitmapFrameEncode.
	Param ....:         PImage            <ID2D1Image>             The Direct2D image that will be encoded.
	Param ....:         PFrameEncode      <IWICBitmapFrameEncode>  The frame encoder on which the thumbnail is set.
	Param ....:         PImageParameters  <WICImageParameters>     Additional parameters to control encoding.

	Method ...: WriteThumbnail (?)
	Info .....:     Encodes the given image as the thumbnail to the given WIC bitmap encoder.
	Param ....:         PImage            <ID2D1Image>          The Direct2D image that will be encoded.
	Param ....:         PEncoder          <IWICBitmapEncoder>   The encoder on which the thumbnail is set.
	Param ....:         PImageParameters  <WICImageParameters>  Additional parameters to control encoding.

#ce
; _WIC_ImageEncoder_WriteFrame
; _WIC_ImageEncoder_WriteFrameThumbnail
; _WIC_ImageEncoder_WriteThumbnail





;#######################################################################################################################################################################
;# IWICBitmap
;#######################################################################################################################################################################
#cs    IWICBitmap
	Method ...: Lock (struct*;uint;ptr*)
	Info .....:     Provides access to a rectangular area of the bitmap.
	Param ....:         PrcLock  <WICRect>         The rectangle to be accessed.
	Param ....:         Flags    <DWORD>            
	Param ....:         PpILock  <IWICBitmapLock>  A pointer that receives the locked memory location.

	Method ...: SetPalette (struct*)
	Info .....:     Provides access for palette modifications.
	Param ....:         PIPalette  <IWICPalette>  The palette to use for conversion.

	Method ...: SetResolution (double;double)
	Info .....:     Changes the physical resolution of the image.
	Param ....:         DpiX  <double>  The horizontal resolution.
	Param ....:         DpiY  <double>  The vertical resolution.

#ce


; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_Bitmap_Lock
; Description ...: Provides access to a rectangular area of the bitmap.
; Syntax ........: _WIC_Bitmap_Lock($oIBitmap, $iX, $iY, $iWidth, $iHeight[, $iFlags = $WICBitmapLockRead])
; Parameters ....: $oIBitmap - This IWICBitmap object
;                  $iX       - The horizontal coordinate of the rectangle.
;                  $iY       - The vertical coordinate of the rectangle.
;                  $iWidth   - The width of the rectangle.
;                  $iHeight  - The height of the rectangle.
;                  $iFlags   - [optional]  
; Return values .: Success - An IWICBitmapLock object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Locks are exclusive for writing but can be shared for reading. You cannot call CopyPixels while the IWICBitmap is locked for writing.
;                  Doing so will return an error, since locks are exclusive.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _WIC_Bitmap_Lock($oIBitmap, $iX, $iY, $iWidth, $iHeight, $iFlags = $WICBitmapLockRead)
	If Not IsObj($oIBitmap) Then Return SetError($WICERR_NOOBJ, 0, False)
	Local $tWICRect = _WIC_RECT($iX, $iY, $iWidth, $iHeight)

	Local $pLock
	Local $iHResult = $oIBitmap.Lock($tWICRect, $iFlags, $pLock)
	If $iHResult Or Not $pLock Then Return SetError($iHResult, 1, False)

	Local $oLock = ObjCreateInterface($pLock, $sIID_IWICBitmapLock, $tagIWICBitmapLock)
	If Not IsObj($oLock) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oLock
EndFunc


; _WIC_Bitmap_SetPalette
; _WIC_Bitmap_SetResolution





;#######################################################################################################################################################################
;# IWICBitmapSource
;#######################################################################################################################################################################
#cs    IWICBitmapSource
	Method ...: CopyPalette (struct*)
	Info .....:     Retrieves the color table for indexed pixel formats.
	Param ....:         PIPalette  <IWICPalette>  An IWICPalette. A palette can be created using the CreatePalette method.

	Method ...: CopyPixels (struct*;uint;uint;struct*)
	Info .....:     Instructs the object to produce pixels.
	Param ....:         Prc           <WICRect>  The rectangle to copy. A NULL value specifies the entire bitmap.
	Param ....:         CbStride      <UINT>     The stride of the bitmap
	Param ....:         CbBufferSize  <UINT>     The size of the buffer.
	Param ....:         PbBuffer      <BYTE>     A pointer to the buffer.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format of the bitmap source..
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  Receives the pixel format GUID the bitmap is stored in. For a list of available pixel formats, see the Native Pixel Formats topic.

	Method ...: GetResolution (double*;double*)
	Info .....:     Retrieves the sampling rate between pixels and physical world measurements.
	Param ....:         PDpiX  <double>  A pointer that receives the x-axis dpi resolution.
	Param ....:         PDpiY  <double>  A pointer that receives the y-axis dpi resolution.

	Method ...: GetSize (uint*;uint*)
	Info .....:     Retrieves the pixel width and height of the bitmap.
	Param ....:         PuiWidth   <UINT>  A pointer that receives the pixel width of the bitmap.
	Param ....:         PuiHeight  <UINT>  A pointer that receives the pixel height of the bitmap

#ce
; _WIC_BitmapSource_CopyPalette
; _WIC_BitmapSource_CopyPixels
; _WIC_BitmapSource_GetPixelFormat
; _WIC_BitmapSource_GetResolution
; _WIC_BitmapSource_GetSize





;#######################################################################################################################################################################
;# IWICBitmapClipper
;#######################################################################################################################################################################
#cs    IWICBitmapClipper
	Method ...: Initialize (struct*;struct*)
	Info .....:     Initializes the bitmap clipper with the provided parameters.
	Param ....:         PISource  <IWICBitmapSource>  he input bitmap source.
	Param ....:         Prc       <WICRect>           The rectangle of the bitmap source to clip.

#ce
; _WIC_BitmapClipper_Initialize





;#######################################################################################################################################################################
;# IWICBitmapCodecInfo
;#######################################################################################################################################################################
#cs    IWICBitmapCodecInfo
	Method ...: DoesSupportAnimation (bool*)
	Info .....:     Retrieves a value indicating whether the codec supports animation.
	Param ....:         PfSupportAnimation  <BOOL>  Receives TRUE if the codec supports images with timing information; otherwise, FALSE.

	Method ...: DoesSupportChromakey (bool*)
	Info .....:     Retrieves a value indicating whether the codec supports chromakeys.
	Param ....:         PfSupportChromakey  <BOOL>  Receives TRUE if the codec supports chromakeys; otherwise, FALSE.

	Method ...: DoesSupportLossless (bool*)
	Info .....:     Retrieves a value indicating whether the codec supports lossless formats.
	Param ....:         PfSupportLossless  <BOOL>  Receives TRUE if the codec supports lossless formats; otherwise, FALSE.

	Method ...: DoesSupportMultiframe (bool*)
	Info .....:     Retrieves a value indicating whether the codec supports multi frame images.
	Param ....:         PfSupportMultiframe  <BOOL>  Receives TRUE if the codec supports multi frame images; otherwise, FALSE.

	Method ...: GetColorManagementVersion (uint;wstr;uint*)
	Info .....:     Retrieves the color manangement version number the codec supports.
	Param ....:         CchColorManagementVersion  <UINT>   The size of the version buffer. Use "0" on first call to determine needed buffer size.
	Param ....:         WzColorManagementVersion   <WCHAR>  Receives the color management version number. Use "NULL" on first call to determine needed buffer size.
	Param ....:         PcchActual                 <UINT>   The actual buffer size needed to retrieve the full color management version number.

	Method ...: GetContainerFormat (ptr*)
	Info .....:     Retrieves the container GUID associated with the codec.
	Param ....:         PguidContainerFormat  <GUID>  Receives the container GUID.

	Method ...: GetDeviceManufacturer (uint;wstr;uint*)
	Info .....:     Retrieves the name of the device manufacture associated with the codec.
	Param ....:         CchDeviceManufacturer  <UINT>   The size of the device manufacture's name. Use "0" on first call to determine needed buffer size.
	Param ....:         WzDeviceManufacturer   <WCHAR>  Receives the device manufacture's name. Use "NULL" on first call to determine needed buffer size.
	Param ....:         PcchActual             <UINT>   The actual buffer size needed to retrieve the device manufacture's name.

	Method ...: GetDeviceModels (uint;wstr;uint*)
	Info .....:     Retrieves a comma delimited list of device models associated with the codec.
	Param ....:         CchDeviceModels  <UINT>   The size of the device models buffer. Use "0" on first call to determine needed buffer size.
	Param ....:         WzDeviceModels   <WCHAR>  Receives a comma delimited list of device model names associated with the codec. Use "NULL" on first call to determine needed buffer size.
	Param ....:         PcchActual       <UINT>   The actual buffer size needed to retrieve all of the device model names.

	Method ...: GetFileExtensions (uint;wstr;uint*)
	Info .....:     Retrieves a comma delimited list of the file name extensions associated with the codec.
	Param ....:         CchFileExtensions  <UINT>   The size of the file name extension buffer. Use "0" on first call to determine needed buffer size.
	Param ....:         WzFileExtensions   <WCHAR>  Receives a comma delimited list of file name extensions associated with the codec. Use "NULL" on first call to determine needed buffer size.
	Param ....:         PcchActual         <UINT>   The actual buffer size needed to retrieve all file name extensions associated with the codec.

	Method ...: GetMimeTypes (uint;wstr;uint*)
	Info .....:     Retrieves a comma delimited sequence of mime types associated with the codec.
	Param ....:         CchMimeTypes  <UINT>   The size of the mime types buffer. Use "0" on first call to determine needed buffer size.
	Param ....:         WzMimeTypes   <WCHAR>  Receives the mime types associated with the codec. Use "NULL" on first call to determine needed buffer size.
	Param ....:         PcchActual    <UINT>   The actual buffer size needed to retrieve all mime types associated with the codec.

	Method ...: GetPixelFormats (uint;struct*;uint*)
	Info .....:     Retrieves the pixel formats the codec supports.
	Param ....:         CFormats           <UINT>  The size of the "pguidPixelFormats" array. Use "0" on first call to determine the needed array size.
	Param ....:         PguidPixelFormats  <GUID>  Receives the supported pixel formats. Use "NULL" on first call to determine needed array size.
	Param ....:         PcActual           <UINT>  The array size needed to retrieve all supported pixel formats.

	Method ...: MatchesMimeType (wstr;bool*)
	Info .....:     Retrieves a value indicating whether the given mime type matches the mime type of the codec.
	Param ....:         WzMimeType  <LPCWSTR>  The mime type to compare.
	Param ....:         PfMatches   <BOOL>     Receives TRUE if the mime types match; otherwise, FALSE.

#ce
; _WIC_BitmapCodecInfo_DoesSupportAnimation
; _WIC_BitmapCodecInfo_DoesSupportChromakey
; _WIC_BitmapCodecInfo_DoesSupportLossless
; _WIC_BitmapCodecInfo_DoesSupportMultiframe
; _WIC_BitmapCodecInfo_GetColorManagementVersion
; _WIC_BitmapCodecInfo_GetContainerFormat
; _WIC_BitmapCodecInfo_GetDeviceManufacturer
; _WIC_BitmapCodecInfo_GetDeviceModels
; _WIC_BitmapCodecInfo_GetFileExtensions
; _WIC_BitmapCodecInfo_GetMimeTypes
; _WIC_BitmapCodecInfo_GetPixelFormats
; _WIC_BitmapCodecInfo_MatchesMimeType





;#######################################################################################################################################################################
;# IWICBitmapCodecProgressNotification
;#######################################################################################################################################################################
#cs    IWICBitmapCodecProgressNotification
	Method ...: RegisterProgressNotification (struct*;struct*;uint)
	Info .....:     Registers a progress notification callback function.
	Param ....:         PfnProgressNotification  <PFNProgressNotification>  A function pointer to the application defined progress notification callback function. See ProgressNotificationCallback for the callback signature.
	Param ....:         PvData                   <LPVOID>                   A pointer to component data for the callback method.
	Param ....:         DwProgressFlags          <DWORD>                    The WICProgressOperation and WICProgressNotification flags to use for progress notification.

#ce
; _WIC_BitmapCodecProgressNotification_RegisterProgressNotification





;#######################################################################################################################################################################
;# IWICBitmapDecoder
;#######################################################################################################################################################################
#cs    IWICBitmapDecoder
	Method ...: CopyPalette (struct*)
	Info .....:     Copies the decoder's IWICPalette .
	Param ....:         PIPalette  <IWICPalette>  An IWICPalette to which the decoder's global palette is to be copied. Use CreatePalette to create the destination palette before calling CopyPalette.

	Method ...: GetColorContexts (uint;struct*;uint*)
	Info .....:     Retrieves the IWICColorContext objects of the image.
	Param ....:         CCount            <UINT>              This value must be the size of, or smaller than, the size available to "ppIColorContexts".
	Param ....:         PpIColorContexts  <IWICColorContext>  A pointer that receives a pointer to the IWICColorContext.
	Param ....:         PcActualCount     <UINT>              A pointer that receives the number of color contexts contained in the image.

	Method ...: GetContainerFormat (ptr*)
	Info .....:     Retrieves the image's container format.
	Param ....:         PguidContainerFormat  <GUID>  A pointer that receives the image's container format GUID.

	Method ...: GetDecoderInfo (ptr*)
	Info .....:     Retrieves an IWICBitmapDecoderInfo for the image.
	Param ....:         PpIDecoderInfo  <IWICBitmapDecoderInfo>  A pointer that receives a pointer to an IWICBitmapDecoderInfo.

	Method ...: GetFrame (uint*)
	Info .....:     Retrieves the specified frame of the image.
	Param ....:         Index           <UINT>                   The particular frame to retrieve.
	Param ....:         PpIBitmapFrame  <IWICBitmapFrameDecode>  A pointer that receives a pointer to the IWICBitmapFrameDecode.

	Method ...: GetFrameCount (uint*)
	Info .....:     Retrieves the total number of frames in the image.
	Param ....:         PCount  <UINT>  A pointer that receives the total number of frames in the image.

	Method ...: GetMetadataQueryReader (ptr*)
	Info .....:     Retrieves the metadata query reader from the decoder.
	Param ....:         PpIMetadataQueryReader  <IWICMetadataQueryReader>  Receives a pointer to the decoder's IWICMetadataQueryReader.

	Method ...: GetPreview (ptr*)
	Info .....:     Retrieves a preview image, if supported.
	Param ....:         PpIBitmapSource  <IWICBitmapSource>  Receives a pointer to the preview bitmap if supported.

	Method ...: GetThumbnail (ptr*)
	Info .....:     Retrieves a bitmap thumbnail of the image, if one exists
	Param ....:         PpIThumbnail  <IWICBitmapSource>  Receives a pointer to the IWICBitmapSource of the thumbnail.

	Method ...: Initialize (ptr*)
	Info .....:     Initializes the decoder with the provided stream.
	Param ....:         PIStream      <IStream>           The stream contains the encoded pixels which are decoded each time the CopyPixels method on the IWICBitmapFrameDecode interface (see GetFrame) is invoked.
	Param ....:         CacheOptions  <WICDecodeOptions>  The WICDecodeOptions to use for initialization.

	Method ...: QueryCapability (ptr*;uint)
	Info .....:     Retrieves the capabilities of the decoder based on the specified stream.
	Param ....:         PIStream       <IStream>  The stream to retrieve the decoder capabilities from.
	Param ....:         PdwCapability  <DWORD>    The WICBitmapDecoderCapabilities of the decoder.

#ce
; _WIC_BitmapDecoder_CopyPalette
; _WIC_BitmapDecoder_GetColorContexts
; _WIC_BitmapDecoder_GetContainerFormat
; _WIC_BitmapDecoder_GetDecoderInfo



; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_BitmapDecoder_GetFrame
; Description ...: Retrieves the specified frame of the image.
; Syntax ........: _WIC_BitmapDecoder_GetFrame($oIBitmapDecoder[, $iIndex = 0])
; Parameters ....: $oIBitmapDecoder - This IWICBitmapDecoder object
;                  $iIndex          - [optional] The particular frame to retrieve.
; Return values .: Success - An IWICBitmapFrameDecode object.
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
Func _WIC_BitmapDecoder_GetFrame($oIBitmapDecoder, $iIndex = 0)
	If Not IsObj($oIBitmapDecoder) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pBitmapFrame
	Local $iHResult = $oIBitmapDecoder.GetFrame($iIndex, $pBitmapFrame)
	If $iHResult Or Not $pBitmapFrame Then Return SetError($iHResult, 1, False)

	Local $oBitmapFrame = ObjCreateInterface($pBitmapFrame, $sIID_IWICBitmapFrameDecode, $tagIWICBitmapFrameDecode)
	If Not IsObj($oBitmapFrame) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oBitmapFrame
EndFunc

; _WIC_BitmapDecoder_GetFrameCount
; _WIC_BitmapDecoder_GetMetadataQueryReader
; _WIC_BitmapDecoder_GetPreview
; _WIC_BitmapDecoder_GetThumbnail
; _WIC_BitmapDecoder_Initialize
; _WIC_BitmapDecoder_QueryCapability





;#######################################################################################################################################################################
;# IWICBitmapDecoderInfo
;#######################################################################################################################################################################
#cs    IWICBitmapDecoderInfo
	Method ...: CreateInstance (ptr*)
	Info .....:     Creates a new IWICBitmapDecoder instance.
	Param ....:         PpIBitmapDecoder  <IWICBitmapDecoder>  A pointer that receives a pointer to a new instance of the IWICBitmapDecoder.

	Method ...: GetPatterns (uint;ptr*;uint*;uint*)
	Info .....:     Retrieves the file pattern signatures supported by the decoder.
	Param ....:         CbSizePatterns     <UINT>              The array size of the "pPatterns" array.
	Param ....:         PPatterns          <WICBitmapPattern>  Receives a list of WICBitmapPattern objects supported by the decoder.
	Param ....:         PcPatterns         <UINT>              Receives the number of patterns the decoder supports.
	Param ....:         PcbPatternsActual  <UINT>              Receives the actual buffer size needed to retrieve all pattern signatures supported by the decoder.

	Method ...: MatchesPattern (struct*;bool*)
	Info .....:     Retrieves a value that indicates whether the codec recognizes the pattern within a specified stream.
	Param ....:         PIStream   <IStream>  The stream to pattern match within.
	Param ....:         PfMatches  <BOOL>     A pointer that receives TRUE if the patterns match; otherwise, FALSE.

#ce
; _WIC_BitmapDecoderInfo_CreateInstance
; _WIC_BitmapDecoderInfo_GetPatterns
; _WIC_BitmapDecoderInfo_MatchesPattern







;#######################################################################################################################################################################
;# IWICBitmapEncoderInfo
;#######################################################################################################################################################################
#cs    IWICBitmapEncoderInfo
	Method ...: CreateInstance (ptr*)
	Info .....:     Creates a new IWICBitmapEncoder instance.
	Param ....:         PpIBitmapEncoder  <IWICBitmapEncoder>  A pointer that receives a pointer to a new IWICBitmapEncoder instance.

#ce
; _WIC_BitmapEncoderInfo_CreateInstance





;#######################################################################################################################################################################
;# IWICBitmapFlipRotator
;#######################################################################################################################################################################
#cs    IWICBitmapFlipRotator
	Method ...: Initialize (struct*;uint)
	Info .....:     Initializes the bitmap flip rotator with the provided parameters.
	Param ....:         PISource  <IWICBitmapSource>           The input bitmap source.
	Param ....:         Options   <WICBitmapTransformOptions>  The WICBitmapTransformOptions to flip or rotate the image.

#ce
; _WIC_BitmapFlipRotator_Initialize





;#######################################################################################################################################################################
;# IWICBitmapFrameDecode
;#######################################################################################################################################################################
#cs    IWICBitmapFrameDecode
	Method ...: GetColorContexts (uint;struct*;uint)
	Info .....:     Retrieves the IWICColorContext associated with the image frame.
	Param ....:         CCount            <UINT>              This value must be the size of, or smaller than, the size available to "ppIColorContexts".
	Param ....:         PpIColorContexts  <IWICColorContext>  A pointer that receives a pointer to the IWICColorContext objects.
	Param ....:         PcActualCount     <UINT>              A pointer that receives the number of color contexts contained in the image frame.

	Method ...: GetMetadataQueryReader (ptr*)
	Info .....:     Retrieves a metadata query reader for the frame.
	Param ....:         PpIMetadataQueryReader  <IWICMetadataQueryReader>  When this method returns, contains a pointer to the frame's metadata query reader.

	Method ...: GetThumbnail (ptr*)
	Info .....:     Retrieves a small preview of the frame, if supported by the codec.
	Param ....:         PpIThumbnail  <IWICBitmapSource>  A pointer that receives a pointer to the IWICBitmapSource of the thumbnail.

#ce
; _WIC_BitmapFrameDecode_GetColorContexts


; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_BitmapFrameDecode_GetMetadataQueryReader
; Description ...: Retrieves a metadata query reader for the frame.
; Syntax ........: _WIC_BitmapFrameDecode_GetMetadataQueryReader($oIBitmapFrameDecode)
; Parameters ....: $oIBitmapFrameDecode - This IWICBitmapFrameDecode object
; Return values .: Success - An IWICMetadataQueryReader object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: For image formats with one frame (JPG, PNG, JPEG-XR), the frame-level query reader of the first frame is used to access all
;                  image metadata, and the decoder-level query reader isn’t used. For formats with more than one frame (GIF, TIFF), the frame-level
;                  query reader for a given frame is used to access metadata specific to that frame, and in the case of GIF a decoder-level metadata
;                  reader will be present. If the decoder doesn’t support metadata (BMP, ICO), this will return WINCODEC_ERR_UNSUPPORTEDOPERATION.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _WIC_BitmapFrameDecode_GetMetadataQueryReader($oIBitmapFrameDecode)
	If Not IsObj($oIBitmapFrameDecode) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pMetadataQueryReader
	Local $iHResult = $oIBitmapFrameDecode.GetMetadataQueryReader($pMetadataQueryReader)
	If $iHResult Or Not $pMetadataQueryReader Then Return SetError($iHResult, 1, False)

	Local $oMetadataQueryReader = ObjCreateInterface($pMetadataQueryReader, $sIID_IWICMetadataQueryReader, $tagIWICMetadataQueryReader)
	If Not IsObj($oMetadataQueryReader) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oMetadataQueryReader
EndFunc

; _WIC_BitmapFrameDecode_GetThumbnail





;#######################################################################################################################################################################
;# IWICBitmapFrameEncode
;#######################################################################################################################################################################
#cs    IWICBitmapFrameEncode
	Method ...: Commit ()
	Info .....:     Commits the frame to the image.
	Param ....:         This method has no parameters.

	Method ...: GetMetadataQueryWriter (ptr*)
	Info .....:     Gets the metadata query writer for the encoder frame.
	Param ....:         PpIMetadataQueryWriter  <IWICMetadataQueryWriter>  When this method returns, contains a pointer to metadata query writer for the encoder frame.

	Method ...: Initialize (struct*)
	Info .....:     Initializes the frame encoder using the given properties.
	Param ....:         PIEncoderOptions  <IPropertyBag2>  The set of properties to use for IWICBitmapFrameEncode initialization.

	Method ...: SetColorContexts (uint;struct*)
	Info .....:     Sets a given number IWICColorContext profiles to the frame.
	Param ....:         CCount           <UINT>              The number of IWICColorContext profiles to set.
	Param ....:         PpIColorContext  <IWICColorContext>  A pointer to an IWICColorContext pointer containing the color contexts profiles to set to the frame.

	Method ...: SetPalette (struct*)
	Info .....:     Sets the IWICPalette for indexed pixel formats.
	Param ....:         PIPalette  <IWICPalette>  The encoder may change the palette to reflect the pixel formats the encoder supports.

	Method ...: SetPixelFormat (struct*)
	Info .....:     Requests that the encoder use the specified pixel format.
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  On input, the requested pixel format GUID. On output, the closest pixel format GUID supported by the encoder; this may be different than the requested format. For a list of pixel format GUIDs, see Native Pixel Formats.

	Method ...: SetResolution (double;double)
	Info .....:     Sets the physical resolution of the output image.
	Param ....:         DpiX  <double>  The horizontal resolution value.
	Param ....:         DpiY  <double>  The vertical resolution value.

	Method ...: SetSize (uint;uint)
	Info .....:     Sets the output image dimensions for the frame.
	Param ....:         UiWidth   <UINT>  The width of the output image.
	Param ....:         UiHeight  <UINT>  The height of the output image.

	Method ...: SetThumbnail (struct*)
	Info .....:     Sets the frame thumbnail if supported by the codec.
	Param ....:         PIThumbnail  <IWICBitmapSource>  The bitmap source to use as the thumbnail.

	Method ...: WritePixels (uint;uint;uint;struct*)
	Info .....:     Copies scan-line data from a caller-supplied buffer to the IWICBitmapFrameEncode object.
	Param ....:         LineCount     <UINT>  The number of lines to encode.
	Param ....:         CbStride      <UINT>  The stride of the image pixels.
	Param ....:         CbBufferSize  <UINT>  The size of the pixel buffer.
	Param ....:         PbPixels      <BYTE>  A pointer to the pixel buffer.

	Method ...: WriteSource (struct*;struct*)
	Info .....:     Encodes a bitmap source.
	Param ....:         PIBitmapSource  <IWICBitmapSource>  The bitmap source to encode.
	Param ....:         Prc             <WICRect>           The size rectangle of the bitmap source.

#ce
; _WIC_BitmapFrameEncode_Commit



; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_BitmapFrameEncode_GetMetadataQueryWriter
; Description ...: Gets the metadata query writer for the encoder frame.
; Syntax ........: _WIC_BitmapFrameEncode_GetMetadataQueryWriter($oIBitmapFrameEncode)
; Parameters ....: $oIBitmapFrameEncode - This IWICBitmapFrameEncode object
; Return values .: Success - An IWICMetadataQueryWriter object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: If you are setting metadata on the frame, you must do this before you use IWICBitmapFrameEncode::WritePixels or IWICBitmapFrameEncode::WriteSource
;                  to write any image pixels to the frame
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _WIC_BitmapFrameEncode_GetMetadataQueryWriter($oIBitmapFrameEncode)
	If Not IsObj($oIBitmapFrameEncode) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pMetadataQueryWriter
	Local $iHResult = $oIBitmapFrameEncode.GetMetadataQueryWriter($pMetadataQueryWriter)
	If $iHResult Or Not $pMetadataQueryWriter Then Return SetError($iHResult, 1, False)

	Local $oMetadataQueryWriter = ObjCreateInterface($pMetadataQueryWriter, $sIID_IWICMetadataQueryWriter, $tagIWICMetadataQueryWriter)
	If Not IsObj($oMetadataQueryWriter) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oMetadataQueryWriter
EndFunc


; _WIC_BitmapFrameEncode_Initialize
; _WIC_BitmapFrameEncode_SetColorContexts
; _WIC_BitmapFrameEncode_SetPalette
; _WIC_BitmapFrameEncode_SetPixelFormat
; _WIC_BitmapFrameEncode_SetResolution
; _WIC_BitmapFrameEncode_SetSize
; _WIC_BitmapFrameEncode_SetThumbnail
; _WIC_BitmapFrameEncode_WritePixels
; _WIC_BitmapFrameEncode_WriteSource





;#######################################################################################################################################################################
;# IWICBitmapLock
;#######################################################################################################################################################################
#cs    IWICBitmapLock
	Method ...: GetDataPointer (uint*;ptr*)
	Info .....:     Gets the pointer to the top left pixel in the locked rectangle.
	Param ....:         PcbBufferSize  <UINT>  A pointer that receives the size of the buffer.
	Param ....:         PpbData        <BYTE>  A pointer that receives a pointer to the top left pixel in the locked rectangle.

	Method ...: GetPixelFormat (ptr*)
	Info .....:     Gets the pixel format of for the locked area of pixels. This can be used to compute the number of bytes-per-pixel in the locked area.
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  A pointer that receives the pixel format GUID of the locked area.

	Method ...: GetSize (uint*;uint*)
	Info .....:     Retrieves the width and height, in pixels, of the locked rectangle.
	Param ....:         PWidth   <UINT>  A pointer that receives the width of the locked rectangle.
	Param ....:         PHeight  <UINT>  A pointer that receives the height of the locked rectangle.

	Method ...: GetStride (uint*)
	Info .....:     Provides access to the stride value for the memory.
	Param ....:         PcbStride  <UINT>  Type: UINT*

#ce
; _WIC_BitmapLock_GetDataPointer
; _WIC_BitmapLock_GetPixelFormat
; _WIC_BitmapLock_GetSize
; _WIC_BitmapLock_GetStride





;#######################################################################################################################################################################
;# IWICBitmapScaler
;#######################################################################################################################################################################
#cs    IWICBitmapScaler
	Method ...: Initialize (struct*;uint;uint;uint)
	Info .....:     Initializes the bitmap scaler with the provided parameters.
	Param ....:         PISource  <IWICBitmapSource>            The input bitmap source.
	Param ....:         UiWidth   <UINT>                        The destination width.
	Param ....:         UiHeight  <UINT>                        The desination height.
	Param ....:         Mode      <WICBitmapInterpolationMode>  The WICBitmapInterpolationMode to use when scaling.

#ce
; _WIC_BitmapScaler_Initialize





;#######################################################################################################################################################################
;# IWICBitmapSource
;#######################################################################################################################################################################
#cs    IWICBitmapSource
	Method ...: CopyPalette (struct*)
	Info .....:     Retrieves the color table for indexed pixel formats.
	Param ....:         PIPalette  <IWICPalette>  An IWICPalette. A palette can be created using the CreatePalette method.

	Method ...: CopyPixels (struct*;uint;uint;struct*)
	Info .....:     Instructs the object to produce pixels.
	Param ....:         Prc           <WICRect>  The rectangle to copy. A NULL value specifies the entire bitmap.
	Param ....:         CbStride      <UINT>     The stride of the bitmap
	Param ....:         CbBufferSize  <UINT>     The size of the buffer.
	Param ....:         PbBuffer      <BYTE>     A pointer to the buffer.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format of the bitmap source..
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  Receives the pixel format GUID the bitmap is stored in. For a list of available pixel formats, see the Native Pixel Formats topic.

	Method ...: GetResolution (double*;double*)
	Info .....:     Retrieves the sampling rate between pixels and physical world measurements.
	Param ....:         PDpiX  <double>  A pointer that receives the x-axis dpi resolution.
	Param ....:         PDpiY  <double>  A pointer that receives the y-axis dpi resolution.

	Method ...: GetSize (uint*;uint*)
	Info .....:     Retrieves the pixel width and height of the bitmap.
	Param ....:         PuiWidth   <UINT>  A pointer that receives the pixel width of the bitmap.
	Param ....:         PuiHeight  <UINT>  A pointer that receives the pixel height of the bitmap

#ce
; _WIC_BitmapSource_CopyPalette
; _WIC_BitmapSource_CopyPixels
; _WIC_BitmapSource_GetPixelFormat
; _WIC_BitmapSource_GetResolution
; _WIC_BitmapSource_GetSize





;#######################################################################################################################################################################
;# IWICBitmapSourceTransform
;#######################################################################################################################################################################
#cs    IWICBitmapSourceTransform
	Method ...: CopyPixels (struct*;uint;uint;struct*;uint;uint;uint;ptr*)
	Info .....:     Copies pixel data using the supplied input parameters.
	Param ....:         Prc             <WICRect>                    The rectangle of pixels to copy.
	Param ....:         UiWidth         <UINT>                       The width to scale the source bitmap. This parameter must equal the value obtainable through IWICBitmapSourceTransform::GetClosestSize.
	Param ....:         UiHeight        <UINT>                       The height to scale the source bitmap. This parameter must equal the value obtainable through IWICBitmapSourceTransform::GetClosestSize.
	Param ....:         PguidDstFormat  <WICPixelFormatGUID>         This GUID must be a format obtained through an GetClosestPixelFormat call.
	Param ....:         DstTransform    <WICBitmapTransformOptions>  If a "dstTransform" is specified, "nStride" is the "transformed stride" and is based on the "pguidDstFormat" pixel format, not the original source's pixel format.
	Param ....:         NStride         <UINT>                       The stride of the destination buffer.
	Param ....:         CbBufferSize    <UINT>                       The size of the destination buffer.
	Param ....:         PbBuffer        <BYTE>                       The output buffer.

	Method ...: DoesSupportTransform (uint;bool*)
	Info .....:     Determines whether a specific transform option is supported natively by the implementation of the IWICBitmapSourceTransform interface.
	Param ....:         DstTransform   <WICBitmapTransformOptions>  The WICBitmapTransformOptions to check if they are supported.
	Param ....:         PfIsSupported  <BOOL>                       A pointer that receives a value specifying whether the transform option is supported.

	Method ...: GetClosestPixelFormat (ptr*)
	Info .....:     Retrieves the closest pixel format to which the implementation of IWICBitmapSourceTransform can natively copy pixels, given a desired format.
	Param ....:         PguidDstFormat  <WICPixelFormatGUID>  A pointer that receives the GUID of the pixel format that is the closest supported pixel format of the desired format.

	Method ...: GetClosestSize (uint*;uint*)
	Info .....:     Returns the closest dimensions the implementation can natively scale to given the desired dimensions.
	Param ....:         PuiWidth   <UINT>  The desired width. A pointer that receives the closest supported width.
	Param ....:         PuiHeight  <UINT>  The desired height. A pointer that receives the closest supported height.

#ce
; _WIC_BitmapSourceTransform_CopyPixels
; _WIC_BitmapSourceTransform_DoesSupportTransform
; _WIC_BitmapSourceTransform_GetClosestPixelFormat
; _WIC_BitmapSourceTransform_GetClosestSize





;#######################################################################################################################################################################
;# IWICBitmapSource
;#######################################################################################################################################################################
#cs    IWICBitmapSource
	Method ...: CopyPalette (struct*)
	Info .....:     Retrieves the color table for indexed pixel formats.
	Param ....:         PIPalette  <IWICPalette>  An IWICPalette. A palette can be created using the CreatePalette method.

	Method ...: CopyPixels (struct*;uint;uint;struct*)
	Info .....:     Instructs the object to produce pixels.
	Param ....:         Prc           <WICRect>  The rectangle to copy. A NULL value specifies the entire bitmap.
	Param ....:         CbStride      <UINT>     The stride of the bitmap
	Param ....:         CbBufferSize  <UINT>     The size of the buffer.
	Param ....:         PbBuffer      <BYTE>     A pointer to the buffer.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format of the bitmap source..
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  Receives the pixel format GUID the bitmap is stored in. For a list of available pixel formats, see the Native Pixel Formats topic.

	Method ...: GetResolution (double*;double*)
	Info .....:     Retrieves the sampling rate between pixels and physical world measurements.
	Param ....:         PDpiX  <double>  A pointer that receives the x-axis dpi resolution.
	Param ....:         PDpiY  <double>  A pointer that receives the y-axis dpi resolution.

	Method ...: GetSize (uint*;uint*)
	Info .....:     Retrieves the pixel width and height of the bitmap.
	Param ....:         PuiWidth   <UINT>  A pointer that receives the pixel width of the bitmap.
	Param ....:         PuiHeight  <UINT>  A pointer that receives the pixel height of the bitmap

#ce
; _WIC_BitmapSource_CopyPalette
; _WIC_BitmapSource_CopyPixels
; _WIC_BitmapSource_GetPixelFormat
; _WIC_BitmapSource_GetResolution
; _WIC_BitmapSource_GetSize





;#######################################################################################################################################################################
;# IWICColorContext
;#######################################################################################################################################################################
#cs    IWICColorContext
	Method ...: GetExifColorSpace (uint*)
	Info .....:     Retrieves the Exchangeable Image File (EXIF) color space color context.
	Param ....:         PValue  <UINT>   

	Method ...: GetProfileBytes (uint;struct*;uint*)
	Info .....:     Retrieves the color context profile.
	Param ....:         CbBuffer   <UINT>  The size of the "pbBuffer" buffer.
	Param ....:         PbBuffer   <BYTE>  A pointer that receives the color context profile.
	Param ....:         PcbActual  <UINT>  A pointer that receives the actual buffer size needed to retrieve the entire color context profile.

	Method ...: GetType (ptr*)
	Info .....:     Retrieves the color context type.
	Param ....:         PType  <WICColorContextType>  A pointer that receives the WICColorContextType of the color context.

	Method ...: InitializeFromExifColorSpace (uint)
	Info .....:     Initializes the color context using an Exchangeable Image File (EXIF) color space.
	Param ....:         Value  <UINT>   

	Method ...: InitializeFromFilename (wstr)
	Info .....:     Initializes the color context from the given file.
	Param ....:         WzFilename  <LPCWSTR>  The name of the file.

	Method ...: InitializeFromMemory (struct*;uint)
	Info .....:     Initializes the color context from a memory block.
	Param ....:         PbBuffer      <BYTE>  The buffer used to initialize the IWICColorContext.
	Param ....:         CbBufferSize  <UINT>  The size of the "pbBuffer" buffer.

#ce
; _WIC_ColorContext_GetExifColorSpace
; _WIC_ColorContext_GetProfileBytes
; _WIC_ColorContext_GetType
; _WIC_ColorContext_InitializeFromExifColorSpace
; _WIC_ColorContext_InitializeFromFilename
; _WIC_ColorContext_InitializeFromMemory





;#######################################################################################################################################################################
;# IWICColorTransform
;#######################################################################################################################################################################
#cs    IWICColorTransform
	Method ...: Initialize (struct*;struct*;struct*;struct*)
	Info .....:     Initializes an IWICColorTransform with a IWICBitmapSource and transforms it from one IWICColorContext to another.
	Param ....:         PIBitmapSource   <IWICBitmapSource>       The bitmap source used to initialize the color transform.
	Param ....:         PIContextSource  <IWICColorContext>       The color context source.
	Param ....:         PIContextDest    <IWICColorContext>       The color context destination.
	Param ....:         PixelFmtDest     <REFWICPixelFormatGUID>  This parameter is limited to a subset of the native WIC pixel formats, see Remarks for a list.

#ce
; _WIC_ColorTransform_Initialize





;#######################################################################################################################################################################
;# IWICBitmapSource
;#######################################################################################################################################################################
#cs    IWICBitmapSource
	Method ...: CopyPalette (struct*)
	Info .....:     Retrieves the color table for indexed pixel formats.
	Param ....:         PIPalette  <IWICPalette>  An IWICPalette. A palette can be created using the CreatePalette method.

	Method ...: CopyPixels (struct*;uint;uint;struct*)
	Info .....:     Instructs the object to produce pixels.
	Param ....:         Prc           <WICRect>  The rectangle to copy. A NULL value specifies the entire bitmap.
	Param ....:         CbStride      <UINT>     The stride of the bitmap
	Param ....:         CbBufferSize  <UINT>     The size of the buffer.
	Param ....:         PbBuffer      <BYTE>     A pointer to the buffer.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format of the bitmap source..
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  Receives the pixel format GUID the bitmap is stored in. For a list of available pixel formats, see the Native Pixel Formats topic.

	Method ...: GetResolution (double*;double*)
	Info .....:     Retrieves the sampling rate between pixels and physical world measurements.
	Param ....:         PDpiX  <double>  A pointer that receives the x-axis dpi resolution.
	Param ....:         PDpiY  <double>  A pointer that receives the y-axis dpi resolution.

	Method ...: GetSize (uint*;uint*)
	Info .....:     Retrieves the pixel width and height of the bitmap.
	Param ....:         PuiWidth   <UINT>  A pointer that receives the pixel width of the bitmap.
	Param ....:         PuiHeight  <UINT>  A pointer that receives the pixel height of the bitmap

#ce
; _WIC_BitmapSource_CopyPalette
; _WIC_BitmapSource_CopyPixels
; _WIC_BitmapSource_GetPixelFormat
; _WIC_BitmapSource_GetResolution
; _WIC_BitmapSource_GetSize





;#######################################################################################################################################################################
;# IWICComponentFactory
;#######################################################################################################################################################################
#cs    IWICComponentFactory
	Method ...: CreateEncoderPropertyBag (struct*;uint;ptr*)
	Info .....:     Creates an encoder property bag.
	Param ....:         PpropOptions    <PROPBAG2>       Pointer to an array of PROPBAG2 options used to create the encoder property bag.
	Param ....:         CCount          <UINT>           The number of PROPBAG2 structures in the "ppropOptions" array.
	Param ....:         PpIPropertyBag  <IPropertyBag2>  A pointer that receives a pointer to an encoder IPropertyBag2.

	Method ...: CreateMetadataReader (struct*;struct*;uint;struct*;ptr*)
	Info .....:     Creates an IWICMetadataReader based on the given parameters.
	Param ....:         GuidMetadataFormat  <REFGUID>             The GUID of the desired metadata format.
	Param ....:         PguidVendor         <GUID>                Pointer to the GUID of the desired metadata reader vendor.
	Param ....:         DwOptions           <DWORD>               The WICPersistOptions and WICMetadataCreationOptions options to use when creating the metadata reader.
	Param ....:         PIStream            <IStream>             Pointer to a stream in which to initialize the reader with. If NULL, the metadata reader will be empty.
	Param ....:         PpIReader           <IWICMetadataReader>  A pointer that receives a pointer to the new metadata reader.

	Method ...: CreateMetadataReaderFromContainer (struct*;struct*;uint;struct*;ptr*)
	Info .....:     Creates an IWICMetadataReader based on the given parameters.
	Param ....:         GuidContainerFormat  <REFGUID>             The container format GUID to base the reader on.
	Param ....:         PguidVendor          <GUID>                Pointer to the vendor GUID of the metadata reader.
	Param ....:         DwOptions            <DWORD>               The WICPersistOptions and WICMetadataCreationOptions options to use when creating the metadata reader.
	Param ....:         PIStream             <IStream>             Pointer to a stream in which to initialize the reader with. If NULL, the metadata reader will be empty.
	Param ....:         PpIReader            <IWICMetadataReader>  A pointer that receives a pointer to the new metadata reader

	Method ...: CreateMetadataWriter (struct*;struct*;uint;ptr*)
	Info .....:     Creates an IWICMetadataWriter based on the given parameters.
	Param ....:         GuidMetadataFormat  <REFGUID>             The GUID of the desired metadata format.
	Param ....:         PguidVendor         <GUID>                Pointer to the GUID of the desired metadata reader vendor.
	Param ....:         DwMetadataOptions   <DWORD>               The WICPersistOptions and WICMetadataCreationOptions options to use when creating the metadata reader.
	Param ....:         PpIWriter           <IWICMetadataWriter>  A pointer that receives a pointer to the new metadata writer.

	Method ...: CreateMetadataWriterFromReader (struct*;struct*;ptr*)
	Info .....:     Creates an IWICMetadataWriter from the given IWICMetadataReader.
	Param ....:         PIReader     <IWICMetadataReader>  Pointer to the metadata reader to base the metadata writer on.
	Param ....:         PguidVendor  <GUID>                Pointer to the GUID of the desired metadata reader vendor.
	Param ....:         PpIWriter    <IWICMetadataWriter>  A pointer that receives a pointer to the new metadata writer.

	Method ...: CreateQueryReaderFromBlockReader (struct*;ptr*)
	Info .....:     Creates a IWICMetadataQueryReader from the given IWICMetadataBlockReader.
	Param ....:         PIBlockReader   <IWICMetadataBlockReader>  Pointer to the block reader to base the query reader on.
	Param ....:         PpIQueryReader  <IWICMetadataQueryReader>  A pointer that receives a pointer to the new metadata query reader.

	Method ...: CreateQueryWriterFromBlockWriter (struct*;ptr*)
	Info .....:     Creates a IWICMetadataQueryWriter from the given IWICMetadataBlockWriter.
	Param ....:         PIBlockWriter   <IWICMetadataBlockWriter>  Pointer to the metadata block reader to base the metadata query writer on.
	Param ....:         PpIQueryWriter  <IWICMetadataQueryWriter>  A pointer that receives a pointer to the new metadata query writer.

#ce
; _WIC_ComponentFactory_CreateEncoderPropertyBag
; _WIC_ComponentFactory_CreateMetadataReader
; _WIC_ComponentFactory_CreateMetadataReaderFromContainer
; _WIC_ComponentFactory_CreateMetadataWriter
; _WIC_ComponentFactory_CreateMetadataWriterFromReader
; _WIC_ComponentFactory_CreateQueryReaderFromBlockReader
; _WIC_ComponentFactory_CreateQueryWriterFromBlockWriter





;#######################################################################################################################################################################
;# IWICComponentInfo
;#######################################################################################################################################################################
#cs    IWICComponentInfo
	Method ...: GetAuthor (uint;wstr;uint*)
	Info .....:     Retrieves the name of component's author.
	Param ....:         CchAuthor   <UINT>   The size of the "wzAuthor" buffer.
	Param ....:         WzAuthor    <WCHAR>  A pointer that receives the name of the component's author. The locale of the string depends on the value that the codec wrote to the registry at install time. For built-in components, these strings are always in English.
	Param ....:         PcchActual  <UINT>   A pointer that receives the actual length of the component's authors name. The author name is optional; if an author name is not specified by the component, the length returned is 0.

	Method ...: GetCLSID (ptr*)
	Info .....:     Retrieves the component's class identifier (CLSID)
	Param ....:         Pclsid  <CLSID>  A pointer that receives the component's CLSID.

	Method ...: GetComponentType (ptr*)
	Info .....:     Retrieves the component's WICComponentType.
	Param ....:         PType  <WICComponentType>  A pointer that receives the WICComponentType.

	Method ...: GetFriendlyName (uint;wstr;uint*)
	Info .....:     Retrieves the component's friendly name, which is a human-readable display name for the component.
	Param ....:         CchFriendlyName  <UINT>   The size of the "wzFriendlyName" buffer.
	Param ....:         WzFriendlyName   <WCHAR>  A pointer that receives the friendly name of the component. The locale of the string depends on the value that the codec wrote to the registry at install time. For built-in components, these strings are always in English.
	Param ....:         PcchActual       <UINT>   A pointer that receives the actual length of the component's friendly name.

	Method ...: GetSigningStatus (ptr*)
	Info .....:     Retrieves the signing status of the component.
	Param ....:         PStatus  <DWORD>  A pointer that receives the WICComponentSigning status of the component.

	Method ...: GetSpecVersion (uint;wstr;uint*)
	Info .....:     Retrieves the component's specification version.
	Param ....:         CchSpecVersion  <UINT>   The size of the "wzSpecVersion" buffer.
	Param ....:         WzSpecVersion   <WCHAR>  When this method returns, contain a culture invarient string of the component's specification version. The version form is NN.NN.NN.NN.
	Param ....:         PcchActual      <UINT>   A pointer that receives the actual length of the component's specification version. The specification version is optional; if a value is not specified by the component, the length returned is 0.

	Method ...: GetVendorGUID (ptr*)
	Info .....:     Retrieves the vendor GUID.
	Param ....:         PguidVendor  <GUID>  A pointer that receives the component's vendor GUID.

	Method ...: GetVersion (uint;wstr;uint*)
	Info .....:     Retrieves the component's version.
	Param ....:         CchVersion  <UINT>   The size of the "wzVersion" buffer.
	Param ....:         WzVersion   <WCHAR>  A pointer that receives a culture invariant string of the component's version.
	Param ....:         PcchActual  <UINT>   A pointer that receives the actual length of the component's version. The version is optional; if a value is not specified by the component, the length returned is 0.

#ce
; _WIC_ComponentInfo_GetAuthor
; _WIC_ComponentInfo_GetCLSID
; _WIC_ComponentInfo_GetComponentType
; _WIC_ComponentInfo_GetFriendlyName
; _WIC_ComponentInfo_GetSigningStatus
; _WIC_ComponentInfo_GetSpecVersion
; _WIC_ComponentInfo_GetVendorGUID
; _WIC_ComponentInfo_GetVersion





;#######################################################################################################################################################################
;# IWICDevelopRaw
;#######################################################################################################################################################################
#cs    IWICDevelopRaw
	Method ...: GetContrast (double*)
	Info .....:     Gets the contrast value of the raw image.
	Param ....:         PContrast  <double>  A pointer that receives the contrast value of the raw image. The default value is the "as-shot" setting. The value range for contrast is 0.0 through 1.0. The 0.0 lower limit represents no contrast applied to the image, while the 1.0 upper limit represents the highest amount of contrast that can be applied.

	Method ...: GetCurrentParameterSet (ptr*)
	Info .....:     Gets the current set of parameters.
	Param ....:         PpCurrentParameterSet  <IPropertyBag2>  A pointer that receives a pointer to the current set of parameters.

	Method ...: GetExposureCompensation (double*)
	Info .....:     Gets the exposure compensation stop value of the raw image.
	Param ....:         PEV  <double>  A pointer that receives the exposure compensation stop value. The default is the "as-shot" setting.

	Method ...: GetGamma (double*)
	Info .....:     Gets the current gamma setting of the raw image.
	Param ....:         PGamma  <double>  A pointer that receives the current gamma setting.

	Method ...: GetKelvinRangeInfo (uint*;uint*;uint*)
	Info .....:     Gets the information about the current Kelvin range of the raw image.
	Param ....:         PMinKelvinTemp        <UINT>  A pointer that receives the minimum Kelvin temperature.
	Param ....:         PMaxKelvinTemp        <UINT>  A pointer that receives the maximum Kelvin temperature.
	Param ....:         PKelvinTempStepValue  <UINT>  A pointer that receives the Kelvin step value.

	Method ...: GetNamedWhitePoint (uint*)
	Info .....:     Gets the named white point of the raw image.
	Param ....:         PWhitePoint  <WICNamedWhitePoint>  A pointer that receives the bitwise combination of the enumeration values.

	Method ...: GetNoiseReduction (double*)
	Info .....:     Gets the noise reduction value of the raw image.
	Param ....:         PNoiseReduction  <double>  A pointer that receives the noise reduction value of the raw image. The default value is the "as-shot" setting if it exists or 0.0. The value range for noise reduction is 0.0 through 1.0. The 0.0 lower limit represents no noise reduction applied to the image, while the 1.0 upper limit represents full highest noise reduction amount that can be applied.

	Method ...: GetRenderMode (ptr*)
	Info .....:     Gets the current WICRawRenderMode.
	Param ....:         PRenderMode  <WICRawRenderMode>  A pointer that receives the current WICRawRenderMode.

	Method ...: GetRotation (double*)
	Info .....:     Gets the current rotation angle.
	Param ....:         PRotation  <double>  A pointer that receives the current rotation angle.

	Method ...: GetSaturation (double*)
	Info .....:     Gets the saturation value of the raw image.
	Param ....:         PSaturation  <double>  A pointer that receives the saturation value of the raw image. The default value is the "as-shot" setting. The value range for saturation is 0.0 through 1.0. A value of 0.0 represents an image with a fully de-saturated image, while a value of 1.0 represents the highest amount of saturation that can be applied.

	Method ...: GetSharpness (double*)
	Info .....:     Gets the sharpness value of the raw image.
	Param ....:         PSharpness  <double>  A pointer that receives the sharpness value of the raw image. The default value is the "as-shot" setting. The value range for sharpness is 0.0 through 1.0. The 0.0 lower limit represents no sharpening applied to the image, while the 1.0 upper limit represents the highest amount of sharpness that can be applied.

	Method ...: GetTint (double*)
	Info .....:     Gets the tint value of the raw image.
	Param ....:         PTint  <double>  A pointer that receives the tint value of the raw image. The default value is the "as-shot" setting if it exists or 0.0. The value range for sharpness is -1.0 through +1.0. The -1.0 lower limit represents a full green bias to the image, while the 1.0 upper limit represents a full magenta bias.

	Method ...: GetToneCurve (uint;ptr*;uint*)
	Info .....:     Gets the tone curve of the raw image.
	Param ....:         CbToneCurveBufferSize         <UINT>             The size of the "pToneCurve" buffer.
	Param ....:         PToneCurve                    <WICRawToneCurve>  A pointer that receives the WICRawToneCurve of the raw image.
	Param ....:         PcbActualToneCurveBufferSize  <UINT>             A pointer that receives the size needed to obtain the tone curve structure.

	Method ...: GetWhitePointKelvin (uint*)
	Info .....:     Gets the white point Kelvin temperature of the raw image.
	Param ....:         PWhitePointKelvin  <UINT>  A pointer that receives the white point Kelvin temperature of the raw image. The default is the "as-shot" setting value.

	Method ...: GetWhitePointRGB (uint*;uint*;uint*)
	Info .....:     Gets the white point RGB values.
	Param ....:         PRed    <UINT>  A pointer that receives the red white point value.
	Param ....:         PGreen  <UINT>  A pointer that receives the green white point value.
	Param ....:         PBlue   <UINT>  A pointer that receives the blue white point value.

	Method ...: LoadParameterSet (uint)
	Info .....:     Sets the desired WICRawParameterSet option.
	Param ....:         ParameterSet  <WICRawParameterSet>  The desired WICRawParameterSet option.

	Method ...: QueryRawCapabilitiesInfo (ptr*)
	Info .....:     Retrieves information about which capabilities are supported for a raw image.
	Param ....:         PInfo  <WICRawCapabilitiesInfo>  A pointer that receives WICRawCapabilitiesInfo that provides the capabilities supported by the raw image.

	Method ...: SetContrast (double)
	Info .....:     Sets the contrast value of the raw image.
	Param ....:         Contrast  <double>  The contrast value of the raw image. The default value is the "as-shot" setting. The value range for contrast is 0.0 through 1.0. The 0.0 lower limit represents no contrast applied to the image, while the 1.0 upper limit represents the highest amount of contrast that can be applied.

	Method ...: SetDestinationColorContext (struct*)
	Info .....:     Sets the destination color context.
	Param ....:         PColorContext  <IWICColorContext>  The destination color context.

	Method ...: SetExposureCompensation (double)
	Info .....:     Sets the exposure compensation stop value.
	Param ....:         Ev  <double>  The exposure compensation value. The value range for exposure compensation is -5.0 through +5.0, which equates to 10 full stops.

	Method ...: SetGamma (double)
	Info .....:     Sets the desired gamma value.
	Param ....:         Gamma  <double>  The desired gamma value.

	Method ...: SetNamedWhitePoint (uint)
	Info .....:     Sets the named white point of the raw file.
	Param ....:         WhitePoint  <WICNamedWhitePoint>  A bitwise combination of the enumeration values.

	Method ...: SetNoiseReduction (double)
	Info .....:     Sets the noise reduction value of the raw image.
	Param ....:         NoiseReduction  <double>  The noise reduction value of the raw image. The default value is the "as-shot" setting if it exists or 0.0. The value range for noise reduction is 0.0 through 1.0. The 0.0 lower limit represents no noise reduction applied to the image, while the 1.0 upper limit represents highest noise reduction amount that can be applied.

	Method ...: SetNotificationCallback (struct*)
	Info .....:     Sets the notification callback method.
	Param ....:         PCallback  <IWICDevelopRawNotificationCallback>  Pointer to the notification callback method.

	Method ...: SetRenderMode (uint)
	Info .....:     Sets the current WICRawRenderMode.
	Param ....:         RenderMode  <WICRawRenderMode>  The render mode to use.

	Method ...: SetRotation (double)
	Info .....:     Sets the desired rotation angle.
	Param ....:         Rotation  <double>  The desired rotation angle.

	Method ...: SetSaturation (double)
	Info .....:     Sets the saturation value of the raw image.
	Param ....:         Saturation  <double>  The saturation value of the raw image. The value range for saturation is 0.0 through 1.0. A value of 0.0 represents an image with a fully de-saturated image, while a value of 1.0 represents the highest amount of saturation that can be applied.

	Method ...: SetSharpness (double)
	Info .....:     Sets the sharpness value of the raw image.
	Param ....:         Sharpness  <double>  The sharpness value of the raw image. The default value is the "as-shot" setting. The value range for sharpness is 0.0 through 1.0. The 0.0 lower limit represents no sharpening applied to the image, while the 1.0 upper limit represents the highest amount of sharpness that can be applied.

	Method ...: SetTint (double)
	Info .....:     Sets the tint value of the raw image.
	Param ....:         Tint  <double>  The tint value of the raw image. The default value is the "as-shot" setting if it exists or 0.0. The value range for sharpness is -1.0 through +1.0. The -1.0 lower limit represents a full green bias to the image, while the 1.0 upper limit represents a full magenta bias.

	Method ...: SetToneCurve (uint;struct*)
	Info .....:     Sets the tone curve for the raw image.
	Param ....:         CbToneCurveSize  <UINT>             The size of the "pToneCurve" structure.
	Param ....:         PToneCurve       <WICRawToneCurve>  The desired tone curve.

	Method ...: SetWhitePointKelvin (uint)
	Info .....:     Sets the white point Kelvin value.
	Param ....:         WhitePointKelvin  <UINT>  The white point Kelvin value. Acceptable Kelvin values are 1,500 through 30,000.

	Method ...: SetWhitePointRGB (uint;uint;uint)
	Info .....:     Sets the white point RGB values.
	Param ....:         Red    <UINT>  The red white point value.
	Param ....:         Green  <UINT>  The green white point value.
	Param ....:         Blue   <UINT>  The blue white point value.

#ce
; _WIC_DevelopRaw_GetContrast
; _WIC_DevelopRaw_GetCurrentParameterSet
; _WIC_DevelopRaw_GetExposureCompensation
; _WIC_DevelopRaw_GetGamma
; _WIC_DevelopRaw_GetKelvinRangeInfo
; _WIC_DevelopRaw_GetNamedWhitePoint
; _WIC_DevelopRaw_GetNoiseReduction
; _WIC_DevelopRaw_GetRenderMode
; _WIC_DevelopRaw_GetRotation
; _WIC_DevelopRaw_GetSaturation
; _WIC_DevelopRaw_GetSharpness
; _WIC_DevelopRaw_GetTint
; _WIC_DevelopRaw_GetToneCurve
; _WIC_DevelopRaw_GetWhitePointKelvin
; _WIC_DevelopRaw_GetWhitePointRGB
; _WIC_DevelopRaw_LoadParameterSet
; _WIC_DevelopRaw_QueryRawCapabilitiesInfo
; _WIC_DevelopRaw_SetContrast
; _WIC_DevelopRaw_SetDestinationColorContext
; _WIC_DevelopRaw_SetExposureCompensation
; _WIC_DevelopRaw_SetGamma
; _WIC_DevelopRaw_SetNamedWhitePoint
; _WIC_DevelopRaw_SetNoiseReduction
; _WIC_DevelopRaw_SetNotificationCallback
; _WIC_DevelopRaw_SetRenderMode
; _WIC_DevelopRaw_SetRotation
; _WIC_DevelopRaw_SetSaturation
; _WIC_DevelopRaw_SetSharpness
; _WIC_DevelopRaw_SetTint
; _WIC_DevelopRaw_SetToneCurve
; _WIC_DevelopRaw_SetWhitePointKelvin
; _WIC_DevelopRaw_SetWhitePointRGB





;#######################################################################################################################################################################
;# IWICDevelopRawNotificationCallback
;#######################################################################################################################################################################
#cs    IWICDevelopRawNotificationCallback
	Method ...: Notify (uint)
	Info .....:     An application-defined callback method used for raw image parameter change notifications.
	Param ....:         NotificationMask  <UINT>  A set of IWICDevelopRawNotificationCallback Constants parameter notification flags.

#ce
; _WIC_DevelopRawNotificationCallback_Notify





;#######################################################################################################################################################################
;# IWICEnumMetadataItem
;#######################################################################################################################################################################
#cs    IWICEnumMetadataItem
	Method ...: Clone (ptr*)
	Info .....:     Creates a copy of the current IWICEnumMetadataItem.
	Param ....:         PpIEnumMetadataItem  <IWICEnumMetadataItem>  A pointer that receives a pointer to the IWICEnumMetadataItem copy.

	Method ...: Next (uint;struct*;struct*;struct*;uint*)
	Info .....:     Advanced the current position in the enumeration.
	Param ....:         Celt          <ULONG>        The number of items to be retrieved.
	Param ....:         RgeltSchema   <PROPVARIANT>  An array of enumerated items. This parameter is optional.
	Param ....:         RgeltId       <PROPVARIANT>  An array of enumerated items.
	Param ....:         RgeltValue    <PROPVARIANT>  An array of enumerated items. This parameter is optional.
	Param ....:         PceltFetched  <ULONG>        The number of items that were retrieved. This value is always less than or equal to the number of items requested.

	Method ...: Reset ()
	Info .....:     Resets the current position to the beginning of the enumeration.
	Param ....:         This method has no parameters.

	Method ...: Skip (uint)
	Info .....:     Skips to given number of objects.
	Param ....:         Celt  <ULONG>  The number of objects to skip.

#ce
; _WIC_EnumMetadataItem_Clone
; _WIC_EnumMetadataItem_Next
; _WIC_EnumMetadataItem_Reset
; _WIC_EnumMetadataItem_Skip





;#######################################################################################################################################################################
;# IWICFastMetadataEncoder
;#######################################################################################################################################################################
#cs    IWICFastMetadataEncoder
	Method ...: Commit ()
	Info .....:     Finalizes metadata changes to the image stream.
	Param ....:         This method has no parameters.

	Method ...: GetMetadataQueryWriter (ptr*)
	Info .....:     Retrieves a metadata query writer for fast metadata encoding.
	Param ....:         PpIMetadataQueryWriter  <IWICMetadataQueryWriter>  When this method returns, contains a pointer to the fast metadata encoder's metadata query writer.

#ce
; _WIC_FastMetadataEncoder_Commit
; _WIC_FastMetadataEncoder_GetMetadataQueryWriter





;#######################################################################################################################################################################
;# IWICFormatConverter
;#######################################################################################################################################################################
#cs    IWICFormatConverter
	Method ...: CanConvert (struct*;struct*;bool*)
	Info .....:     Determines if the source pixel format can be converted to the destination pixel format.
	Param ....:         SrcPixelFormat  <REFWICPixelFormatGUID>  The source pixel format.
	Param ....:         DstPixelFormat  <REFWICPixelFormatGUID>  The destionation pixel format.
	Param ....:         PfCanConvert    <BOOL>                   A pointer that receives a value indicating whether the source pixel format can be converted to the destination pixel format.

	Method ...: Initialize (struct*;struct*;uint;struct*;double;uint)
	Info .....:     Initializes the format converter.
	Param ....:         PISource               <IWICBitmapSource>       The input bitmap to convert
	Param ....:         DstFormat              <REFWICPixelFormatGUID>  The destination pixel format GUID.
	Param ....:         Dither                 <WICBitmapDitherType>    The WICBitmapDitherType used for conversion.
	Param ....:         PIPalette              <IWICPalette>            The palette to use for conversion.
	Param ....:         AlphaThresholdPercent  <double>                 The alpha threshold to use for conversion.
	Param ....:         PaletteTranslate       <WICBitmapPaletteType>   The palette translation type to use for conversion.

#ce
; _WIC_FormatConverter_CanConvert
; _WIC_FormatConverter_Initialize





;#######################################################################################################################################################################
;# IWICBitmapSource
;#######################################################################################################################################################################
#cs    IWICBitmapSource
	Method ...: CopyPalette (struct*)
	Info .....:     Retrieves the color table for indexed pixel formats.
	Param ....:         PIPalette  <IWICPalette>  An IWICPalette. A palette can be created using the CreatePalette method.

	Method ...: CopyPixels (struct*;uint;uint;struct*)
	Info .....:     Instructs the object to produce pixels.
	Param ....:         Prc           <WICRect>  The rectangle to copy. A NULL value specifies the entire bitmap.
	Param ....:         CbStride      <UINT>     The stride of the bitmap
	Param ....:         CbBufferSize  <UINT>     The size of the buffer.
	Param ....:         PbBuffer      <BYTE>     A pointer to the buffer.

	Method ...: GetPixelFormat (struct*)
	Info .....:     Retrieves the pixel format of the bitmap source..
	Param ....:         PPixelFormat  <WICPixelFormatGUID>  Receives the pixel format GUID the bitmap is stored in. For a list of available pixel formats, see the Native Pixel Formats topic.

	Method ...: GetResolution (double*;double*)
	Info .....:     Retrieves the sampling rate between pixels and physical world measurements.
	Param ....:         PDpiX  <double>  A pointer that receives the x-axis dpi resolution.
	Param ....:         PDpiY  <double>  A pointer that receives the y-axis dpi resolution.

	Method ...: GetSize (uint*;uint*)
	Info .....:     Retrieves the pixel width and height of the bitmap.
	Param ....:         PuiWidth   <UINT>  A pointer that receives the pixel width of the bitmap.
	Param ....:         PuiHeight  <UINT>  A pointer that receives the pixel height of the bitmap

#ce
; _WIC_BitmapSource_CopyPalette
; _WIC_BitmapSource_CopyPixels
; _WIC_BitmapSource_GetPixelFormat
; _WIC_BitmapSource_GetResolution
; _WIC_BitmapSource_GetSize





;#######################################################################################################################################################################
;# IWICFormatConverterInfo
;#######################################################################################################################################################################
#cs    IWICFormatConverterInfo
	Method ...: CreateInstance (ptr*)
	Info .....:     Creates a new IWICFormatConverter instance.
	Param ....:         PpIConverter  <IWICFormatConverter>  A pointer that receives a new IWICFormatConverter instance.

	Method ...: GetPixelFormats (uint;struct*;uint*)
	Info .....:     Retrieves a list of GUIDs that signify which pixel formats the converter supports.
	Param ....:         CFormats           <UINT>                The size of the "pPixelFormatGUIDs" array.
	Param ....:         PPixelFormatGUIDs  <WICPixelFormatGUID>  Pointer to a GUID array that receives the pixel formats the converter supports.
	Param ....:         PcActual           <UINT>                The actual array size needed to retrieve all pixel formats supported by the converter.

#ce
; _WIC_FormatConverterInfo_CreateInstance
; _WIC_FormatConverterInfo_GetPixelFormats





;#######################################################################################################################################################################
;# IWICImagingFactory
;#######################################################################################################################################################################
#cs    IWICImagingFactory
	Method ...: CreateBitmap (ptr*)
	Info .....:     Creates an IWICBitmap object.
	Param ....:         UiWidth      <UINT>                        The width of the new bitmap .
	Param ....:         UiHeight     <UINT>                        The height of the new bitmap.
	Param ....:         PixelFormat  <REFWICPixelFormatGUID>       The pixel format of the new bitmap.
	Param ....:         Option       <WICBitmapCreateCacheOption>   
	Param ....:         PpIBitmap    <IWICBitmap>                  A pointer that receives a pointer to the new bitmap.

	Method ...: CreateBitmapClipper (ptr*)
	Info .....:     Creates a new instance of an IWICBitmapClipper object.
	Param ....:         PpIBitmapClipper  <IWICBitmapClipper>  A pointer that receives a pointer to a new IWICBitmapClipper.

	Method ...: CreateBitmapFlipRotator (ptr*)
	Info .....:     Creates a new instance of an IWICBitmapFlipRotator object.
	Param ....:         PpIBitmapFlipRotator  <IWICBitmapFlipRotator>  A pointer that receives a pointer to a new IWICBitmapFlipRotator.

	Method ...: CreateBitmapFromHBITMAP (handle;handle;uint;ptr*)
	Info .....:     Creates an IWICBitmap from a bitmap handle.
	Param ....:         HBitmap    <HBITMAP>                      A bitmap handle to create the bitmap from.
	Param ....:         HPalette   <HPALETTE>                     A palette handle used to create the bitmap.
	Param ....:         Options    <WICBitmapAlphaChannelOption>  The alpha channel options to create the bitmap.
	Param ....:         PpIBitmap  <IWICBitmap>                   A pointer that receives a pointer to the new bitmap.

	Method ...: CreateBitmapFromHICON (handle;ptr*)
	Info .....:     Creates an IWICBitmap from an icon handle.
	Param ....:         HIcon      <HICON>       The icon handle to create the new bitmap from.
	Param ....:         PpIBitmap  <IWICBitmap>  A pointer that receives a pointer to the new bitmap.

	Method ...: CreateBitmapFromMemory (uint;uint;struct*;uint;uint;struct*;ptr*)
	Info .....:     Creates an IWICBitmap from a memory block.
	Param ....:         UiWidth       <UINT>                   The width of the new bitmap.
	Param ....:         UiHeight      <UINT>                   The height of the new bitmap.
	Param ....:         PixelFormat   <REFWICPixelFormatGUID>  The pixel format of the new bitmap. For valid pixel formats, see Native Pixel Formats.
	Param ....:         CbStride      <UINT>                   The number of bytes between successive scanlines in "pbBuffer".
	Param ....:         CbBufferSize  <UINT>                   The size of "pbBuffer".
	Param ....:         PbBuffer      <BYTE>                   The buffer used to create the bitmap.
	Param ....:         PpIBitmap     <IWICBitmap>             A pointer that receives a pointer to the new bitmap.

	Method ...: CreateBitmapFromSource (struct*;uint;ptr*)
	Info .....:     Creates a IWICBitmap from a IWICBitmapSource.
	Param ....:         PIBitmapSource  <IWICBitmapSource>            The IWICBitmapSource to create the bitmap from.
	Param ....:         Option          <WICBitmapCreateCacheOption>   
	Param ....:         PpIBitmap       <IWICBitmap>                  A pointer that receives a pointer to the new bitmap.

	Method ...: CreateBitmapFromSourceRect (struct*;uint;uint;uint;uint;ptr*)
	Info .....:     Creates an IWICBitmap from a specified rectangle of an IWICBitmapSource.
	Param ....:         PIBitmapSource  <IWICBitmapSource>  The IWICBitmapSource to create the bitmap from.
	Param ....:         X               <UINT>              The horizontal coordinate of the upper-left corner of the rectangle.
	Param ....:         Y               <UINT>              The vertical coordinate of the upper-left corner of the rectangle.
	Param ....:         Width           <UINT>              The width of the rectangle and the new bitmap.
	Param ....:         Height          <UINT>              The height of the rectangle and the new bitmap.
	Param ....:         PpIBitmap       <IWICBitmap>        A pointer that receives a pointer to the new bitmap.

	Method ...: CreateBitmapScaler (ptr*)
	Info .....:     Creates a new instance of an IWICBitmapScaler.
	Param ....:         PpIBitmapScaler  <IWICBitmapScaler>  A pointer that receives a pointer to a new IWICBitmapScaler.

	Method ...: CreateColorContext (ptr*)
	Info .....:     Creates a new instance of the IWICColorContext class.
	Param ....:         PpIWICColorContext  <IWICColorContext>  A pointer that receives a pointer to a new IWICColorContext.

	Method ...: CreateColorTransformer (ptr*)
	Info .....:     Creates a new instance of the IWICColorTransform class.
	Param ....:         PpIWICColorTransform  <IWICColorTransform>  A pointer that receives a pointer to a new IWICColorTransform.

	Method ...: CreateComponentEnumerator (uint;uint;ptr*)
	Info .....:     Creates an IEnumUnknown object of the specified component types.
	Param ....:         ComponentTypes  <DWORD>         The types of WICComponentType to enumerate.
	Param ....:         Options         <DWORD>         The WICComponentEnumerateOptions used to enumerate the given component types.
	Param ....:         PpIEnumUnknown  <IEnumUnknown>  A pointer that receives a pointer to a new component enumerator.

	Method ...: CreateComponentInfo (struct*;ptr*)
	Info .....:     Creates a new instance of the IWICComponentInfo class for the given component class identifier (CLSID).
	Param ....:         ClsidComponent  <REFCLSID>           The CLSID for the desired component.
	Param ....:         PpIInfo         <IWICComponentInfo>  A pointer that receives a pointer to a new IWICComponentInfo.

	Method ...: CreateDecoder (wstr;struct*;uint;uint;ptr*)
	Info .....:     Creates a new instance of IWICBitmapDecoder.
	Param ....:         GuidContainerFormat  <REFGUID>             
	Param ....:         PguidVendor          <GUID>                
	Param ....:         PpIDecoder           <IWICBitmapDecoder>  A pointer that receives a pointer to a new IWICBitmapDecoder. You must initialize this IWICBitmapDecoder on a stream using the Initialize method later.

	Method ...: CreateDecoderFromFileHandle (handle;struct*;uint;ptr*)
	Info .....:     Creates a new instance of the IWICBitmapDecoder based on the given file handle.
	Param ....:         HFile            <ULONG_PTR>          The file handle to create the decoder from.
	Param ....:         PguidVendor      <GUID>               The GUID for the preferred decoder vendor. Use NULL if no preferred vendor.
	Param ....:         MetadataOptions  <WICDecodeOptions>   The WICDecodeOptions to use when creating the decoder.
	Param ....:         PpIDecoder       <IWICBitmapDecoder>  A pointer that receives a pointer to a new IWICBitmapDecoder.

	Method ...: CreateDecoderFromFilename (wstr;struct*;uint;uint;ptr*)
	Info .....:     Creates a new instance of the IWICBitmapDecoder class based on the given file.
	Param ....:         WzFilename       <LPCWSTR>            A pointer to a null-terminated string that specifies the name of an object to create or open.
	Param ....:         PguidVendor      <GUID>               The GUID for the preferred decoder vendor. Use NULL if no preferred vendor.
	Param ....:         DwDesiredAccess  <DWORD>              For more information, see Generic Access Rights.
	Param ....:         MetadataOptions  <WICDecodeOptions>   The WICDecodeOptions to use when creating the decoder.
	Param ....:         PpIDecoder       <IWICBitmapDecoder>  A pointer that receives a pointer to the new IWICBitmapDecoder.

	Method ...: CreateDecoderFromStream (struct*;struct*;uint;ptr*)
	Info .....:     Creates a new instance of the IWICBitmapDecoder class based on the given IStream.
	Param ....:         PIStream         <IStream>            The stream to create the decoder from.
	Param ....:         PguidVendor      <GUID>               The GUID for the preferred decoder vendor. Use NULL if no preferred vendor.
	Param ....:         MetadataOptions  <WICDecodeOptions>   The WICDecodeOptions to use when creating the decoder.
	Param ....:         PpIDecoder       <IWICBitmapDecoder>  A pointer that receives a pointer to a new IWICBitmapDecoder.

	Method ...: CreateEncoder (struct*;struct*;ptr*)
	Info .....:     Creates a new instance of the IWICBitmapEncoder class.
	Param ....:         GuidContainerFormat  <REFGUID>             
	Param ....:         PguidVendor          <GUID>                
	Param ....:         PpIEncoder           <IWICBitmapEncoder>  A pointer that receives a pointer to a new IWICBitmapEncoder.

	Method ...: CreateFastMetadataEncoderFromDecoder (struct*;ptr*)
	Info .....:     Creates a new instance of the fast metadata encoder based on the given IWICBitmapDecoder.
	Param ....:         PIDecoder       <IWICBitmapDecoder>        The decoder to create the fast metadata encoder from.
	Param ....:         PpIFastEncoder  <IWICFastMetadataEncoder>  When this method returns, contains a pointer to the new IWICFastMetadataEncoder.

	Method ...: CreateFastMetadataEncoderFromFrameDecode (struct*;ptr*)
	Info .....:     Creates a new instance of the fast metadata encoder based on the given image frame.
	Param ....:         PIFrameDecoder  <IWICBitmapFrameDecode>    The IWICBitmapFrameDecode to create the IWICFastMetadataEncoder from.
	Param ....:         PpIFastEncoder  <IWICFastMetadataEncoder>  When this method returns, contains a pointer to a new fast metadata encoder.

	Method ...: CreateFormatConverter (ptr*)
	Info .....:     Creates a new instance of the IWICFormatConverter class.
	Param ....:         PpIFormatConverter  <IWICFormatConverter>  A pointer that receives a pointer to a new IWICFormatConverter.

	Method ...: CreatePalette (ptr*)
	Info .....:     Creates a new instance of the IWICPalette class.
	Param ....:         PpIPalette  <IWICPalette>  A pointer that receives a pointer to a new IWICPalette.

	Method ...: CreateQueryWriter (struct*;struct*;ptr*)
	Info .....:     Creates a new instance of a query writer.
	Param ....:         GuidMetadataFormat  <REFGUID>                  The GUID for the desired metadata format.
	Param ....:         PguidVendor         <GUID>                     The GUID for the preferred metadata writer vendor. Use NULL if no preferred vendor.
	Param ....:         PpIQueryWriter      <IWICMetadataQueryWriter>  When this method returns, contains a pointer to a new IWICMetadataQueryWriter.

	Method ...: CreateQueryWriterFromReader (struct*;struct*;ptr*)
	Info .....:     Creates a new instance of a query writer based on the given query reader. The query writer will be pre-populated with metadata from the query reader.
	Param ....:         PIQueryReader   <IWICMetadataQueryReader>  The IWICMetadataQueryReader to create the IWICMetadataQueryWriter from.
	Param ....:         PguidVendor     <GUID>                     The GUID for the preferred metadata writer vendor. Use NULL if no preferred vendor.
	Param ....:         PpIQueryWriter  <IWICMetadataQueryWriter>  When this method returns, contains a pointer to a new metadata writer.

	Method ...: CreateStream (ptr*)
	Info .....:     Creates a new instance of the IWICStream class.
	Param ....:         PpIWICStream  <IWICStream>  A pointer that receives a pointer to a new IWICStream.

#ce
; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_Create
; Description ...: Creates a ImagingFactory object.
; Syntax ........: _WIC_ImagingFactory_Create()
; Parameters ....:
; Return values .: Success - An IWICImagingFactory object.
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
Func _WIC_ImagingFactory_Create()
	Local $oObj = ObjCreateInterface($sCLSID_WICImagingFactory, $sIID_IWICImagingFactory, $tagIWICImagingFactory)
	If Not IsObj($oObj) Then Return SetError($WICERR_OBJFAIL, 0, False)
	Return $oObj
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateBitmap
; Description ...: Creates an IWICBitmap object.
; Syntax ........: _WIC_ImagingFactory_CreateBitmap($oIImagingFactory, $iWidth, $iHeight[, $sPixelFormat = $sGUID_WICPixelFormat32bppPBGRA[, $iOption = $WICBitmapCacheOnLoad]])
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
;                  $iWidth           - The width of the new bitmap .
;                  $iHeight          - The height of the new bitmap.
;                  $sPixelFormat     - [optional] The pixel format of the new bitmap.
;                  $iOption          - [optional] A $WICBitmapCreateCacheOption enumeraion.  
; Return values .: Success - An IWICBitmap object.
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
Func _WIC_ImagingFactory_CreateBitmap($oIImagingFactory, $iWidth, $iHeight, $sPixelFormat = $sGUID_WICPixelFormat32bppPBGRA, $iOption = $WICBitmapCacheOnLoad)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $tGUID = _WinAPI_GUIDFromString($sPixelFormat)
	If @error Or Not IsDllStruct($tGUID) Then Return SetError($WICERR_PARAM, 1, False)

	Local $pBitmap
	Local $iHResult = $oIImagingFactory.CreateBitmap($iWidth, $iHeight, $tGUID, $iOption, $pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 2, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_IWICBitmap, $tagIWICBitmap)
	If Not IsObj($oBitmap) Then Return SetError($WICERR_OBJFAIL, 3, False)
	Return $oBitmap
EndFunc


; _WIC_ImagingFactory_CreateBitmapClipper
; _WIC_ImagingFactory_CreateBitmapFlipRotator
; _WIC_ImagingFactory_CreateBitmapFromHBITMAP




; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateBitmapFromHICON
; Description ...: Creates an IWICBitmap from an icon handle.
; Syntax ........: _WIC_ImagingFactory_CreateBitmapFromHICON($oIImagingFactory, $vHIcon)
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
;                  $hIcon            - The icon handle to create the new bitmap from.
; Return values .: Success - An IWICBitmap object.
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
Func _WIC_ImagingFactory_CreateBitmapFromHICON($oIImagingFactory, $hIcon)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pBitmap
	Local $iHResult = $oIImagingFactory.CreateBitmapFromHICON($hIcon, $pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 1, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_IWICBitmap, $tagIWICBitmap)
	If Not IsObj($oBitmap) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oBitmap
EndFunc


; _WIC_ImagingFactory_CreateBitmapFromMemory



; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateBitmapFromSource
; Description ...: Creates a IWICBitmap from a IWICBitmapSource.
; Syntax ........: _WIC_ImagingFactory_CreateBitmapFromSource($oIImagingFactory, $oBitmapSource[, $iOption = $WICBitmapCacheOnLoad])
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
;                  $oBitmapSource    - An IWICBitmapSource object. The IWICBitmapSource to create the bitmap from.
;                  $iOption          - [optional] A $WICBitmapCreateCacheOption enumeraion.  
; Return values .: Success - An IWICBitmap object.
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
Func _WIC_ImagingFactory_CreateBitmapFromSource($oIImagingFactory, $oBitmapSource, $iOption = $WICBitmapCacheOnLoad)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)
	If Not IsObj($oBitmapSource) Then Return SetError($WICERR_NOOBJ, 1, False)

	Local $pBitmap
	Local $iHResult = $oIImagingFactory.CreateBitmapFromSource($oBitmapSource, $iOption, $pBitmap)
	If $iHResult Or Not $pBitmap Then Return SetError($iHResult, 2, False)

	Local $oBitmap = ObjCreateInterface($pBitmap, $sIID_IWICBitmap, $tagIWICBitmap)
	If Not IsObj($oBitmap) Then Return SetError($WICERR_OBJFAIL, 3, False)
	Return $oBitmap
EndFunc



; _WIC_ImagingFactory_CreateBitmapFromSourceRect
; _WIC_ImagingFactory_CreateBitmapScaler
; _WIC_ImagingFactory_CreateColorContext
; _WIC_ImagingFactory_CreateColorTransformer
; _WIC_ImagingFactory_CreateComponentEnumerator
; _WIC_ImagingFactory_CreateComponentInfo
; _WIC_ImagingFactory_CreateDecoder
; _WIC_ImagingFactory_CreateDecoderFromFileHandle

; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateDecoderFromFilename
; Description ...: Creates a new instance of the IWICBitmapDecoder class based on the given file.
; Syntax ........: _WIC_ImagingFactory_CreateDecoderFromFilename($oIImagingFactory, $sFilename[, $tGuidVendor = Null[, $iDwDesiredAccess = $WIC_GENERIC_READ[, $iMetadataOptions = $WICDecodeMetadataCacheOnLoad]]])
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
;                  $sFilename        - A string that specifies the name of an object to create or open.
;                  $tGuidVendor      - [optional] The GUID for the preferred decoder vendor. Use NULL if no preferred vendor.
;                  $iDwDesiredAccess - [optional] For more information, see Generic Access Rights.
;                  $iMetadataOptions - [optional] A $WICDecodeOptions enumeraion. The WICDecodeOptions to use when creating the decoder.
; Return values .: Success - An IWICBitmapDecoder object.
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
Func _WIC_ImagingFactory_CreateDecoderFromFilename($oIImagingFactory, $sFilename, $tGuidVendor = Null, $iDwDesiredAccess = $WIC_GENERIC_READ, $iMetadataOptions = $WICDecodeMetadataCacheOnLoad)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pDecoder
	Local $iHResult = $oIImagingFactory.CreateDecoderFromFilename($sFilename, $tGuidVendor, $iDwDesiredAccess, $iMetadataOptions, $pDecoder)
	If $iHResult Or Not $pDecoder Then Return SetError($iHResult, 1, False)

	Local $oDecoder = ObjCreateInterface($pDecoder, $sIID_IWICBitmapDecoder, $tagIWICBitmapDecoder)
	If Not IsObj($oDecoder) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oDecoder
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateDecoderFromStream
; Description ...: Creates a new instance of the IWICBitmapDecoder class based on the given IStream.
; Syntax ........: _WIC_ImagingFactory_CreateDecoderFromStream($oIImagingFactory, $oStream[, $tGuidVendor = Null[, $iMetadataOptions = $WICDecodeMetadataCacheOnLoad]])
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
;                  $oStream          - An IStream object. The stream to create the decoder from.
;                  $tGuidVendor      - [optional] The GUID for the preferred decoder vendor. Use NULL if no preferred vendor.
;                  $iMetadataOptions - [optional] A $WICDecodeOptions enumeraion. The WICDecodeOptions to use when creating the decoder.
; Return values .: Success - An IWICBitmapDecoder object.
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
Func _WIC_ImagingFactory_CreateDecoderFromStream($oIImagingFactory, $oStream, $tGuidVendor = Null, $iMetadataOptions = $WICDecodeMetadataCacheOnLoad)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)
	If Not IsObj($oStream) Then Return SetError($WICERR_NOOBJ, 1, False)

	Local $pDecoder
	Local $iHResult = $oIImagingFactory.CreateDecoderFromStream($oStream, $tGuidVendor, $iMetadataOptions, $pDecoder)
	If $iHResult Or Not $pDecoder Then Return SetError($iHResult, 2, False)

	Local $oDecoder = ObjCreateInterface($pDecoder, $sIID_IWICBitmapDecoder, $tagIWICBitmapDecoder)
	If Not IsObj($oDecoder) Then Return SetError($WICERR_OBJFAIL, 3, False)
	Return $oDecoder
EndFunc



; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateEncoder
; Description ...: Creates a new instance of the IWICBitmapEncoder class.
; Syntax ........: _WIC_ImagingFactory_CreateEncoder($oIImagingFactory[, $sGuidContainerFormat = $sGUID_ContainerFormatBmp[, $tGuidVendor = Null]])
; Parameters ....: $oIImagingFactory     - This IWICImagingFactory object
;                  $sGuidContainerFormat - [optional]  
;                  $tGuidVendor          - [optional]  
; Return values .: Success - An IWICBitmapEncoder object.
;                  Failure - False
;                              | @error contains a non zero hresult value specifying the error code
;                              | @extended contains an index of the error position within the function
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......: Other values may be available for both "guidContainerFormat" and "pguidVendor" depending on the installed WIC-enabled encoders.
;                  The values listed are those that are natively supported by the operating system.
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _WIC_ImagingFactory_CreateEncoder($oIImagingFactory, $sGuidContainerFormat = $sGUID_ContainerFormatBmp, $tGuidVendor = Null)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)
	Local $tREFGUID = _WinAPI_GUIDFromString($sGuidContainerFormat)
	If @error Or Not IsDllStruct($tREFGUID) Then Return SetError($WICERR_PARAM, 1, False)

	Local $pEncoder
	Local $iHResult = $oIImagingFactory.CreateEncoder($tREFGUID, $tGuidVendor, $pEncoder)
	If $iHResult Or Not $pEncoder Then Return SetError($iHResult, 2, False)

	Local $oEncoder = ObjCreateInterface($pEncoder, $sIID_IWICBitmapEncoder, $tagIWICBitmapEncoder)
	If Not IsObj($oEncoder) Then Return SetError($WICERR_OBJFAIL, 3, False)
	Return $oEncoder
EndFunc



; _WIC_ImagingFactory_CreateFastMetadataEncoderFromDecoder
; _WIC_ImagingFactory_CreateFastMetadataEncoderFromFrameDecode

; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateFormatConverter
; Description ...: Creates a new instance of the IWICFormatConverter class.
; Syntax ........: _WIC_ImagingFactory_CreateFormatConverter($oIImagingFactory)
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
; Return values .: Success - An IWICFormatConverter object.
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
Func _WIC_ImagingFactory_CreateFormatConverter($oIImagingFactory)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pFormatConverter
	Local $iHResult = $oIImagingFactory.CreateFormatConverter($pFormatConverter)
	If $iHResult Or Not $pFormatConverter Then Return SetError($iHResult, 1, False)

	Local $oFormatConverter = ObjCreateInterface($pFormatConverter, $sIID_IWICFormatConverter, $tagIWICFormatConverter)
	If Not IsObj($oFormatConverter) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oFormatConverter
EndFunc

; _WIC_ImagingFactory_CreatePalette
; _WIC_ImagingFactory_CreateQueryWriter
; _WIC_ImagingFactory_CreateQueryWriterFromReader


; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_ImagingFactory_CreateStream
; Description ...: Creates a new instance of the IWICStream class.
; Syntax ........: _WIC_ImagingFactory_CreateStream($oIImagingFactory)
; Parameters ....: $oIImagingFactory - This IWICImagingFactory object
; Return values .: Success - An IWICStream object.
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
Func _WIC_ImagingFactory_CreateStream($oIImagingFactory)
	If Not IsObj($oIImagingFactory) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $pWICStream
	Local $iHResult = $oIImagingFactory.CreateStream($pWICStream)
	If $iHResult Or Not $pWICStream Then Return SetError($iHResult, 1, False)

	Local $oWICStream = ObjCreateInterface($pWICStream, $sIID_IWICStream, $tagIWICStream)
	If Not IsObj($oWICStream) Then Return SetError($WICERR_OBJFAIL, 2, False)
	Return $oWICStream
EndFunc





;#######################################################################################################################################################################
;# IWICMetadataBlockReader
;#######################################################################################################################################################################
#cs    IWICMetadataBlockReader
	Method ...: GetContainerFormat (ptr*)
	Info .....:     Retrieves the container format of the decoder.
	Param ....:         PguidContainerFormat  <GUID>  The container format of the decoder. The native container format GUIDs are listed in WIC GUIDs and CLSIDs.

	Method ...: GetCount (uint*)
	Info .....:     Retrieves the number of top level metadata blocks.
	Param ....:         PcCount  <UINT>  When this method returns, contains the number of top level metadata blocks.

	Method ...: GetEnumerator (ptr*)
	Info .....:     Retrieves an enumeration of IWICMetadataReader objects representing each of the top level metadata blocks.
	Param ....:         PpIEnumMetadata  <IEnumUnknown>  When this method returns, contains a pointer to an enumeration of IWICMetadataReader objects.

	Method ...: GetReaderByIndex (uint;ptr*)
	Info .....:     Retrieves an IWICMetadataReader for a specified top level metadata block.
	Param ....:         NIndex             <UINT>                The index of the desired top level metadata block to retrieve.
	Param ....:         PpIMetadataReader  <IWICMetadataReader>  When this method returns, contains a pointer to the IWICMetadataReader specified by "nIndex".

#ce
; _WIC_MetadataBlockReader_GetContainerFormat
; _WIC_MetadataBlockReader_GetCount
; _WIC_MetadataBlockReader_GetEnumerator
; _WIC_MetadataBlockReader_GetReaderByIndex





;#######################################################################################################################################################################
;# IWICMetadataBlockWriter
;#######################################################################################################################################################################
#cs    IWICMetadataBlockWriter
	Method ...: AddWriter (struct*)
	Info .....:     Adds a top-level metadata block by adding a IWICMetadataWriter for it.
	Param ....:         PIMetadataWriter  <IWICMetadataWriter>  A pointer to the metadata writer to add to the image.

	Method ...: GetWriterByIndex (uint;ptr*)
	Info .....:     Retrieves the IWICMetadataWriter that resides at the specified index.
	Param ....:         NIndex             <UINT>                The index of the metadata writer to be retrieved. This index is zero-based.
	Param ....:         PpIMetadataWriter  <IWICMetadataWriter>  When this method returns, contains a pointer to the metadata writer that resides at the specified index.

	Method ...: InitializeFromBlockReader (struct*)
	Info .....:     Initializes an IWICMetadataBlockWriter from the given IWICMetadataBlockReader. This will prepopulate the metadata block writer with all the metadata in the metadata block reader.
	Param ....:         PIMDBlockReader  <IWICMetadataBlockReader>  Pointer to the IWICMetadataBlockReader used to initialize the block writer.

	Method ...: RemoveWriterByIndex (uint)
	Info .....:     Removes the metadata writer from the specified index location.
	Param ....:         NIndex  <UINT>  The index of the metadata writer to remove.

	Method ...: SetWriterByIndex (uint;struct*)
	Info .....:     Replaces the metadata writer at the specified index location.
	Param ....:         NIndex            <UINT>                The index position at which to place the metadata writer. This index is zero-based.
	Param ....:         PIMetadataWriter  <IWICMetadataWriter>  A pointer to the IWICMetadataWriter.

#ce
; _WIC_MetadataBlockWriter_AddWriter
; _WIC_MetadataBlockWriter_GetWriterByIndex
; _WIC_MetadataBlockWriter_InitializeFromBlockReader
; _WIC_MetadataBlockWriter_RemoveWriterByIndex
; _WIC_MetadataBlockWriter_SetWriterByIndex





;#######################################################################################################################################################################
;# IWICMetadataHandlerInfo
;#######################################################################################################################################################################
#cs    IWICMetadataHandlerInfo
	Method ...: DoesRequireFixedSize (bool*)
	Info .....:     Determines if the metadata handler requires a fixed size.
	Param ....:         PfFixedSize  <BOOL>  Pointer that receives TRUE if a fixed size is required; otherwise, FALSE.

	Method ...: DoesRequireFullStream (bool*)
	Info .....:     Determines if the handler requires a full stream.
	Param ....:         PfRequiresFullStream  <BOOL>  Pointer that receives TRUE if a full stream is required; otherwise, FALSE.

	Method ...: DoesSupportPadding (bool*)
	Info .....:     Determines if the metadata handler supports padding.
	Param ....:         PfSupportsPadding  <BOOL>  Pointer that receives TRUE if padding is supported; otherwise, FALSE.

	Method ...: GetContainerFormats (uint;struct*;uint*)
	Info .....:     Retrieves the container formats supported by the metadata handler.
	Param ....:         CContainerFormats      <UINT>  The size of the "pguidContainerFormats" array.
	Param ....:         PguidContainerFormats  <GUID>  Pointer to an array that receives the container formats supported by the metadata handler.
	Param ....:         PcchActual             <UINT>  To obtain the number of supported container formats, pass "NULL" to "pguidContainerFormats".

	Method ...: GetDeviceManufacturer (uint;wstr;uint*)
	Info .....:     Retrieves the device manufacturer of the metadata handler.
	Param ....:         CchDeviceManufacturer  <UINT>   The size of the "wzDeviceManufacturer" buffer.
	Param ....:         WzDeviceManufacturer   <WCHAR>  Pointer to the buffer that receives the name of the device manufacturer.
	Param ....:         PcchActual             <UINT>   The actual string buffer length needed to obtain the entire name of the device manufacturer.

	Method ...: GetDeviceModels (uint;wstr;uint*)
	Info .....:     Retrieves the device models that support the metadata handler.
	Param ....:         CchDeviceModels  <UINT>   The length of the "wzDeviceModels" buffer.
	Param ....:         WzDeviceModels   <WCHAR>  Pointer that receives the device models supported by the metadata handler.
	Param ....:         PcchActual       <UINT>   The actual length needed to retrieve the device models.

	Method ...: GetMetadataFormat (ptr*)
	Info .....:     Retrieves the metadata format of the metadata handler.
	Param ....:         PguidMetadataFormat  <GUID>  Pointer that receives the metadata format GUID.

#ce
; _WIC_MetadataHandlerInfo_DoesRequireFixedSize
; _WIC_MetadataHandlerInfo_DoesRequireFullStream
; _WIC_MetadataHandlerInfo_DoesSupportPadding
; _WIC_MetadataHandlerInfo_GetContainerFormats
; _WIC_MetadataHandlerInfo_GetDeviceManufacturer
; _WIC_MetadataHandlerInfo_GetDeviceModels
; _WIC_MetadataHandlerInfo_GetMetadataFormat





;#######################################################################################################################################################################
;# IWICMetadataQueryReader
;#######################################################################################################################################################################
#cs    IWICMetadataQueryReader
	Method ...: GetContainerFormat (ptr*)
	Info .....:     Gets the metadata query readers container format.
	Param ....:         PguidContainerFormat  <GUID>  Pointer that receives the cointainer format GUID.

	Method ...: GetEnumerator (ptr*)
	Info .....:     Gets an enumerator of all metadata items at the current relative location within the metadata hierarchy.
	Param ....:         PpIEnumString  <IEnumString>  A pointer to a variable that receives a pointer to the IEnumString interface for the enumerator that contains query strings that can be used in the current IWICMetadataQueryReader.

	Method ...: GetLocation (uint;wstr;uint*)
	Info .....:     Retrieves the current path relative to the root metadata block.
	Param ....:         CchMaxLength      <UINT>   The length of the "wzNamespace" buffer.
	Param ....:         WzNamespace       <WCHAR>  Pointer that receives the current namespace location.
	Param ....:         PcchActualLength  <UINT>   The actual buffer length that was needed to retrieve the current namespace location.

	Method ...: GetMetadataByName (wstr;struct*)
	Info .....:     Retrieves the metadata block or item identified by a metadata query expression.
	Param ....:         WzName     <LPCWSTR>      The query expression to the requested metadata block or item.
	Param ....:         PvarValue  <PROPVARIANT>  When this method returns, contains the metadata block or item requested.

#ce
; _WIC_MetadataQueryReader_GetContainerFormat
; _WIC_MetadataQueryReader_GetEnumerator
; _WIC_MetadataQueryReader_GetLocation


; #FUNCTION# ====================================================================================================================
; Name ..........: _WIC_MetadataQueryReader_GetMetadataByName
; Description ...: Retrieves the metadata block or item identified by a metadata query expression.
; Syntax ........: _WIC_MetadataQueryReader_GetMetadataByName($oIMetadataQueryReader, $sName)
; Parameters ....: $oIMetadataQueryReader - This IWICMetadataQueryReader object
;                  $sName                 - The query expression to the requested metadata block or item.
; Return values .: Success - A Structure: "ushort VT; uint Cnt; <Type> Data[Cnt]"
;                                   | first Element <VT> = PropVariant Type
;                                   | second Element <Cnt> = Number of Values in StructArray
;                                   | third Element <Data> = Array of Values
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
Func _WIC_MetadataQueryReader_GetMetadataByName($oQueryReader, $sName)
	If Not IsObj($oQueryReader) Then Return SetError($WICERR_NOOBJ, 0, False)

	Local $tPropVariant = DllStructCreate("struct; ushort VT; ushort R1; ushort R2; ushort R3; uint64 Data; endstruct;")
	Local $pData = DllStructGetPtr($tPropVariant, "Data")

	Local $iHResult = $oQueryReader.GetMetadataByName($sName, $tPropVariant)
	If $iHResult Then Return SetError($iHResult, 1, False)

	Local $tVariant
	Switch $tPropVariant.VT
		Case 17 ;$VT_UI1 = 1-byte unsigned integer
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, 1, "byte", $pData)
		Case 18 ;$VT_UI2 = 2-byte unsigned integer
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, 1, "ushort", $pData)
		Case 19 ;$VT_UI4 = 4-byte unsigned integer
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, 1, "uint", $pData)
		Case 21 ;$VT_UI8 = 8-byte unsigned integer
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, 1, "uint64", $pData)
		Case 4113 ;$VT_UI1|$VT_VECTOR = Array Of 1-byte unsigned integer
			$tVariant = DllStructCreate("uint iElm; ptr pElm;", $pData)
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, $tVariant.iElm, "byte", $tVariant.pElm)
		Case 4114 ;$VT_UI2|$VT_VECTOR = Array Of 2-byte unsigned integer
			$tVariant = DllStructCreate("uint iElm; ptr pElm;", $pData)
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, $tVariant.iElm, "ushort", $tVariant.pElm)
		Case 4115 ;$VT_UI4|$VT_VECTOR = Array Of 4-byte unsigned integer
			$tVariant = DllStructCreate("uint iElm; ptr pElm;", $pData)
			Return __WIC_MDQR_GMDBN_Ret($tPropVariant.VT, $tVariant.iElm, "uint", $tVariant.pElm)

		Case Else
			SetError($WICERR_PARAM, 2, False)
	EndSwitch
EndFunc

Func __WIC_MDQR_GMDBN_Ret($iVT, $iCnt, $sType, $pPtr)
	Local $tReturn = DllStructCreate("struct; ushort VT; uint Cnt; " & $sType & " Data[" & $iCnt & "]; endstruct;")
	Local $tData = DllStructCreate($sType & "[" & $iCnt & "];", $pPtr)
	$tReturn.VT = $iVT
	$tReturn.Cnt = $iCnt
	DllCall("kernel32.dll", "none", "RtlMoveMemory", "struct*", DllStructGetPtr($tReturn, "Data"), "struct*", $pPtr, "ulong_ptr", DllStructGetSize($tData))
	Return $tReturn
EndFunc



;#######################################################################################################################################################################
;# IWICMetadataQueryWriter
;#######################################################################################################################################################################
#cs    IWICMetadataQueryWriter
	Method ...: RemoveMetadataByName (wstr)
	Info .....:     Removes a metadata item from a specific location using a metadata query expression.
	Param ....:         WzName  <LPCWSTR>  The name of the metadata item to remove.

	Method ...: SetMetadataByName (wstr;struct*)
	Info .....:     Sets a metadata item to a specific location.
	Param ....:         WzName     <LPCWSTR>      The name of the metadata item.
	Param ....:         PvarValue  <PROPVARIANT>  The metadata to set.

#ce
; _WIC_MetadataQueryWriter_RemoveMetadataByName
; _WIC_MetadataQueryWriter_SetMetadataByName





;#######################################################################################################################################################################
;# IWICMetadataReader
;#######################################################################################################################################################################
#cs    IWICMetadataReader
	Method ...: GetCount (uint*)
	Info .....:     Gets the number of metadata items within the reader.
	Param ....:         PcCount  <UINT>  Pointer that receives the number of metadata items within the reader.

	Method ...: GetEnumerator (ptr*)
	Info .....:     Gets an enumerator of all the metadata items.
	Param ....:         PpIEnumMetadata  <IWICEnumMetadataItem>  Pointer that receives a pointer to the metadata enumerator.

	Method ...: GetMetadataFormat (ptr*)
	Info .....:     Gets the metadata format associated with the reader.
	Param ....:         PguidMetadataFormat  <GUID>  Pointer that receives the metadata format GUID.

	Method ...: GetMetadataHandlerInfo (ptr*)
	Info .....:     Gets the metadata handler info associated with the reader.
	Param ....:         PpIHandler  <IWICMetadataHandlerInfo>  Pointer that receives a pointer to the IWICMetadataHandlerInfo.

	Method ...: GetValue (uint;variant*;variant*;variant*)
	Info .....:     Gets the metadata item value.
	Param ....:         PvarSchema  <PROPVARIANT>  Pointer to the metadata item's schema property.
	Param ....:         PvarId      <PROPVARIANT>  Pointer to the metadata item's id.
	Param ....:         PvarValue   <PROPVARIANT>  Pointer that receives the metadata value.

	Method ...: GetValueByIndex (uint;variant*;variant*;variant*)
	Info .....:     Gets the metadata item at the given index.
	Param ....:         NIndex      <UINT>         The index of the metadata item to retrieve.
	Param ....:         PvarSchema  <PROPVARIANT>  Pointer that receives the schema property.
	Param ....:         PvarId      <PROPVARIANT>  Pointer that receives the id property.
	Param ....:         PvarValue   <PROPVARIANT>  Pointer that receives the metadata value.

#ce
; _WIC_MetadataReader_GetCount
; _WIC_MetadataReader_GetEnumerator
; _WIC_MetadataReader_GetMetadataFormat
; _WIC_MetadataReader_GetMetadataHandlerInfo
; _WIC_MetadataReader_GetValue
; _WIC_MetadataReader_GetValueByIndex





;#######################################################################################################################################################################
;# IWICMetadataReaderInfo
;#######################################################################################################################################################################
#cs    IWICMetadataReaderInfo
	Method ...: CreateInstance (ptr*)
	Info .....:     Creates an instance of an IWICMetadataReader.
	Param ....:         PpIReader  <IWICMetadataReader>  Pointer that receives a pointer to a metadata reader.

	Method ...: GetPatterns (struct*;uint;struct*;uint*;uint*)
	Info .....:     Gets the metadata patterns associated with the metadata reader.
	Param ....:         GuidContainerFormat  <REFGUID>             The cointainer format GUID.
	Param ....:         CbSize               <UINT>                The size, in bytes, of the "pPattern" buffer.
	Param ....:         PPattern             <WICMetadataPattern>  Pointer that receives the metadata patterns.
	Param ....:         PcCount              <UINT>                Pointer that receives the number of metadata patterns.
	Param ....:         PcbActual            <UINT>                Pointer that receives the size, in bytes, needed to obtain the metadata patterns.

	Method ...: MatchesPattern (struct*;struct*;bool*)
	Info .....:     Determines if a stream contains a metadata item pattern.
	Param ....:         GuidContainerFormat  <REFGUID>  The container format of the metadata item.
	Param ....:         PIStream             <IStream>  The stream to search for the metadata pattern.
	Param ....:         PfMatches            <BOOL>     Pointer that receives "TRUE" if the stream contains the pattern; otherwise, "FALSE".

#ce
; _WIC_MetadataReaderInfo_CreateInstance
; _WIC_MetadataReaderInfo_GetPatterns
; _WIC_MetadataReaderInfo_MatchesPattern





;#######################################################################################################################################################################
;# IWICMetadataWriter
;#######################################################################################################################################################################
#cs    IWICMetadataWriter
	Method ...: RemoveValue (variant*;variant*)
	Info .....:     Removes the metadata item that matches the given parameters.
	Param ....:         PvarSchema  <PROPVARIANT>  Pointer to the metadata schema property.
	Param ....:         PvarId      <PROPVARIANT>  Pointer to the metadata id property.

	Method ...: RemoveValueByIndex (uint)
	Info .....:     Removes the metadata item at the specified index.
	Param ....:         NIndex  <UINT>  The index of the metadata item to remove.

	Method ...: SetValue (variant*;variant*;variant*)
	Info .....:     Sets the given metadata item.
	Param ....:         PvarSchema  <PROPVARIANT>  Pointer to the schema property of the metadata item.
	Param ....:         PvarId      <PROPVARIANT>  Pointer to the id property of the metadata item.
	Param ....:         PvarValue   <PROPVARIANT>  Pointer to the metadata value to set

	Method ...: SetValueByIndex (uint;variant*;variant*;variant*)
	Info .....:     Sets the metadata item to the specified index.
	Param ....:         NIndex      <UINT>         The index to place the metadata item.
	Param ....:         PvarSchema  <PROPVARIANT>  Pointer to the schema property of the metadata item.
	Param ....:         PvarId      <PROPVARIANT>  Pointer to the id property of the metadata item.
	Param ....:         PvarValue   <PROPVARIANT>  Pointer to the metadata value to set at the given index.

#ce
; _WIC_MetadataWriter_RemoveValue
; _WIC_MetadataWriter_RemoveValueByIndex
; _WIC_MetadataWriter_SetValue
; _WIC_MetadataWriter_SetValueByIndex





;#######################################################################################################################################################################
;# IWICMetadataWriterInfo
;#######################################################################################################################################################################
#cs    IWICMetadataWriterInfo
	Method ...: CreateInstance (ptr*)
	Info .....:     Creates an instance of an IWICMetadataWriter.
	Param ....:         PpIWriter  <IWICMetadataWriter>  Pointer that receives a pointer to a metadata writer.

	Method ...: GetHeader (struct*;uint;struct*;uint*)
	Info .....:     Gets the metadata header for the metadata writer.
	Param ....:         GuidContainerFormat  <REFGUID>            The format container GUID to obtain the header for.
	Param ....:         CbSize               <UINT>               The size of the "pHeader" buffer.
	Param ....:         PHeader              <WICMetadataHeader>  Pointer that receives the WICMetadataHeader.
	Param ....:         PcbActual            <UINT>               The actual size of the header.

#ce
; _WIC_MetadataWriterInfo_CreateInstance
; _WIC_MetadataWriterInfo_GetHeader





;#######################################################################################################################################################################
;# IWICPalette
;#######################################################################################################################################################################
#cs    IWICPalette
	Method ...: GetColorCount (uint*)
	Info .....:     Retrieves the number of colors in the color table.
	Param ....:         PcCount  <UINT>  Pointer that receives the number of colors in the color table.

	Method ...: GetColors (uint;struct*;uint*)
	Info .....:     Fills out the supplied color array with the colors from the internal color table. The color array should be sized according to the return results from GetColorCount.
	Param ....:         ColorCount      <UINT>      The size of the "pColors" array.
	Param ....:         PColors         <WICColor>  Pointer that receives the colors of the palette.
	Param ....:         PcActualColors  <UINT>      The actual size needed to obtain the palette colors.

	Method ...: GetType (ptr*)
	Info .....:     Retrieves the WICBitmapPaletteType that describes the palette.
	Param ....:         PePaletteType  <WICBitmapPaletteType>  Pointer that receives the palette type of the bimtap.

	Method ...: HasAlpha (bool*)
	Info .....:     Indicates whether the palette contains an entry that is non-opaque (that is, an entry with an alpha that is less than 1).
	Param ....:         PfHasAlpha  <BOOL>  Pointer that receives "TRUE" if the palette contains a transparent color; otherwise, "FALSE".

	Method ...: InitializeCustom (struct*;uint)
	Info .....:     Initializes a palette to the custom color entries provided.
	Param ....:         PColors     <WICColor>  Pointer to the color array.
	Param ....:         ColorCount  <UINT>      The number of colors in "pColors".

	Method ...: InitializeFromBitmap (struct*;uint;bool)
	Info .....:     Initializes a palette using a computed optimized values based on the reference bitmap.
	Param ....:         PISurface             <IWICBitmapSource>  Pointer to the source bitmap.
	Param ....:         ColorCount            <UINT>              The number of colors to initialize the palette with.
	Param ....:         FAddTransparentColor  <BOOL>              A value to indicate whether to add a transparent color.

	Method ...: InitializeFromPalette (struct*)
	Info .....:     Initialize the palette based on a given palette.
	Param ....:         PIMILPalette  <IWICPalette>  Pointer to the source palette.

	Method ...: InitializePredefined (struct*;bool)
	Info .....:     Initializes the palette to one of the pre-defined palettes specified by WICBitmapPaletteType and optionally adds a transparent color.
	Param ....:         EPaletteType          <WICBitmapPaletteType>  The desired pre-defined palette type.
	Param ....:         FAddTransparentColor  <BOOL>                  The optional transparent color to add to the palette. If no transparent color is needed, use 0. When initializing to a grayscale or black and white palette, set this parameter to FALSE.

	Method ...: IsBlackWhite (bool*)
	Info .....:     Retrieves a value that describes whether the palette is black and white.
	Param ....:         PfIsBlackWhite  <BOOL>  A pointer to a variable that receives a boolean value that indicates whether the palette is black and white. TRUE indicates that the palette is black and white; otherwise, FALSE.

	Method ...: IsGrayscale (bool*)
	Info .....:     Retrieves a value that describes whether a palette is grayscale.
	Param ....:         PfIsGrayscale  <BOOL>  A pointer to a variable that receives a boolean value that indicates whether the palette is grayscale. TRUE indicates that the palette is grayscale; otherwise FALSE.

#ce
; _WIC_Palette_GetColorCount
; _WIC_Palette_GetColors
; _WIC_Palette_GetType
; _WIC_Palette_HasAlpha
; _WIC_Palette_InitializeCustom
; _WIC_Palette_InitializeFromBitmap
; _WIC_Palette_InitializeFromPalette
; _WIC_Palette_InitializePredefined
; _WIC_Palette_IsBlackWhite
; _WIC_Palette_IsGrayscale





;#######################################################################################################################################################################
;# IWICPersistStream
;#######################################################################################################################################################################
#cs    IWICPersistStream
	Method ...: LoadEx (struct*;struct*;uint)
	Info .....:     Loads data from an input stream using the given parameters.
	Param ....:         PIStream              <IStream>  Pointer to the input stream.
	Param ....:         PguidPreferredVendor  <GUID>     Pointer to the GUID of the preferred vendor .
	Param ....:         DwPersistOptions      <DWORD>    The WICPersistOptions used to load the stream.

	Method ...: SaveEx (struct*;uint;bool)
	Info .....:     Saves the IWICPersistStream to the given input IStream using the given parameters.
	Param ....:         PIStream          <IStream>  The stream to save to.
	Param ....:         DwPersistOptions  <DWORD>    The WICPersistOptions to use when saving.
	Param ....:         FClearDirty       <BOOL>     Indicates whether the "dirty" value will be cleared from all metadata after saving.

#ce
; _WIC_PersistStream_LoadEx
; _WIC_PersistStream_SaveEx





;#######################################################################################################################################################################
;# IWICPixelFormatInfo
;#######################################################################################################################################################################
#cs    IWICPixelFormatInfo
	Method ...: GetBitsPerPixel (uint*)
	Info .....:     Gets the bits per pixel (BPP) of the pixel format.
	Param ....:         PuiBitsPerPixel  <UINT>  Pointer that receives the BPP of the pixel format.

	Method ...: GetChannelCount (uint*)
	Info .....:     Gets the number of channels the pixel format contains.
	Param ....:         PuiChannelCount  <UINT>  Pointer that receives the channel count.

	Method ...: GetChannelMask (uint;uint;struct*;uint*)
	Info .....:     Gets the pixel format's channel mask.
	Param ....:         UiChannelIndex  <UINT>  The index to the channel mask to retrieve.
	Param ....:         CbMaskBuffer    <UINT>  The size of the "pbMaskBuffer" buffer.
	Param ....:         PbMaskBuffer    <BYTE>  Pointer to the mask buffer.
	Param ....:         PcbActual       <UINT>  The actual buffer size needed to obtain the channel mask.

	Method ...: GetColorContext (ptr*)
	Info .....:     Gets the pixel format's IWICColorContext.
	Param ....:         PpIColorContext  <IWICColorContext>  Pointer that receives the pixel format's color context.

	Method ...: GetFormatGUID (ptr*)
	Info .....:     Gets the pixel format GUID.
	Param ....:         PFormat  <GUID>  Pointer that receives the pixel format GUID.

#ce
; _WIC_PixelFormatInfo_GetBitsPerPixel
; _WIC_PixelFormatInfo_GetChannelCount
; _WIC_PixelFormatInfo_GetChannelMask
; _WIC_PixelFormatInfo_GetColorContext
; _WIC_PixelFormatInfo_GetFormatGUID





;#######################################################################################################################################################################
;# IWICPixelFormatInfo2
;#######################################################################################################################################################################
#cs    IWICPixelFormatInfo2
	Method ...: GetNumericRepresentation (uint*)
	Info .....:     Type: <strong>WICPixelFormatNumericRepresentation* </strong>
	Param ....:         PNumericRepresentation  <WICPixelFormatNumericRepresentation>  Returns the WICPixelFormatNumericRepresentation of the pixel format.

	Method ...: SupportsTransparency (bool*)
	Info .....:     Returns whether the format supports transparent pixels.
	Param ....:         PfSupportsTransparency  <BOOL>  Returns TRUE if the pixel format supports transparency; otherwise, FALSE.

#ce
; _WIC_PixelFormatInfo2_GetNumericRepresentation
; _WIC_PixelFormatInfo2_SupportsTransparency





;#######################################################################################################################################################################
;# IWICPixelFormatInfo
;#######################################################################################################################################################################
#cs    IWICPixelFormatInfo
	Method ...: GetBitsPerPixel (uint*)
	Info .....:     Gets the bits per pixel (BPP) of the pixel format.
	Param ....:         PuiBitsPerPixel  <UINT>  Pointer that receives the BPP of the pixel format.

	Method ...: GetChannelCount (uint*)
	Info .....:     Gets the number of channels the pixel format contains.
	Param ....:         PuiChannelCount  <UINT>  Pointer that receives the channel count.

	Method ...: GetChannelMask (uint;uint;struct*;uint*)
	Info .....:     Gets the pixel format's channel mask.
	Param ....:         UiChannelIndex  <UINT>  The index to the channel mask to retrieve.
	Param ....:         CbMaskBuffer    <UINT>  The size of the "pbMaskBuffer" buffer.
	Param ....:         PbMaskBuffer    <BYTE>  Pointer to the mask buffer.
	Param ....:         PcbActual       <UINT>  The actual buffer size needed to obtain the channel mask.

	Method ...: GetColorContext (ptr*)
	Info .....:     Gets the pixel format's IWICColorContext.
	Param ....:         PpIColorContext  <IWICColorContext>  Pointer that receives the pixel format's color context.

	Method ...: GetFormatGUID (ptr*)
	Info .....:     Gets the pixel format GUID.
	Param ....:         PFormat  <GUID>  Pointer that receives the pixel format GUID.

#ce
; _WIC_PixelFormatInfo_GetBitsPerPixel
; _WIC_PixelFormatInfo_GetChannelCount
; _WIC_PixelFormatInfo_GetChannelMask
; _WIC_PixelFormatInfo_GetColorContext
; _WIC_PixelFormatInfo_GetFormatGUID





;#######################################################################################################################################################################
;# IWICProgressCallback
;#######################################################################################################################################################################
#cs    IWICProgressCallback
	Method ...: Notify (uint;uint;double)
	Info .....:     Notify method is documented only for compliance; its use is not recommended and may be altered or unavailable in the future. Instead, and use RegisterProgressNotification.
	Param ....:         UFrameNum    <ULONG>                 The current frame number.
	Param ....:         Operation    <WICProgressOperation>  The operation on which progress is being reported.
	Param ....:         DblProgress  <double>                The progress value ranging from is 0.0 to 1.0. 0.0 indicates the beginning of the operation. 1.0 indicates the end of the operation.

#ce
; _WIC_ProgressCallback_Notify





;#######################################################################################################################################################################
;# IWICProgressCallback
;#######################################################################################################################################################################
#cs    IWICProgressCallback
	Method ...: Notify (uint;uint;double)
	Info .....:     Notify method is documented only for compliance; its use is not recommended and may be altered or unavailable in the future. Instead, and use RegisterProgressNotification.
	Param ....:         UFrameNum    <ULONG>                 The current frame number.
	Param ....:         Operation    <WICProgressOperation>  The operation on which progress is being reported.
	Param ....:         DblProgress  <double>                The progress value ranging from is 0.0 to 1.0. 0.0 indicates the beginning of the operation. 1.0 indicates the end of the operation.

#ce
; _WIC_ProgressCallback_Notify





;#######################################################################################################################################################################
;# IWICProgressiveLevelControl
;#######################################################################################################################################################################
#cs    IWICProgressiveLevelControl
	Method ...: GetCurrentLevel (uint*)
	Info .....:     Gets the decoder's current progressive level.
	Param ....:         PnLevel  <UINT>  Indicates the current level specified.

	Method ...: GetLevelCount (uint*)
	Info .....:     Gets the number of levels of progressive decoding supported by the CODEC.
	Param ....:         PcLevels  <UINT>  Indicates the number of levels supported by the CODEC.

	Method ...: SetCurrentLevel (uint)
	Info .....:     Specifies the level to retrieve on the next call to CopyPixels.
	Param ....:         NLevel  <UINT>  Specifies which level to return next. If greater than the total number of levels supported, an error will be returned.

#ce
; _WIC_ProgressiveLevelControl_GetCurrentLevel
; _WIC_ProgressiveLevelControl_GetLevelCount
; _WIC_ProgressiveLevelControl_SetCurrentLevel





;#######################################################################################################################################################################
;# IWICStream
;#######################################################################################################################################################################
#cs    IWICStream
	Method ...: InitializeFromFilename (wstr;uint)
	Info .....:     Initializes a stream from a particular file.
	Param ....:         WzFileName       <LPCWSTR>  The file used to initialize the stream.
	Param ....:         DwDesiredAccess  <DWORD>     

	Method ...: InitializeFromIStream (ptr*)
	Info .....:     Initializes a stream from another stream. Access rights are inherited from the underlying stream.
	Param ....:         PIStream  <IStream>  The initialize stream.

	Method ...: InitializeFromIStreamRegion (struct*;uint64;uint64)
	Info .....:     Initializes the stream as a substream of another stream.
	Param ....:         PIStream   <IStream>         Pointer to the input stream.
	Param ....:         UlOffset   <ULARGE_INTEGER>  The stream offset used to create the new stream.
	Param ....:         UlMaxSize  <ULARGE_INTEGER>  The maximum size of the stream.

	Method ...: InitializeFromMemory (struct*;uint)
	Info .....:     Initializes a stream to treat a block of memory as a stream. The stream cannot grow beyond the buffer size.
	Param ....:         PbBuffer      <BYTE>   Pointer to the buffer used to initialize the stream.
	Param ....:         CbBufferSize  <DWORD>  The size of buffer.

#ce
; _WIC_Stream_InitializeFromFilename
; _WIC_Stream_InitializeFromIStream
; _WIC_Stream_InitializeFromIStreamRegion
; _WIC_Stream_InitializeFromMemory





;#######################################################################################################################################################################
;# IWICStreamProvider
;#######################################################################################################################################################################
#cs    IWICStreamProvider
	Method ...: GetPersistOptions (uint*)
	Info .....:     Gets the persist options used when initializing the component with a stream.
	Param ....:         PdwPersistOptions  <DWORD>  Pointer that receives the persist options used when initializing the component with a stream. If none were provided, WICPersistOptionDefault is returned.

	Method ...: GetPreferredVendorGUID (ptr*)
	Info .....:     Gets the preferred vendor GUID.
	Param ....:         PguidPreferredVendor  <GUID>  Pointer that receives the preferred vendor GUID.

	Method ...: GetStream (ptr*)
	Info .....:     Gets the stream held by the component.
	Param ....:         PpIStream  <IStream>  Pointer that receives a pointer to the stream held by the component.

	Method ...: RefreshStream ()
	Info .....:     Informs the component that the content of the stream it's holding onto may have changed. The component should respond by dirtying any cached information from the stream.
	Param ....:         This method has no parameters.

#ce
; _WIC_StreamProvider_GetPersistOptions
; _WIC_StreamProvider_GetPreferredVendorGUID
; _WIC_StreamProvider_GetStream
; _WIC_StreamProvider_RefreshStream






Func _WIC_RECT($iX = 0, $iY = 0, $iWidth = 0, $iHeight = 0)
	Local $tStruct = DllStructCreate($tagWICRect)
	$tStruct.X = $iX
	$tStruct.Y = $iY
	$tStruct.Width = $iWidth
	$tStruct.Height = $iHeight
	Return $tStruct
EndFunc   ;==>_D2D1_RECT_U