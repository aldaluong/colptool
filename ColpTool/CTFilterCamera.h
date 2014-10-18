//
//  CTFilterCamera.h
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GPUImageView;
@class GPUImageVideoCamera;

@interface CTFilterCamera : NSObject

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;

- (void)setupFilterCamera:(GPUImageView *)filterView;
- (void)toggleTorch;
- (void)toggleFilter;

@property (nonatomic, assign) BOOL torchIsOn;
@property (nonatomic, assign) BOOL filterIsOn;

@end
