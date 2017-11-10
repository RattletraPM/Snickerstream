#include-once




Global Const $WICERR_NOHWND = 0x80070006 ;Handle that is not valid
Global Const $WICERR_NOPTR = 0x80004003 ;Pointer that is not valid
Global Const $WICERR_NOOBJ = 0x800710D8 ;The object identifier does not represent a valid object
Global Const $WICERR_PARAM = 0x80070057 ;One or more arguments are not valid
Global Const $WICERR_UFAIL = 0x8000FFFF ;Unexpected failure
Global Const $WICERR_OBJFAIL = 0x80080001 ;Attempt to create a class object failed.
Global Const $WICERR_OK = 0x0


;############################################################################################################
;# WIC_Enumerations
;############################################################################################################

Global Const $WIC_GENERIC_READ  = 0x80000000
Global Const $WIC_GENERIC_WRITE = 0x40000000

;# WICDecodeOptions
Global Const $WICDecodeMetadataCacheOnDemand     = 0x0
Global Const $WICDecodeMetadataCacheOnLoad       = 0x1
Global Const $WICMETADATACACHEOPTION_FORCE_DWORD = 0x7FFFFFFF

;# WICBitmapCreateCacheOption
Global Const $WICBitmapNoCache                       = 0x0
Global Const $WICBitmapCacheOnDemand                 = 0x1
Global Const $WICBitmapCacheOnLoad                   = 0x2
Global Const $WICBITMAPCREATECACHEOPTION_FORCE_DWORD = 0x7FFFFFFF

;# WICBitmapAlphaChannelOption
Global Const $WICBitmapUseAlpha                        = 0x0
Global Const $WICBitmapUsePremultipliedAlpha           = 0x1
Global Const $WICBitmapIgnoreAlpha                     = 0x2
Global Const $WICBITMAPALPHACHANNELOPTIONS_FORCE_DWORD = 0x7FFFFFFF

;# WICBitmapDecoderCapabilities
Global Const $WICBitmapDecoderCapabilitySameEncoder          = 0x1
Global Const $WICBitmapDecoderCapabilityCanDecodeAllImages   = 0x2
Global Const $WICBitmapDecoderCapabilityCanDecodeSomeImages  = 0x4
Global Const $WICBitmapDecoderCapabilityCanEnumerateMetadata = 0x8
Global Const $WICBitmapDecoderCapabilityCanDecodeThumbnail   = 0x10

;# WICBitmapDitherType
Global Const $WICBitmapDitherTypeNone           = 0x0
Global Const $WICBitmapDitherTypeSolid          = 0x0
Global Const $WICBitmapDitherTypeOrdered4x4     = 0x1
Global Const $WICBitmapDitherTypeOrdered8x8     = 0x2
Global Const $WICBitmapDitherTypeOrdered16x16   = 0x3
Global Const $WICBitmapDitherTypeSpiral4x4      = 0x4
Global Const $WICBitmapDitherTypeSpiral8x8      = 0x5
Global Const $WICBitmapDitherTypeDualSpiral4x4  = 0x6
Global Const $WICBitmapDitherTypeDualSpiral8x8  = 0x7
Global Const $WICBitmapDitherTypeErrorDiffusion = 0x8
Global Const $WICBITMAPDITHERTYPE_FORCE_DWORD   = 0x7FFFFFFF

;# WICBitmapEncoderCacheOption
Global Const $WICBitmapEncoderCacheInMemory           = 0x0
Global Const $WICBitmapEncoderCacheTempFile           = 0x1
Global Const $WICBitmapEncoderNoCache                 = 0x2
Global Const $WICBITMAPENCODERCACHEOPTION_FORCE_DWORD = 0x7FFFFFFF

;# WICBitmapInterpolationMode
Global Const $WICBitmapInterpolationModeNearestNeighbor = 0x0
Global Const $WICBitmapInterpolationModeLinear          = 0x1
Global Const $WICBitmapInterpolationModeCubic           = 0x2
Global Const $WICBitmapInterpolationModeFant            = 0x3
Global Const $WICBITMAPINTERPOLATIONMODE_FORCE_DWORD    = 0x7FFFFFFF

;# WICBitmapPaletteType
Global Const $WICBitmapPaletteTypeCustom           = 0x0
Global Const $WICBitmapPaletteTypeMedianCut        = 0x1
Global Const $WICBitmapPaletteTypeFixedBW          = 0x2
Global Const $WICBitmapPaletteTypeFixedHalftone8   = 0x3
Global Const $WICBitmapPaletteTypeFixedHalftone27  = 0x4
Global Const $WICBitmapPaletteTypeFixedHalftone64  = 0x5
Global Const $WICBitmapPaletteTypeFixedHalftone125 = 0x6
Global Const $WICBitmapPaletteTypeFixedHalftone216 = 0x7
Global Const $WICBitmapPaletteTypeFixedWebPalette  = $WICBITMAPPALETTETYPEFIXEDHALFTONE216
Global Const $WICBitmapPaletteTypeFixedHalftone252 = 0x8
Global Const $WICBitmapPaletteTypeFixedHalftone256 = 0x9
Global Const $WICBitmapPaletteTypeFixedGray4       = 0xA
Global Const $WICBitmapPaletteTypeFixedGray16      = 0xB
Global Const $WICBitmapPaletteTypeFixedGray256     = 0xC
Global Const $WICBITMAPPALETTETYPE_FORCE_DWORD     = 0x7FFFFFFF

;# WICBitmapTransformOptions
Global Const $WICBitmapTransformRotate0             = 0x0
Global Const $WICBitmapTransformRotate90            = 0x1
Global Const $WICBitmapTransformRotate180           = 0x2
Global Const $WICBitmapTransformRotate270           = 0x3
Global Const $WICBitmapTransformFlipHorizontal      = 0x8
Global Const $WICBitmapTransformFlipVertical        = 0x10
Global Const $WICBITMAPTRANSFORMOPTIONS_FORCE_DWORD = 0x7FFFFFFF

;# WICColorContextType
Global Const $WICColorContextUninitialized  = 0x0
Global Const $WICColorContextProfile        = 0x1
Global Const $WICColorContextExifColorSpace = 0x2

;# WICComponentType
Global Const $WICDecoder                   = 0x1
Global Const $WICEncoder                   = 0x2
Global Const $WICPixelFormatConverter      = 0x4
Global Const $WICMetadataReader            = 0x8
Global Const $WICMetadataWriter            = 0x10
Global Const $WICPixelFormat               = 0x20
Global Const $WICCOMPONENTTYPE_FORCE_DWORD = 0x7FFFFFFF

;# WICComponentSigning
Global Const $WICComponentSigned   = 0x1
Global Const $WICComponentUnsigned = 0x2
Global Const $WICComponentSafe     = 0x4
Global Const $WICComponentDisabled = 0x80000000

;# WICComponentEnumerateOptions
Global Const $WICComponentEnumerateDefault     = 0x0
Global Const $WICComponentEnumerateRefresh     = 0x1
Global Const $WICComponentEnumerateBuiltInOnly = 0x20000000
Global Const $WICComponentEnumerateUnsigned    = 0x40000000
Global Const $WICComponentEnumerateDisabled    = 0x80000000


;# WICBitmapLockFlags
Global Const $WICBitmapLockRead		= 0x1
Global Const $WICBitmapLockWrite	= 0x2



;############################################################################################################
;# WIC_BASETYPES
;############################################################################################################
Global Const $tagWICRect = "struct; int X; int Y; int Width; int Height; endstruct;"
Global Const $tagWICBitmapPattern = "struct; uint64 Position; uint Length; ptr Pattern; ptr Mask; bool EndOfStream; endstruct;"





















;############################################################################################################
;# WIC_GUID
;############################################################################################################

;# WICConvertBitmapSource
Global Const $sCLSID_WICBmpDecoder = "{6b462062-7cbf-400d-9fdb-813dd10f2778}"
Global Const $sCLSID_WICPngDecoder = "{389ea17b-5078-4cde-b6ef-25c15175c751}"
Global Const $sCLSID_WICIcoDecoder = "{c61bfcdf-2e0f-4aad-a8d7-e06bafebcdfe}"
Global Const $sCLSID_WICJpegDecoder = "{9456a480-e88b-43ea-9e73-0b2d9b71b1ca}"
Global Const $sCLSID_WICGifDecoder = "{381dda3c-9ce9-4834-a23e-1f98f8fc52be}"
Global Const $sCLSID_WICTiffDecoder = "{b54e85d9-fe23-499f-8b88-6acea713752b}"
Global Const $sCLSID_WICWmpDecoder = "{a26cec36-234c-4950-ae16-e34aace71d0d}"
Global Const $sCLSID_WICBmpEncoder = "{69be8bb4-d66d-47c8-865a-ed1589433782}"
Global Const $sCLSID_WICPngEncoder = "{27949969-876a-41d7-9447-568f6a35a4dc}"
Global Const $sCLSID_WICJpegEncoder = "{1a34f5c1-4a5a-46dc-b644-1f4567e7a676}"
Global Const $sCLSID_WICGifEncoder = "{114f5598-0b22-40a0-86a1-c83ea495adbd}"
Global Const $sCLSID_WICTiffEncoder = "{0131be10-2001-4c5f-a9b0-cc88fab64ce8}"
Global Const $sCLSID_WICWmpEncoder = "{ac4ce3cb-e1c1-44cd-8215-5a1665509ec2}"
Global Const $sCLSID_WICDefaultFormatConverter = "{1a3f11dc-b514-4b17-8c5f-2154513852f1}"

Global Const $sGUID_ContainerFormatBmp = "{0af1d87e-fcfe-4188-bdeb-a7906471cbe3}"
Global Const $sGUID_ContainerFormatPng = "{1b7cfaf4-713f-473c-bbcd-6137425faeaf}"
Global Const $sGUID_ContainerFormatIco = "{a3a860c4-338f-4c17-919a-fba4b5628f21}"
Global Const $sGUID_ContainerFormatJpeg = "{19e4a5aa-5662-4fc5-a0c0-1758028e1057}"
Global Const $sGUID_ContainerFormatTiff = "{163bcc30-e2e9-4f0b-961d-a3e9fdb788a3}"
Global Const $sGUID_ContainerFormatGif = "{1f8a5601-7d4d-4cbd-9c82-1bc8d4eeb9a5}"
Global Const $sGUID_ContainerFormatWmp = "{57a37caa-367a-4540-916b-f183c5093a4b}"

Global Const $sGUID_VendorMicrosoft = "{f0e749ca-edef-4589-a73a-ee0e626a2a2b}"

Global Const $sCATID_WICBitmapDecoders = "{7ed96837-96f0-4812-b211-f13c24117ed3}"
Global Const $sCATID_WICBitmapEncoders = "{ac757296-3522-4e11-9862-c17be5a1767e}"
Global Const $sCATID_WICFormatConverters = "{7835eae8-bf14-49d1-93ce-533a407b2248}"




;# WICPixelFormatGUID
Global Const $sGUID_WICPixelFormatDontCare = 		"{6fddc324-4e03-4bfe-b185-3d77768dc900}"
Global Const $sGUID_WICPixelFormat1bppIndexed = 	"{6fddc324-4e03-4bfe-b185-3d77768dc901}"
Global Const $sGUID_WICPixelFormat2bppIndexed = 	"{6fddc324-4e03-4bfe-b185-3d77768dc902}"
Global Const $sGUID_WICPixelFormat4bppIndexed = 	"{6fddc324-4e03-4bfe-b185-3d77768dc903}"
Global Const $sGUID_WICPixelFormat8bppIndexed = 	"{6fddc324-4e03-4bfe-b185-3d77768dc904}"
Global Const $sGUID_WICPixelFormatBlackWhite = 		"{6fddc324-4e03-4bfe-b185-3d77768dc905}"
Global Const $sGUID_WICPixelFormat2bppGray = 		"{6fddc324-4e03-4bfe-b185-3d77768dc906}"
Global Const $sGUID_WICPixelFormat4bppGray = 		"{6fddc324-4e03-4bfe-b185-3d77768dc907}"
Global Const $sGUID_WICPixelFormat8bppGray = 		"{6fddc324-4e03-4bfe-b185-3d77768dc908}"
Global Const $sGUID_WICPixelFormat16bppGray = 		"{6fddc324-4e03-4bfe-b185-3d77768dc90b}"
Global Const $sGUID_WICPixelFormat16bppBGR555 = 	"{6fddc324-4e03-4bfe-b185-3d77768dc909}"
Global Const $sGUID_WICPixelFormat16bppBGR565 = 	"{6fddc324-4e03-4bfe-b185-3d77768dc90a}"
Global Const $sGUID_WICPixelFormat16bppBGRA5551 = 	"{05ec7c2b-f1e6-4961-ad46-e1cc810a87d2}"
Global Const $sGUID_WICPixelFormat24bppBGR = 		"{6fddc324-4e03-4bfe-b185-3d77768dc90c}"
Global Const $sGUID_WICPixelFormat32bppBGR = 		"{6fddc324-4e03-4bfe-b185-3d77768dc90e}"
Global Const $sGUID_WICPixelFormat32bppBGRA = 		"{6fddc324-4e03-4bfe-b185-3d77768dc90f}"
Global Const $sGUID_WICPixelFormat32bppPBGRA = 		"{6fddc324-4e03-4bfe-b185-3d77768dc910}"
Global Const $sGUID_WICPixelFormat48bppRGB = 		"{6fddc324-4e03-4bfe-b185-3d77768dc915}"
Global Const $sGUID_WICPixelFormat64bppRGBA = 		"{6fddc324-4e03-4bfe-b185-3d77768dc916}"
Global Const $sGUID_WICPixelFormat64bppPRGBA = 		"{6fddc324-4e03-4bfe-b185-3d77768dc917}"
Global Const $sGUID_WICPixelFormat32bppCMYK = 		"{6fddc324-4e03-4fbe-b185-3d77768dc91c}"




;# WIC_interface
Global Const $sCLSID_WICImagingFactory = "{cacaf262-9370-4615-a13b-9f5539da4c0a}"

Global Const $sIID_IWICStreamProvider = "{449494BC-B468-4927-96D7-BA90D31AB505}"
Global Const $sIID_IWICProgressiveLevelControl = "{DAAC296F-7AA5-4dbf-8D15-225C5976F891}"
Global Const $sIID_IWICProgressCallback = "{4776F9CD-9517-45FA-BF24-E89C5EC5C60C}"
Global Const $sIID_IWICComponentInfo = "{23BC3F0A-698B-4357-886B-F24D50671334}"
Global Const $sIID_IWICPixelFormatInfo = "{E8EDA601-3D48-431a-AB44-69059BE88BBE}"
Global Const $sIID_IWICPixelFormatInfo2 = "{A9DB33A2-AF5F-43C7-B679-74F5984B5AA4}"
Global Const $sIID_IWICPersistStream = "{00675040-6908-45F8-86A3-49C7DFD6D9AD}"
Global Const $sIID_IWICPalette = "{00000040-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICMetadataHandlerInfo = "{ABA958BF-C672-44D1-8D61-CE6DF2E682C2}"
Global Const $sIID_IWICMetadataWriterInfo = "{B22E3FBA-3925-4323-B5C1-9EBFC430F236}"
Global Const $sIID_IWICMetadataReader = "{9204FE99-D8FC-4FD5-A001-9536B067A899}"
Global Const $sIID_IWICMetadataWriter = "{F7836E16-3BE0-470B-86BB-160D0AECD7DE}"
Global Const $sIID_IWICMetadataReaderInfo = "{EEBF1F5B-07C1-4447-A3AB-22ACAF78A804}"
Global Const $sIID_IWICMetadataQueryReader = "{30989668-E1C9-4597-B395-458EEDB808DF}"
Global Const $sIID_IWICMetadataQueryWriter = "{A721791A-0DEF-4d06-BD91-2118BF1DB10B}"
Global Const $sIID_IWICMetadataBlockReader = "{FEAA2A8D-B3F3-43E4-B25C-D1DE990A1AE1}"
Global Const $sIID_IWICFormatConverterInfo = "{9F34FB65-13F4-4f15-BC57-3726B5E53D9F}"
Global Const $sIID_IWICMetadataBlockWriter = "{08FB9676-B444-41E8-8DBE-6A53A542BFF1}"
Global Const $sIID_IWICFastMetadataEncoder = "{B84E2C09-78C9-4AC4-8BD3-524AE1663A2F}"
Global Const $sIID_IWICEnumMetadataItem = "{DC2BB46D-3F07-481E-8625-220C4AEDBB33}"
Global Const $sIID_IWICDevelopRawNotificationCallback = "{95c75a6e-3e8c-4ec2-85a8-aebcc551e59b}"
Global Const $sIID_IWICBitmapSource = "{00000120-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICBitmapFrameDecode = "{3B16811B-6A43-4ec9-A813-3D930C13B940}"
Global Const $sIID_IWICDevelopRaw = "{fbec5e44-f7be-4b65-b7f8-c0c81fef026d}"
Global Const $sIID_IWICImagingFactory = "{ec5ec8a9-c395-4314-9c77-54d7a935ff70}"
Global Const $sIID_IWICComponentFactory = "{412D0C3A-9650-44FA-AF5B-DD2A06C8E8FB}"
Global Const $sIID_IWICColorTransform = "{B66F034F-D0E2-40ab-B436-6DE39E321A94}"
Global Const $sIID_IWICColorContext = "{3C613A02-34B2-44ea-9A7C-45AEA9C6FD6D}"
Global Const $sIID_IWICBitmapSourceTransform = "{3B16811B-6A43-4ec9-B713-3D5A0C13B940}"
Global Const $sIID_IWICBitmapCodecInfo = "{E87A44C4-B76E-4c47-8B09-298EB12A2714}"
Global Const $sIID_IWICBitmapScaler = "{00000302-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICBitmapLock = "{00000123-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICBitmapFrameEncode = "{00000105-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICBitmapFlipRotator = "{5009834F-2D6A-41ce-9E1B-17C5AFF7A782}"
Global Const $sIID_IWICBitmapEncoderInfo = "{94C9B4EE-A09F-4f92-8A1E-4A9BCE7E76FB}"
Global Const $sIID_IWICBitmapEncoder = "{00000103-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICBitmapDecoderInfo = "{D8CD007F-D08F-4191-9BFC-236EA7F0E4B5}"
Global Const $sIID_IWICBitmapCodecProgressNotification = "{64C1024E-C3CF-4462-8078-88C2B11C46D9}"
Global Const $sIID_IWICBitmapClipper = "{E4FBCF03-223D-4e81-9333-D635556DD1B5}"
Global Const $sIID_IWICBitmap = "{00000121-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICBitmapDecoder = "{9EDDE9E7-8DEE-47ea-99DF-E6FAF2ED44BF}"
Global Const $sIID_IWICFormatConverter = "{00000301-a8f2-4877-ba0a-fd2b6645fb94}"
Global Const $sIID_IWICStream = "{135FF860-22B7-4ddf-B0F6-218F4F299A43}"


Global Const $sIID_IPropertyBag2 = "{22F55882-280B-11d0-A8A9-00A0C90C2004}"











;############################################################################################################
;# WIC_InterfaceDescription
;############################################################################################################
Global Const $tagIWICStreamProvider = "GetStream hresult(ptr*);" & _
		"GetPersistOptions hresult(uint*);" & _
		"GetPreferredVendorGUID hresult(ptr*);" & _
		"RefreshStream hresult();"

Global Const $tagIWICProgressiveLevelControl = "GetLevelCount hresult(uint*);" & _
		"GetCurrentLevel hresult(uint*);" & _
		"SetCurrentLevel hresult(uint);"

Global Const $tagIWICProgressCallback = "Notify hresult(uint;uint;double);"

Global Const $tagIWICComponentInfo = "GetComponentType hresult(ptr*);" & _
		"GetCLSID hresult(ptr*);" & _
		"GetSigningStatus hresult(ptr*);" & _
		"GetAuthor hresult(uint;wstr;uint*);" & _
		"GetVendorGUID hresult(ptr*);" & _
		"GetVersion hresult(uint;wstr;uint*);" & _
		"GetSpecVersion hresult(uint;wstr;uint*);" & _
		"GetFriendlyName hresult(uint;wstr;uint*);"

Global Const $tagIWICPixelFormatInfo = $tagIWICComponentInfo & _
		"GetFormatGUID hresult(ptr*);" & _
		"GetColorContext hresult(ptr*);" & _
		"GetBitsPerPixel hresult(uint*);" & _
		"GetChannelCount hresult(uint*);" & _
		"GetChannelMask hresult(uint;uint;struct*;uint*);"

Global Const $tagIWICPixelFormatInfo2 = $tagIWICPixelFormatInfo & _
		"SupportsTransparency hresult(bool*);" & _
		"GetNumericRepresentation hresult(uint*);"

Global Const $tagIWICPersistStream = "GetClassID hresult(ptr*);" & _	;-
		"IsDirty hresult(struct*);" & _									; |
		"Load hresult(struct*);" & _									; | $tagIPersistStream
		"Save hresult(struct*;bool);" & _								; |
		"GetSizeMax hresult(uint64*);" & _								;-
		"LoadEx hresult(struct*;struct*;uint);" & _
		"SaveEx hresult(struct*;uint;bool);"

Global Const $tagIWICPalette = "InitializePredefined hresult(struct*;bool);" & _
		"InitializeCustom hresult(struct*;uint);" & _
		"InitializeFromBitmap hresult(struct*;uint;bool);" & _
		"InitializeFromPalette hresult(struct*);" & _
		"GetType hresult(ptr*);" & _
		"GetColorCount hresult(uint*);" & _
		"GetColors hresult(uint;struct*;uint*);" & _
		"IsBlackWhite hresult(bool*);" & _
		"IsGrayscale hresult(bool*);" & _
		"HasAlpha hresult(bool*);"

Global Const $tagIWICMetadataHandlerInfo = $tagIWICComponentInfo & _
		"GetMetadataFormat hresult(ptr*);" & _
		"GetContainerFormats hresult(uint;struct*;uint*);" & _
		"GetDeviceManufacturer hresult(uint;wstr;uint*);" & _
		"GetDeviceModels hresult(uint;wstr;uint*);" & _
		"DoesRequireFullStream hresult(bool*);" & _
		"DoesSupportPadding hresult(bool*);" & _
		"DoesRequireFixedSize hresult(bool*);"

Global Const $tagIWICMetadataWriterInfo = $tagIWICMetadataHandlerInfo & _
		"GetHeader hresult(struct*;uint;struct*;uint*);" & _
		"CreateInstance hresult(ptr*);"

Global Const $tagIWICMetadataReader = "GetMetadataFormat hresult(ptr*);" & _
		"GetMetadataHandlerInfo hresult(ptr*);" & _
		"GetCount hresult(uint*);" & _
		"GetValueByIndex hresult(uint;variant*;variant*;variant*);" & _
		"GetValue hresult(variant*;variant*;variant*);" & _
		"GetEnumerator hresult(ptr*);"

Global Const $tagIWICMetadataWriter = $tagIWICMetadataReader & _
		"SetValue hresult(variant*;variant*;variant*);" & _
		"SetValueByIndex hresult(uint;variant*;variant*;variant*);" & _
		"RemoveValue hresult(variant*;variant*);" & _
		"RemoveValueByIndex hresult(uint);"

Global Const $tagIWICMetadataReaderInfo = $tagIWICMetadataHandlerInfo & _
		"GetPatterns hresult(struct*;uint;struct*;uint*;uint*);" & _
		"MatchesPattern hresult(struct*;struct*;bool*);" & _
		"CreateInstance hresult(ptr*);"

Global Const $tagIWICMetadataQueryReader = "GetContainerFormat hresult(ptr*);" & _
		"GetLocation hresult(uint;wstr;uint*);" & _
		"GetMetadataByName hresult(wstr;struct*);" & _
		"GetEnumerator hresult(ptr*);"

Global Const $tagIWICMetadataQueryWriter = $tagIWICMetadataQueryReader & _
		"SetMetadataByName hresult(wstr;struct*);" & _
		"RemoveMetadataByName hresult(wstr);"

Global Const $tagIWICMetadataBlockReader = "GetContainerFormat hresult(ptr*);" & _
		"GetCount hresult(uint*);" & _
		"GetReaderByIndex hresult(uint;ptr*);" & _
		"GetEnumerator hresult(ptr*);"

Global Const $tagIWICFormatConverterInfo = $tagIWICComponentInfo & _
		"GetPixelFormats hresult(uint;struct*;uint*);" & _
		"CreateInstance hresult(ptr*);"

Global Const $tagIWICMetadataBlockWriter = $tagIWICMetadataBlockReader & _
		"InitializeFromBlockReader hresult(struct*);" & _
		"GetWriterByIndex hresult(uint;ptr*);" & _
		"AddWriter hresult(struct*);" & _
		"SetWriterByIndex hresult(uint;struct*);" & _
		"RemoveWriterByIndex hresult(uint);"

Global Const $tagIWICFastMetadataEncoder = "Commit hresult();" & _
		"GetMetadataQueryWriter hresult(ptr*);"

Global Const $tagIWICEnumMetadataItem = "Next hresult(uint;struct*;struct*;struct*;uint*);" & _
		"Skip hresult(uint);" & _
		"Reset hresult();" & _
		"Clone hresult(ptr*);"

Global Const $tagIWICDevelopRawNotificationCallback = "Notify hresult(uint);"

Global Const $tagIWICBitmapSource = "GetSize hresult(uint*;uint*);" & _
		"GetPixelFormat hresult(struct*);" & _
		"GetResolution hresult(double*;double*);" & _
		"CopyPalette hresult(struct*);" & _
		"CopyPixels hresult(struct*;uint;uint;struct*);"

Global Const $tagIWICBitmapFrameDecode = $tagIWICBitmapSource & _
		"GetMetadataQueryReader hresult(ptr*);" & _
		"GetColorContexts hresult(uint;struct*;uint);" & _
		"GetThumbnail hresult(ptr*);"

Global Const $tagIWICDevelopRaw = $tagIWICBitmapFrameDecode & _
		"QueryRawCapabilitiesInfo hresult(ptr*);" & _
		"LoadParameterSet hresult(uint);" & _
		"GetCurrentParameterSet hresult(ptr*);" & _
		"SetExposureCompensation hresult(double);" & _
		"GetExposureCompensation hresult(double*);" & _
		"SetWhitePointRGB hresult(uint;uint;uint);" & _
		"GetWhitePointRGB hresult(uint*;uint*;uint*);" & _
		"SetNamedWhitePoint hresult(uint);" & _
		"GetNamedWhitePoint hresult(uint*);" & _
		"SetWhitePointKelvin hresult(uint);" & _
		"GetWhitePointKelvin hresult(uint*);" & _
		"GetKelvinRangeInfo hresult(uint*;uint*;uint*);" & _
		"SetContrast hresult(double);" & _
		"GetContrast hresult(double*);" & _
		"SetGamma hresult(double);" & _
		"GetGamma hresult(double*);" & _
		"SetSharpness hresult(double);" & _
		"GetSharpness hresult(double*);" & _
		"SetSaturation hresult(double);" & _
		"GetSaturation hresult(double*);" & _
		"SetTint hresult(double);" & _
		"GetTint hresult(double*);" & _
		"SetNoiseReduction hresult(double);" & _
		"GetNoiseReduction hresult(double*);" & _
		"SetDestinationColorContext hresult(struct*);" & _
		"SetToneCurve hresult(uint;struct*);" & _
		"GetToneCurve hresult(uint;ptr*;uint*);" & _
		"SetRotation hresult(double);" & _
		"GetRotation hresult(double*);" & _
		"SetRenderMode hresult(uint);" & _
		"GetRenderMode hresult(ptr*);" & _
		"SetNotificationCallback hresult(struct*);"

Global Const $tagIWICImagingFactory = "CreateDecoderFromFilename hresult(wstr;struct*;uint;uint;ptr*);" & _
		"CreateDecoderFromStream hresult(struct*;struct*;uint;ptr*);" & _
		"CreateDecoderFromFileHandle hresult(handle;struct*;uint;ptr*);" & _
		"CreateComponentInfo hresult(struct*;ptr*);" & _
		"CreateDecoder hresult(struct*;struct*;ptr*);" & _
		"CreateEncoder hresult(struct*;struct*;ptr*);" & _
		"CreatePalette hresult(ptr*);" & _
		"CreateFormatConverter hresult(ptr*);" & _
		"CreateBitmapScaler hresult(ptr*);" & _
		"CreateBitmapClipper hresult(ptr*);" & _
		"CreateBitmapFlipRotator hresult(ptr*);" & _
		"CreateStream hresult(ptr*);" & _
		"CreateColorContext hresult(ptr*);" & _
		"CreateColorTransformer hresult(ptr*);" & _
		"CreateBitmap hresult(uint;uint;struct*;uint;ptr*);" & _
		"CreateBitmapFromSource hresult(struct*;uint;ptr*);" & _
		"CreateBitmapFromSourceRect hresult(struct*;uint;uint;uint;uint;ptr*);" & _
		"CreateBitmapFromMemory hresult(uint;uint;struct*;uint;uint;struct*;ptr*);" & _
		"CreateBitmapFromHBITMAP hresult(handle;handle;uint;ptr*);" & _
		"CreateBitmapFromHICON hresult(handle;ptr*);" & _
		"CreateComponentEnumerator hresult(uint;uint;ptr*);" & _
		"CreateFastMetadataEncoderFromDecoder hresult(struct*;ptr*);" & _
		"CreateFastMetadataEncoderFromFrameDecode hresult(struct*;ptr*);" & _
		"CreateQueryWriter hresult(struct*;struct*;ptr*);" & _
		"CreateQueryWriterFromReader hresult(struct*;struct*;ptr*);"

Global Const $tagIWICComponentFactory = $tagIWICImagingFactory & _
		"CreateMetadataReader hresult(struct*;struct*;uint;struct*;ptr*);" & _
		"CreateMetadataReaderFromContainer hresult(struct*;struct*;uint;struct*;ptr*);" & _
		"CreateMetadataWriter hresult(struct*;struct*;uint;ptr*);" & _
		"CreateMetadataWriterFromReader hresult(struct*;struct*;ptr*);" & _
		"CreateQueryReaderFromBlockReader hresult(struct*;ptr*);" & _
		"CreateQueryWriterFromBlockWriter hresult(struct*;ptr*);" & _
		"CreateEncoderPropertyBag hresult(struct*;uint;ptr*);"

Global Const $tagIWICColorTransform = $tagIWICBitmapSource & _
		"Initialize hresult(struct*;struct*;struct*;struct*);"

Global Const $tagIWICColorContext = "InitializeFromFilename hresult(wstr);" & _
		"InitializeFromMemory hresult(struct*;uint);" & _
		"InitializeFromExifColorSpace hresult(uint);" & _
		"GetType hresult(ptr*);" & _
		"GetProfileBytes hresult(uint;struct*;uint*);" & _
		"GetExifColorSpace hresult(uint*);"

Global Const $tagIWICBitmapSourceTransform = "CopyPixels hresult(struct*;uint;uint;struct*;uint;uint;uint;ptr*);" & _
		"GetClosestSize hresult(uint*;uint*);" & _
		"GetClosestPixelFormat hresult(ptr*);" & _
		"DoesSupportTransform hresult(uint;bool*);"

Global Const $tagIWICBitmapCodecInfo = $tagIWICComponentInfo & _
		"GetContainerFormat hresult(ptr*);" & _
		"GetPixelFormats hresult(uint;struct*;uint*);" & _
		"GetColorManagementVersion hresult(uint;wstr;uint*);" & _
		"GetDeviceManufacturer hresult(uint;wstr;uint*);" & _
		"GetDeviceModels hresult(uint;wstr;uint*);" & _
		"GetMimeTypes hresult(uint;wstr;uint*);" & _
		"GetFileExtensions hresult(uint;wstr;uint*);" & _
		"DoesSupportAnimation hresult(bool*);" & _
		"DoesSupportChromakey hresult(bool*);" & _
		"DoesSupportLossless hresult(bool*);" & _
		"DoesSupportMultiframe hresult(bool*);" & _
		"MatchesMimeType hresult(wstr;bool*);"

Global Const $tagIWICBitmapScaler = $tagIWICBitmapSource & _
		"Initialize hresult(struct*;uint;uint;uint);"

Global Const $tagIWICBitmapLock = "GetSize hresult(uint*;uint*);" & _
		"GetStride hresult(uint*);" & _
		"GetDataPointer hresult(uint*;ptr*);" & _
		"GetPixelFormat hresult(struct*);"

Global Const $tagIWICBitmapFrameEncode = "Initialize hresult(struct*);" & _
		"SetSize hresult(uint;uint);" & _
		"SetResolution hresult(double;double);" & _
		"SetPixelFormat hresult(struct*);" & _
		"SetColorContexts hresult(uint;struct*);" & _
		"SetPalette hresult(struct*);" & _
		"SetThumbnail hresult(struct*);" & _
		"WritePixels hresult(uint;uint;uint;struct*);" & _
		"WriteSource hresult(struct*;struct*);" & _
		"Commit hresult();" & _
		"GetMetadataQueryWriter hresult(ptr*);"

Global Const $tagIWICBitmapFlipRotator = $tagIWICBitmapSource & _
		"Initialize hresult(struct*;uint);"

Global Const $tagIWICBitmapEncoderInfo = $tagIWICBitmapCodecInfo & _
		"CreateInstance hresult(ptr*);"

Global Const $tagIWICBitmapEncoder = "Initialize hresult(struct*;uint);" & _
		"GetContainerFormat hresult(ptr*);" & _
		"GetEncoderInfo hresult(ptr*);" & _
		"SetColorContexts hresult(uint;struct*);" & _
		"SetPalette hresult(struct*);" & _
		"SetThumbnail hresult(struct*);" & _
		"SetPreview hresult(struct*);" & _
		"CreateNewFrame hresult(ptr*;ptr*);" & _
		"Commit hresult();" & _
		"GetMetadataQueryWriter hresult(ptr*);"

Global Const $tagIWICBitmapDecoderInfo = $tagIWICBitmapCodecInfo & _
		"GetPatterns hresult(uint;ptr*;uint*;uint*);" & _
		"MatchesPattern hresult(struct*;bool*);" & _
		"CreateInstance hresult(ptr*);"

Global Const $tagIWICBitmapCodecProgressNotification = "RegisterProgressNotification hresult(struct*;struct*;uint);"

Global Const $tagIWICBitmapClipper = $tagIWICBitmapSource & _
		"Initialize hresult(struct*;struct*);"

Global Const $tagIWICBitmap = $tagIWICBitmapSource & _
		"Lock hresult(struct*;uint;ptr*);" & _
		"SetPalette hresult(struct*);" & _
		"SetResolution hresult(double;double);"

Global Const $tagIWICBitmapDecoder = "QueryCapability hresult(ptr*;uint);" & _
		"Initialize hresult(ptr*);" & _
		"GetContainerFormat hresult(ptr*);" & _
		"GetDecoderInfo hresult(ptr*);" & _
		"CopyPalette hresult(struct*);" & _
		"GetMetadataQueryReader hresult(ptr*);" & _
		"GetPreview hresult(ptr*);" & _
		"GetColorContexts hresult(uint;struct*;uint*);" & _
		"GetThumbnail hresult(ptr*);" & _
		"GetFrameCount hresult(uint*);" & _
		"GetFrame hresult(uint;ptr*);"

Global Const $tagIWICFormatConverter = $tagIWICBitmapSource & _
		"Initialize hresult(struct*;struct*;uint;struct*;double;uint);" & _
		"CanConvert hresult(struct*;struct*;bool*);"

Global Const $tagIWICStream = "Read hresult(ptr;dword;dword*);" & _	;-
		"Write hresult(ptr;dword;dword*);" & _						; |
		"Seek hresult(uint64;dword;uint64*);" & _					; |
		"SetSize hresult(uint64);" & _								; |
		"CopyTo hresult(ptr;uint64;uint64*;uint64*);" & _			; |
		"Commit hresult(dword);" & _								; | $tagIStream
		"Revert hresult();" & _										; |
		"LockRegion hresult(uint64;uint64;dword);" & _				; |
		"UnlockRegion hresult(uint64;uint64;dword);" & _			; |
		"Stat hresult(ptr;dword);" & _								; |
		"Clone hresult(ptr*);" & _									;-
		"InitializeFromIStream hresult(ptr*);" & _
		"InitializeFromFilename hresult(wstr;uint);" & _
		"InitializeFromMemory hresult(struct*;uint);" & _
		"InitializeFromIStreamRegion hresult(struct*;uint64;uint64);"



Global Const $tagIPropertyBag2 = "Read hresult(uint;struct*;struct*;struct*;hresult*);" & _
		"Write hresult(uint;struct*;struct*);" & _
		"CountProperties hresult(uint*);" & _
		"GetPropertyInfo hresult(uint;uint;struct*;uint*);" & _
		"LoadObject hresult(wstr;uint;struct*;struct*);"