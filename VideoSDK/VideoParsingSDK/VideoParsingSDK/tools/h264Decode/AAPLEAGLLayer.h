/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  This CAEAGLLayer subclass demonstrates how to draw a CVPixelBufferRef using OpenGLES and display the timecode associated with that pixel buffer in the top right corner.
  
 */

//@import QuartzCore;
#include <QuartzCore/QuartzCore.h>
#include <CoreVideo/CoreVideo.h>
#import <UIKit/UIKit.h>

@interface AAPLEAGLLayer : CAEAGLLayer
@property CVPixelBufferRef pixelBuffer;
@property(strong,nonatomic) UIView *parentView;

- (id)init;
- (void)resetRenderBuffer;
@end
