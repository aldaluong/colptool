//
//  NSString+CTAdditions.m
//  ColpTool
//
//  Created by aluong on 3/20/15.
//  Copyright (c) 2015 Alda Luong. All rights reserved.
//

#import "NSString+CTAdditions.h"

@implementation NSString(CTAdditions)

+ (NSString*)createUUID
{
    return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
