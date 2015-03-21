//
//  CTSharedServiceLocator.m
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTSharedServiceLocator.h"
#import "CTImports.h"
#import "CTFileManager.h"

static CTSharedServiceLocator *sharedServiceLocator = nil;

@implementation CTSharedServiceLocator
@synthesize camera = _camera;
@synthesize filterCamera = _filterCamera;
@synthesize fileManager = _fileManager;

+(instancetype)sharedServiceLocator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedServiceLocator = [[self alloc] init];
    });
    return sharedServiceLocator;
}

- (id)init
{
    if (self = [super init]) {
    }
    
    return self;
}

- (CTCamera *)camera
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_camera = [[CTCamera alloc] init];
    });
    return _camera;
}

- (CTFilterCamera *)filterCamera
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_filterCamera = [[CTFilterCamera alloc] init];
    });
    return _filterCamera;
}

- (CTFileManager *)fileManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_fileManager = [[CTFileManager alloc] init];
    });
    return _fileManager;
}

@end
