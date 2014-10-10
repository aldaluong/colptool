//
//  CTCamera.m
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTCamera.h"
//#import "GPUImage.h"

@implementation CTCamera

-(id)init
{
    self = [super init];
    if (self) {
        _cameraPicker = [[UIImagePickerController alloc] init];
        _cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        _cameraPicker.mediaTypes = [NSArray arrayWithObject:@"public.movie"]; //[[NSArray alloc] initWithObjects: (NSString *) kUTTypeVideo, nil];
        _cameraPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        
        _cameraPicker.allowsEditing = NO;
        _cameraPicker.showsCameraControls = NO;
        _cameraPicker.cameraViewTransform = CGAffineTransformIdentity;
        
        // not all devices have two cameras or a flash so just check here
        if ( [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear] ) {
            _cameraPicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else {
            _cameraPicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
        if ([self flashAvailable]) {
            _cameraPicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        }
        
        _cameraPicker.videoQuality = UIImagePickerControllerQualityType640x480;
        _cameraPicker.delegate = self;
    }
    return self;
}

-(BOOL)flashAvailable
{
    return [UIImagePickerController isFlashAvailableForCameraDevice:self.cameraPicker.cameraDevice];
}

-(BOOL)flashOn
{
    if ([self flashAvailable]) {
        return (self.cameraPicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn);
    } else {
        return NO;
    }
}

-(UIImagePickerControllerCameraFlashMode)flashMode
{
    return self.cameraPicker.cameraFlashMode;
}

-(void)setFlashMode:(UIImagePickerControllerCameraFlashMode)flashMode
{
    self.cameraPicker.cameraFlashMode = flashMode;
}

@end
