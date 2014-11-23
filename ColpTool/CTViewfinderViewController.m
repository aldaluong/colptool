//
//  CTViewfinderViewController.m
//  ColpTool
//
//  Created by Alda Luong on 10/8/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTViewfinderViewController.h"
#import "CTViewfinderView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CTImports.h"
#import <GPUImage/GPUImageView.h>
#import <GPUImage/GPUImageVideoCamera.h>
#import <AVFoundation/AVCaptureDevice.h>

@interface CTViewfinderViewController ()

@property (nonatomic, strong) CTFilterCamera *camera;
@property (nonatomic, strong) CTViewfinderView *cameraViewOverlayView;
@property (nonatomic, strong) GPUImageView *filterView;

@end

@implementation CTViewfinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filterView = (GPUImageView *)self.view;
    self.filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    self.cameraViewOverlayView = [[CTViewfinderView alloc] initWithFrame:self.view.bounds];
    [self.filterView addSubview:self.cameraViewOverlayView];
    [self.filterView setBackgroundColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.camera = [CTSharedServiceLocator sharedServiceLocator].filterCamera;
    
    [self.camera setupFilterCamera:self.filterView];
    
    // Record a movie for 10 s and store it in /Documents, visible via iTunes file sharing
   /* NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    [filter addTarget:movieWriter];
    
    [videoCamera startCameraCapture];
    
    double delayToStartRecording = 0.5;
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, delayToStartRecording * NSEC_PER_SEC);
    dispatch_after(startTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Start recording");
    });*/
    
     CTWeakSelf weakSelf = self;
     self.cameraViewOverlayView.flashModeToggleActionBlock = ^() {
         CTStrongSelf strongSelf = weakSelf;
         [strongSelf toggleFlashMode];
     };
    
    /*
     self.cameraViewOverlayView.gridToggleActionBlock = ^(BOOL on) {
     CTStrongSelf strongSelf = weakSelf;
     };*/
    
     self.cameraViewOverlayView.filterToggleActionBlock = ^() {
         CTStrongSelf strongSelf = weakSelf;
         [strongSelf toggleFilter];
     };
    
    UIGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchRecognizer.delegate = self;
    [self.view addGestureRecognizer:pinchRecognizer];
    /*
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
     */
}

/*
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSNumber *zoomScale = [NSNumber numberWithFloat:[recognizer scale]];
        NSLog(@"zoom scale - %@", zoomScale);
        CGFloat currentZoom;
        static CGFloat lastZoom = 1.0f;
        AVCaptureDevice *device = self.camera.videoCamera.inputCamera;
        CGFloat maxZoom = device.activeFormat.videoMaxZoomFactor;
        CGFloat minZoom = 1.0f;
        CGFloat zoomScaleFloat = [zoomScale floatValue];
        
        currentZoom = zoomScaleFloat;
        
         if (zoomScaleFloat < 1) {
             currentZoom = lastZoom - zoomScaleFloat*5;
         } else {
             currentZoom = zoomScaleFloat/10 + lastZoom;
         }
        
        currentZoom = currentZoom >= maxZoom ? maxZoom : currentZoom;
        currentZoom = currentZoom < minZoom ? minZoom : currentZoom;
        
        [device lockForConfiguration:nil];
        
        [device rampToVideoZoomFactor:currentZoom withRate:1.0f];
        
        [device unlockForConfiguration];
        
        lastZoom = currentZoom;
    }
}*/

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    AVCaptureDevice *device = self.camera.videoCamera.inputCamera;
    static CGFloat lastScale = 1.0;
    static CGFloat currentScale = 0;
    CGFloat maxZoom = 5.0f; //device.activeFormat.videoMaxZoomFactor;
    CGFloat minZoom = 1.0f;
    CGFloat delta = 0.0f;

    switch ([recognizer state]) {
        //case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            
            delta = [recognizer scale] - lastScale;
            
            NSLog(@"currentScale - %f, recognizerScale - %f, lastScale - %f, delta - %f", currentScale, [recognizer scale], lastScale,delta);

            currentScale += delta;
            
            currentScale = CLAMP(currentScale, minZoom, maxZoom);
            lastScale = [recognizer scale];
            
            [device lockForConfiguration:nil];
            device.videoZoomFactor = currentScale;
            [device unlockForConfiguration];
             
            /*
            CGAffineTransform currentTransform = CGAffineTransformIdentity;
            CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, currentScale, currentScale);
            self.filterView.transform = newTransform;
            */
            break;
            
        case UIGestureRecognizerStateEnded:
            lastScale = 1.0f;
            break;
            
        default:
             lastScale = 1.0f;
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self presentViewController:self.camera.cameraPicker animated:YES completion:nil];
    //self.camera.cameraPicker.cameraOverlayView = self.cameraViewOverlayView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleFlashMode {
    [self.camera toggleTorch];
}

- (void)toggleFilter {
    [self.camera toggleFilter];
}
@end
