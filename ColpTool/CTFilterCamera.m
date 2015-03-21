//
//  CTFilterCamera.m
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTFilterCamera.h"
#import "GPUImage.h"
#import "CTSharedServiceLocator.h"
#import "CTFileManager.h"

@interface CTFilterCamera()

@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic, assign) BOOL recording;
@property (nonatomic, strong) NSString *pathToMovie;

@property (nonatomic, strong) GPUImageView *filterView;
@end

@implementation CTFilterCamera

-(id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _torchIsOn = NO;
        _filterIsOn = NO;
        _recording = NO;
    }
    return self;
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

-(void)toggleRecord
{
    if (self.recording) {
        [self stopRecording];
    } else {
        [self startRecording];
    }
}

- (void)setupFilterCamera:(GPUImageView *)filterView
{
    self.filterView = filterView;
    self.recording = NO;
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    //self.filter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomShader"];
    self.filter = [[GPUImageRGBFilter alloc] init];
    [self.videoCamera addTarget:self.filter];

    [self setupMovieWriter];
    [self.filter addTarget:self.filterView];
    
    [self.videoCamera startCameraCapture];
}

- (void)setupMovieWriter
{
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    self.pathToMovie = pathToMovie;
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *pathToMovieURL = [NSURL fileURLWithPath:pathToMovie];
    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:pathToMovieURL size:CGSizeMake(480.0, 640.0)];
    self.movieWriter.encodingLiveVideo = YES;
    
    [self.filter addTarget:self.movieWriter];
}

-(void)startRecording
{
    [self setupMovieWriter];
    [self.filter addTarget:self.movieWriter];
    [self.movieWriter startRecording];
    self.recording = YES;
    NSLog(@"Movie started");
}

-(void)stopRecording
{
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (self.pathToMovie)) {
        UISaveVideoAtPathToSavedPhotosAlbum (self.pathToMovie, nil, nil, nil);
        self.pathToMovie = nil;
    }
    
    [self.filter removeTarget:self.movieWriter];
    self.videoCamera.audioEncodingTarget = nil;
    [self.movieWriter finishRecording];
    self.recording = NO;
    NSLog(@"Movie completed");
}

-(void)takePhoto
{
    
}




@end
