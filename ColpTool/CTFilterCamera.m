//
//  CTFilterCamera.m
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTFilterCamera.h"
#import <GPUImage/GPUImageView.h>
#import <GPUImage/GPUImageVideoCamera.h>
#import <GPUImage/GPUImageRGBFilter.h>

@interface CTFilterCamera()

@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;

@end

@implementation CTFilterCamera

-(id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _torchIsOn = NO;
        _filterIsOn = NO;
    }
    return self;
}

- (void)setupFilterCamera:(GPUImageView *)filterView
{
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    //self.filter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomShader"];
    self.filter = [[GPUImageRGBFilter alloc] init];
    [self.videoCamera addTarget:self.filter];
    [self.filter addTarget:filterView];
    [self.videoCamera startCameraCapture];
}

- (void)toggleFilter
{
    if (self.filterIsOn) {
        [(GPUImageRGBFilter *)self.filter setGreen:1.0f];
        [(GPUImageRGBFilter *)self.filter setBlue:1.0f];
        [(GPUImageRGBFilter *)self.filter setRed:1.0f];
        self.filterIsOn = NO;
    } else {
        [(GPUImageRGBFilter *)self.filter setGreen:0.8f];
        [(GPUImageRGBFilter *)self.filter setBlue:.5f];
        [(GPUImageRGBFilter *)self.filter setRed:.3f];
        self.filterIsOn = YES;
    }
}

-(void)toggleTorch
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        if (self.torchIsOn) {
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
            self.torchIsOn = NO;
        } else {
            [device setTorchMode:AVCaptureTorchModeOn];
            [device setFlashMode:AVCaptureFlashModeOn];
            self.torchIsOn = YES;
        }
        [device unlockForConfiguration];
    }
}

@end
