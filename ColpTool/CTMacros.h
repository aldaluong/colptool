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

#define MIN(A,B)    ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })
#define MAX(A,B)    ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __b : __a; })

#define CLAMP(x, low, high) ({\
__typeof__(x) __x = (x); \
__typeof__(low) __low = (low);\
__typeof__(high) __high = (high);\
__x > __high ? __high : (__x < __low ? __low : __x);\
})


#endif
