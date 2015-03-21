//
//  CTSharedServiceLocator.h
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CTCamera;
@class CTFilterCamera;
@class CTFileManager;

@interface CTSharedServiceLocator : NSObject

/** Returns the shared instance of the service locator */
+ (instancetype)sharedServiceLocator;

@property (nonatomic, strong, readonly) CTCamera *camera;
@property (nonatomic, strong, readonly) CTFilterCamera *filterCamera;
@property (nonatomic, strong, readonly) CTFileManager *fileManager;

@end
