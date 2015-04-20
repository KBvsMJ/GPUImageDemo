//
//  MultiFilterViewController.m
//  GPUImageDemo
//
//  Created by casa on 4/1/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "MultiFilterViewController.h"
#import "UIView+LayoutMethods.h"
#import <GPUImage/GPUImage.h>

#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MultiFilterViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *firstTableView;
@property (nonatomic, strong) UITableView *secondTableView;

@property (nonatomic, strong) UILabel *firstFilterLabel;
@property (nonatomic, strong) UILabel *secondFilterLabel;

@property (nonatomic, strong) UIButton *cleanButton;
@property (nonatomic, strong) UIButton *takeImageButton;

@property (nonatomic, strong) GPUImagePicture *originPicture;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *processedImageView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *filterArray;

@end

@implementation MultiFilterViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstTableView];
    [self.view addSubview:self.secondTableView];
    [self.view addSubview:self.firstFilterLabel];
    [self.view addSubview:self.secondFilterLabel];
    [self.view addSubview:self.cleanButton];
    [self.view addSubview:self.originImageView];
    [self.view addSubview:self.processedImageView];
    [self.view addSubview:self.activityIndicator];
    [self.view addSubview:self.takeImageButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat width = (self.view.width - 30) / 2.0f;
    
    self.originImageView.size = CGSizeMake(width, width);
    [self.originImageView topInContainer:70 shouldResize:NO];
    [self.originImageView leftInContainer:10 shouldResize:NO];
    
    self.processedImageView.size = CGSizeMake(width, width);
    [self.processedImageView right:10 FromView:self.originImageView];
    [self.processedImageView topEqualToView:self.originImageView];
    
    CGFloat labelWidth = self.view.width - 100;
    self.firstFilterLabel.size = CGSizeMake(labelWidth, 20);
    [self.firstFilterLabel leftInContainer:10 shouldResize:NO];
    [self.firstFilterLabel top:10 FromView:self.originImageView];
    
    self.secondFilterLabel.size = CGSizeMake(labelWidth, 20);
    [self.secondFilterLabel top:5 FromView:self.firstFilterLabel];
    [self.secondFilterLabel leftEqualToView:self.firstFilterLabel];
    
    self.cleanButton.width = 80;
    [self.cleanButton heightEqualToView:self.firstFilterLabel];
    [self.cleanButton right:10 FromView:self.firstFilterLabel];
    [self.cleanButton topEqualToView:self.firstFilterLabel];
    
    self.takeImageButton.width = 80;
    [self.takeImageButton heightEqualToView:self.secondFilterLabel];
    [self.takeImageButton right:10 FromView:self.secondFilterLabel];
    [self.takeImageButton topEqualToView:self.secondFilterLabel];
    
    CGFloat tableViewHeight = (self.view.height - self.secondFilterLabel.bottom - 30.0f) / 2.0f;
    
    self.firstTableView.size = CGSizeMake(self.view.width - 20, tableViewHeight);
    [self.firstTableView top:10 FromView:self.secondFilterLabel];
    [self.firstTableView centerXEqualToView:self.view];
    
    self.secondTableView.size = CGSizeMake(self.view.width - 20, tableViewHeight);
    [self.secondTableView top:10 FromView:self.firstTableView];
    [self.secondTableView centerXEqualToView:self.view];
    
    [self.activityIndicator centerXEqualToView:self.processedImageView];
    [self.activityIndicator centerYEqualToView:self.processedImageView];
}

#pragma mark - event response
- (void)didTappedCleanButton:(UIButton *)button
{
    self.processedImageView.image = [UIImage imageNamed:@"DemoImage"];
    [self.firstTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.secondTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)didTappedTakeImageButton:(UIButton *)button
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - private methods
- (void)process
{
    NSString *firstFilterName = self.firstFilterLabel.text;
    NSString *secondFilterName = self.secondFilterLabel.text;
    
    GPUImageFilter *firstFilter = nil;
    GPUImageFilter *secondFilter = nil;
    
    [self.originPicture removeAllTargets];
    
    if (firstFilterName == nil || firstFilterName.length == 0 || [firstFilterName isEqualToString:@"empty"]) {
        if (secondFilterName == nil || secondFilterName.length == 0 || [secondFilterName isEqualToString:@"empty"]) {
            // n1, n2
            self.processedImageView.image = [UIImage imageNamed:@"DemoImage"];
            return;
        } else {
            // n1, y2
            firstFilter = [[NSClassFromString(secondFilterName) alloc] init];
        }
    } else {
        if (secondFilterName == nil || secondFilterName.length == 0 || [secondFilterName isEqualToString:@"empty"]) {
            // y1, n2
            firstFilter = [[NSClassFromString(firstFilterName) alloc] init];
        } else {
            // y1, y2
            firstFilter = [[NSClassFromString(firstFilterName) alloc] init];
            secondFilter = [[NSClassFromString(secondFilterName) alloc] init];
        }
    }
    
    [self.originPicture addTarget:firstFilter];
    if (secondFilter) {
        [firstFilter addTarget:secondFilter];
        [secondFilter useNextFrameForImageCapture];
    } else {
        [firstFilter useNextFrameForImageCapture];
    }
    
    [self.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.originPicture processImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self processFinishedWithFilter:secondFilter?secondFilter:firstFilter];
        });
    });
}

- (void)processFinishedWithFilter:(GPUImageFilter *)filter
{
    self.processedImageView.image = [filter imageFromCurrentFramebuffer];
    [self.activityIndicator stopAnimating];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock:^(ALAsset *asset) {
                 
                 ALAssetRepresentation *image_representation = [asset defaultRepresentation];
                 
                 // create a buffer to hold image data
                 uint8_t *buffer = (Byte*)malloc(image_representation.size);
                 NSUInteger length = [image_representation getBytes:buffer fromOffset: 0.0  length:image_representation.size error:nil];
                 
                 if (length != 0)  {
                     
                     // buffer -> NSData object; free buffer afterwards
                     NSData *adata = [[NSData alloc] initWithBytesNoCopy:buffer length:image_representation.size freeWhenDone:YES];
                     
                     // identify image type (jpeg, png, RAW file, ...) using UTI hint
                     NSDictionary* sourceOptionsDict = [NSDictionary dictionaryWithObjectsAndKeys:(id)[image_representation UTI] ,kCGImageSourceTypeIdentifierHint,nil];
                     
                     // create CGImageSource with NSData
                     CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef) adata,  (__bridge CFDictionaryRef) sourceOptionsDict);
                     
                     // get imagePropertiesDictionary
                     CFDictionaryRef imagePropertiesDictionary;
                     imagePropertiesDictionary = CGImageSourceCopyPropertiesAtIndex(sourceRef,0, NULL);
                     
                     // get exif data
                     CFDictionaryRef exif = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyExifDictionary);
                     NSDictionary *exif_dict = (__bridge NSDictionary*)exif;
                     NSLog(@"exif_dict: %@",exif_dict);
                     
                     // save image WITH meta data
                     NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                     NSURL *fileURL = nil;
                     CGImageRef imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, imagePropertiesDictionary);
                     
                     if (![[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"] isEqualToString:@"public.tiff"])
                     {
                         fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.%@",
                                                           documentsDirectory,
                                                           @"myimage",
                                                           [[[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"] componentsSeparatedByString:@"."] objectAtIndex:1]
                                                           ]];
                         
                         CGImageDestinationRef dr = CGImageDestinationCreateWithURL ((__bridge CFURLRef)fileURL,
                                                                                     (__bridge CFStringRef)[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"],
                                                                                     1,
                                                                                     NULL
                                                                                     );
                         CGImageDestinationAddImage(dr, imageRef, imagePropertiesDictionary);
                         CGImageDestinationFinalize(dr);
                         CFRelease(dr);
                     }
                     else
                     {
                         NSLog(@"no valid kCGImageSourceTypeIdentifierHint found …");
                     }
                     
                     // clean up
                     CFRelease(imageRef);
                     CFRelease(imagePropertiesDictionary);
                     CFRelease(sourceRef);
                 }
                 else {
                     NSLog(@"image_representation buffer length == 0");
                 }
             }
            failureBlock:^(NSError *error) {
                NSLog(@"couldn't get asset: %@", error);
            }
     ];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.filterArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filterName = self.filterArray[indexPath.row];
    if (tableView == self.firstTableView) {
        self.firstFilterLabel.text = filterName;
    } else {
        self.secondFilterLabel.text = filterName;
    }
    [self process];
}

#pragma mark - getters and setters
- (UIButton *)takeImageButton
{
    if (_takeImageButton == nil) {
        _takeImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_takeImageButton setTitle:@"take image" forState:UIControlStateNormal];
        [_takeImageButton addTarget:self action:@selector(didTappedTakeImageButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takeImageButton;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activityIndicator stopAnimating];
    }
    return _activityIndicator;
}

- (GPUImagePicture *)originPicture
{
    if (_originPicture == nil) {
        _originPicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"DemoImage"]];
    }
    return _originPicture;
}

- (UIImageView *)originImageView
{
    if (_originImageView == nil) {
        _originImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DemoImage"]];
    }
    return _originImageView;
}

- (UIImageView *)processedImageView
{
    if (_processedImageView == nil) {
        _processedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DemoImage"]];
    }
    return _processedImageView;
}

- (UIButton *)cleanButton
{
    if (_cleanButton == nil) {
        _cleanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_cleanButton setTitle:@"clean" forState:UIControlStateNormal];
        [_cleanButton addTarget:self action:@selector(didTappedCleanButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanButton;
}

- (UILabel *)firstFilterLabel
{
    if (_firstFilterLabel == nil) {
        _firstFilterLabel = [[UILabel alloc] init];
    }
    return _firstFilterLabel;
}

- (UILabel *)secondFilterLabel
{
    if (_secondFilterLabel == nil) {
        _secondFilterLabel = [[UILabel alloc] init];
    }
    return _secondFilterLabel;
}

- (UITableView *)firstTableView
{
    if (_firstTableView == nil) {
        _firstTableView = [[UITableView alloc] init];
        _firstTableView.delegate = self;
        _firstTableView.dataSource = self;
        _firstTableView.layer.borderColor = [[UIColor blackColor] CGColor];
        _firstTableView.layer.borderWidth = 1.0f;
    }
    return _firstTableView;
}

- (UITableView *)secondTableView
{
    if (_secondTableView == nil) {
        _secondTableView = [[UITableView alloc] init];
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        _secondTableView.layer.borderColor = [[UIColor blackColor] CGColor];
        _secondTableView.layer.borderWidth = 1.0f;
    }
    return _secondTableView;
}

- (NSArray *)filterArray
{
    if (_filterArray == nil) {
        _filterArray = @[
                         @"empty",
                         //                         @"GPUImage3x3ConvolutionFilter",
                         //                         @"GPUImage3x3TextureSamplingFilter",
                         @"GPUImageAdaptiveThresholdFilter",
                         //                         @"GPUImageAddBlendFilter",
                         //                         @"GPUImageAlphaBlendFilter",
                         @"GPUImageAmatorkaFilter",
                         @"GPUImageAverageLuminanceThresholdFilter",
                         @"GPUImageBilateralFilter",
                         @"GPUImageBoxBlurFilter",
                         @"GPUImageBrightnessFilter",
                         @"GPUImageBulgeDistortionFilter",
                         @"GPUImageCGAColorspaceFilter",
                         @"GPUImageCannyEdgeDetectionFilter",
                         //                         @"GPUImageChromaKeyBlendFilter",
                         @"GPUImageChromaKeyFilter",
                         @"GPUImageClosingFilter",
                         //                         @"GPUImageColorBlendFilter",
                         //                         @"GPUImageColorBurnBlendFilter",
                         //                         @"GPUImageColorDodgeBlendFilter",
                         @"GPUImageColorInvertFilter",
                         @"GPUImageColorMatrixFilter",
                         @"GPUImageColorPackingFilter",
                         @"GPUImageContrastFilter",
                         @"GPUImageCropFilter",
                         @"GPUImageCrosshatchFilter",
                         //                         @"GPUImageDarkenBlendFilter",
                         //                         @"GPUImageDifferenceBlendFilter",
                         @"GPUImageDilationFilter",
                         @"GPUImageDirectionalNonMaximumSuppressionFilter",
                         //                         @"GPUImageDissolveBlendFilter",
                         //                         @"GPUImageDivideBlendFilter",
                         @"GPUImageEmbossFilter",
                         @"GPUImageErosionFilter",
                         //                         @"GPUImageExclusionBlendFilter",
                         @"GPUImageExposureFilter",
                         //                         @"GPUImageFASTCornerDetectionFilter",
                         @"GPUImageFalseColorFilter",
                         @"GPUImageGammaFilter",
                         @"GPUImageGaussianBlurFilter",
                         @"GPUImageGaussianBlurPositionFilter",
                         @"GPUImageGaussianSelectiveBlurFilter",
                         @"GPUImageGlassSphereFilter",
                         @"GPUImageGrayscaleFilter",
                         @"GPUImageHSBFilter",
                         @"GPUImageHalftoneFilter",
                         //                         @"GPUImageHardLightBlendFilter",
                         //                         @"GPUImageHarrisCornerDetectionFilter",
                         @"GPUImageHazeFilter",
                         @"GPUImageHighPassFilter",
                         @"GPUImageHighlightShadowFilter",
                         @"GPUImageHistogramEqualizationFilter",
                         @"GPUImageHistogramFilter",
                         //                         @"GPUImageHueBlendFilter",
                         @"GPUImageHueFilter",
                         //                         @"GPUImageJFAVoronoiFilter",
                         @"GPUImageKuwaharaFilter",
                         //                         @"GPUImageKuwaharaRadius3Filter",
                         @"GPUImageLanczosResamplingFilter",
                         @"GPUImageLaplacianFilter",
                         @"GPUImageLevelsFilter",
                         //                         @"GPUImageLightenBlendFilter",
                         //                         @"GPUImageLinearBurnBlendFilter",
                         @"GPUImageLocalBinaryPatternFilter",
                         //                         @"GPUImageLookupFilter",
                         @"GPUImageLowPassFilter",
                         @"GPUImageLuminanceRangeFilter",
                         @"GPUImageLuminanceThresholdFilter",
                         //                         @"GPUImageLuminosityBlendFilter",
                         //                         @"GPUImageMaskFilter",
                         @"GPUImageMedianFilter",
                         @"GPUImageMissEtikateFilter",
                         @"GPUImageMonochromeFilter",
                         //                         @"GPUImageMosaicFilter",
                         @"GPUImageMotionBlurFilter",
                         //                         @"GPUImageMultiplyBlendFilter",
                         //                         @"GPUImageNobleCornerDetectionFilter",
                         //                         @"GPUImageNonMaximumSuppressionFilter",
                         //                         @"GPUImageNormalBlendFilter",
                         @"GPUImageOpacityFilter",
                         @"GPUImageOpeningFilter",
                         //                         @"GPUImageOverlayBlendFilter",
                         //                         @"GPUImageParallelCoordinateLineTransformFilter",
                         @"GPUImagePerlinNoiseFilter",
                         @"GPUImagePinchDistortionFilter",
                         @"GPUImagePixellateFilter",
                         @"GPUImagePixellatePositionFilter",
                         //                         @"GPUImagePoissonBlendFilter",
                         @"GPUImagePolarPixellateFilter",
                         @"GPUImagePolkaDotFilter",
                         @"GPUImagePosterizeFilter",
                         @"GPUImagePrewittEdgeDetectionFilter",
                         @"GPUImageRGBClosingFilter",
                         @"GPUImageRGBDilationFilter",
                         @"GPUImageRGBErosionFilter",
                         @"GPUImageRGBFilter",
                         @"GPUImageRGBOpeningFilter",
                         //                         @"GPUImageSaturationBlendFilter",
                         @"GPUImageSaturationFilter",
                         //                         @"GPUImageScreenBlendFilter",
                         @"GPUImageSepiaFilter",
                         @"GPUImageSharpenFilter",
                         //                         @"GPUImageShiTomasiFeatureDetectionFilter",
                         @"GPUImageSingleComponentGaussianBlurFilter",
                         @"GPUImageSketchFilter",
                         @"GPUImageSmoothToonFilter",
                         @"GPUImageSobelEdgeDetectionFilter",
                         @"GPUImageSoftEleganceFilter",
                         //                         @"GPUImageSoftLightBlendFilter",
                         //                         @"GPUImageSourceOverBlendFilter",
                         @"GPUImageSphereRefractionFilter",
                         @"GPUImageStretchDistortionFilter",
                         //                         @"GPUImageSubtractBlendFilter",
                         @"GPUImageSwirlFilter",
                         //                         @"GPUImageThreeInputFilter",
                         @"GPUImageThresholdEdgeDetectionFilter",
                         @"GPUImageThresholdSketchFilter",
                         @"GPUImageThresholdedNonMaximumSuppressionFilter",
                         @"GPUImageTiltShiftFilter",
                         @"GPUImageToneCurveFilter",
                         @"GPUImageToonFilter",
                         @"GPUImageTransformFilter",
                         //                         @"GPUImageTwoInputCrossTextureSamplingFilter",
                         //                         @"GPUImageTwoInputFilter",
                         @"GPUImageTwoPassFilter",
                         @"GPUImageTwoPassTextureSamplingFilter",
                         @"GPUImageUnsharpMaskFilter",
                         @"GPUImageVignetteFilter",
                         @"GPUImageVoronoiConsumerFilter",
                         @"GPUImageWeakPixelInclusionFilter",
                         @"GPUImageWhiteBalanceFilter",
                         @"GPUImageXYDerivativeFilter",
                         @"GPUImageZoomBlurFilter",
                         @"GPUImageiOSBlurFilter",
                         //                         @"GPUimageDirectionalSobelEdgeDetectionFilter"
                         ];
    }
    return _filterArray;
}

@end
