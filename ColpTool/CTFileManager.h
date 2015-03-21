//
//  CTFileManager.h
//  ColpTool
//
//  Created by aluong on 3/20/15.
//  Copyright (c) 2015 Alda Luong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFileManager : NSObject


- (NSString*)videoPathWithFilename:(NSString *)fileName;
- (NSString*)generateRandomVideoFilePath;

@end
