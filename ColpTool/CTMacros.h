//
//  CTMacros.h
//  ColpTool
//
//  Created by Alda Luong on 10/9/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#ifndef ColpTool_CTMacros_h
#define ColpTool_CTMacros_h

/// For when you need a weak reference of an object, example: 'CTWeakObject(obj) wobj = obj;'
#define CTWeakObject(o) __typeof__(o) __weak
#define CTStrongObject(o) __typeof__(o) __strong

/// For when you need a weak reference to self, example: 'CTWeakSelf wself = self;'
#define CTWeakSelf CTWeakObject(self)
#define CTStrongSelf CTStrongObject(self)


#endif
