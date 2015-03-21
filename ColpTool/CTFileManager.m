//
//  CTFileManager.m
//  ColpTool
//
//  Created by aluong on 3/20/15.
//  Copyright (c) 2015 Alda Luong. All rights reserved.
//

#import "CTFileManager.h"
#import "NSString+CTAdditions.h"

static NSString * const kCTFileManagerVideoExtension = @"mp4";
static NSString * const kVideoFolder = @"video";

@implementation CTFileManager

- (NSString*)videoPathWithFilename:(NSString *)fileName
{
    NSString *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *fileDirectory = [cacheDirectory stringByAppendingPathComponent:kVideoFolder];
    NSError *error;
    if (![self.defaultFileManager fileExistsAtPath:fileDirectory]) {
        if (![self.defaultFileManager createDirectoryAtPath:fileDirectory
                                withIntermediateDirectories:NO
                                                 attributes:nil
                                                      error:&error]) { //Create folder
            NSLog(@"Failed to create folder %@", fileDirectory);
            return NULL;
        }
    }
    return [fileDirectory stringByAppendingPathComponent:fileName];
}

- (NSString*)generateRandomVideoFilePath
{
    NSString *randomAlphaNumeric = [NSString createUUID];
    NSString *pathToFile = [self videoPathWithFilename:[randomAlphaNumeric stringByAppendingPathExtension:kCTFileManagerVideoExtension]];
    return pathToFile;
}

- (NSFileManager*)defaultFileManager
{
    return [NSFileManager defaultManager];
}

@end
