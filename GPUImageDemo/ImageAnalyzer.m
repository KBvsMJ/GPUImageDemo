//
//  ImageAnalyzer.m
//  GPUImageDemo
//
//  Created by casa on 4/3/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "ImageAnalyzer.h"

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )

@implementation ImageAnalyzer

- (CGFloat)brightnessOfImage:(UIImage *)image
{
    CGImageRef inputCGImage = [image CGImage];
    NSUInteger width = CGImageGetWidth(inputCGImage);
    NSUInteger height = CGImageGetHeight(inputCGImage);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    UInt32 * pixels;
    pixels = (UInt32 *) calloc(height * width, sizeof(UInt32));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputCGImage);

    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);

    NSInteger brightnessList[50] = {0};
    NSInteger index = 0;

    UInt32 * currentPixel = pixels;
    for (NSUInteger j = 0; j < height; j++) {
        for (NSUInteger i = 0; i < width; i++) {
            UInt32 color = *currentPixel;
            CGFloat brightness = (R(color)+G(color)+B(color))/3.0f;
            
            index = brightness/5;
            NSInteger count = brightnessList[index];
            count++;
//            brightnessList[index] = count;
            
            currentPixel++;
        }
    }

    free(pixels);
    
    CGFloat totalSum = 0;
    for (int i = 0; i < 50; i++) {
        totalSum += brightnessList[i];
    }
    
    CGFloat totalBrightness = 0;
    for (int i = 0; i < 50; i++) {
        CGFloat rate = (CGFloat)(brightnessList[i]) / totalSum;
        totalBrightness += (i * 5 * rate);
    }
    
    return totalBrightness;
}

- (CGFloat)saturationOfImage:(UIImage *)image
{
    return 0;
}

@end
