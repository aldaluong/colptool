//
//  CTViewfinderView.h
//  ColpTool
//
//  Created by Alda Luong on 10/8/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTViewfinderView : UIView
@property (nonatomic, copy) void (^flashModeToggleActionBlock)();
@property (nonatomic, copy) void (^gridToggleActionBlock)(BOOL on);
@property (nonatomic, copy) void (^filterToggleActionBlock)();
@property (nonatomic, copy) void (^toggleRecordActionBlock)();
@property (nonatomic, copy) void (^takePhotoActionBlock)();
@property (nonatomic, copy) void (^toggleVideoActionBlock)(BOOL photoOn);
@end
