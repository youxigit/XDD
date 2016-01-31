//
//  UIColor+Ext.h
//  XDD
//
//  Created by xdd on 15/9/9.
//  Copyright (c) 2015年 xdd-studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)

/**正常的RGB值*/
+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

/**RGB的十六进制值*/
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;

@end
