//
//  CTCamera.h
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTCamera : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *cameraPicker;
@property (nonatomic, assign) UIImagePickerControllerCameraFlashMode flashMode;
-(BOOL)flashAvailable;
-(BOOL)flashOn;
-(void)setupGreenFilterCamera;
-(UIImagePickerControllerCameraFlashMode)flashMode;

@end
