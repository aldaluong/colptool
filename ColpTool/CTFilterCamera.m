//
//  CTFilterCamera.m
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTFilterCamera.h"
#import "GPUImage.h"

@interface CTFilterCamera()
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;

@end

@implementation CTFilterCamera

-(id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
    }
    return self;
}



 - (void)setupGreenFilterCamera
{
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];

    //GPUImageFilter *customFilter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomShader"];
    GPUImageFilter *filter = [[GPUImageColorInvertFilter alloc] init];
    GPUImageView *filteredVideoView = [[GPUImageView alloc] initWithFrame:CGRectMake(50.0, 50.0, 200, 200)];

    // Add the view somewhere so it's visible
    //[self.view addSubview:filteredVideoView];

    [videoCamera addTarget:filter];
    [filter addTarget:filteredVideoView];

    [videoCamera startCameraCapture];
}


@end
