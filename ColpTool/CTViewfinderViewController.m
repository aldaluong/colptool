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
//#import "GPUImage.h"

@interface CTViewfinderViewController ()

@property (nonatomic, strong) CTCamera *camera;
@property (nonatomic, strong) CTViewfinderView *cameraViewOverlayView;

@end

@implementation CTViewfinderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    //[self setupCamera];
    //[self presentViewController:self.cameraPicker animated:NO completion:nil];
    self.camera = [CTSharedServiceLocator sharedServiceLocator].camera;
    self.cameraViewOverlayView = [[CTViewfinderView alloc] initWithFrame:self.view.bounds];
    
    CTWeakSelf weakSelf = self;
    self.cameraViewOverlayView.flashModeToggleActionBlock = ^(BOOL on) {
        CTStrongSelf strongSelf = weakSelf;
        [strongSelf toggleFlashMode];
    };
    /*
    self.cameraViewOverlayView.gridToggleActionBlock = ^(BOOL on) {
        CTStrongSelf strongSelf = weakSelf;
    };*/
    /*
    self.cameraViewOverlayView.filterToggleActionBlock = ^(BOOL on) {
        CTStrongSelf strongSelf = weakSelf;
    };*/
}


- (void)viewDidAppear:(BOOL)animated
{
    [self presentViewController:self.camera.cameraPicker animated:YES completion:nil];
    self.camera.cameraPicker.cameraOverlayView = self.cameraViewOverlayView;
    //[self.camera setupGreenFilterCamera];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleFlashMode {
    if (self.camera.flashMode == UIImagePickerControllerCameraFlashModeOff) {
        self.camera.flashMode = UIImagePickerControllerCameraFlashModeOn;
    } else {
        self.camera.flashMode = UIImagePickerControllerCameraFlashModeOff;
    }
}

/*
- (void)toggleGrid {

}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
