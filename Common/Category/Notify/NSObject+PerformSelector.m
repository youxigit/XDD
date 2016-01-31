//
//  NSObject+PerformSelector.m
//  XDD
//
//  Created by xdd on 15/9/9.
//  Copyright (c) 2015年 xdd-studio. All rights reserved.
//

#import "NSObject+PerformSelector.h"
#import "NSMutableArray+Extension.h"
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <foundation/NSString.h>

typedef NS_ENUM(int32_t, PerformParamterType)
{
    PerformParamterTypeUnknown,
    PerformParamterTypeLongLong,
    PerformParamterTypeUnsignedLongLong,
    PerformParamterTypeDouble,
    PerformParamterTypeFloat,
    PerformParamterTypeNSString,
    PerformParamterTypeCGRect,
    PerformParamterTypeCGPoint,
    PerformParamterTypeCGSize,
};

typedef int64_t QINT64;
typedef UInt64  QUINT64;

#define TRANSLATE(ctype, type) \
        if (strcmp(encodingCString, @encode(ctype)) == 0) { \
        return type; \
        }

@implementation NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withParams:(NSArray*)params
{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil)
    {
        NSString *info = [NSString stringWithFormat:@" -[%@ %@] : 未知方法", [self class], NSStringFromSelector(aSelector)];
        NSLog(@"%@", info);
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
 
    NSUInteger arguments = signature.numberOfArguments - 2;
    NSUInteger objectsCount = params.count;
    NSUInteger count = MIN(arguments, objectsCount);
    
    for (int i = 0; i < count; i++)
    {
        NSString *strParam = [params objectAtIndex:i];
        const char* paramType = [signature getArgumentTypeAtIndex:i + 2];
        PerformParamterType type = [self parameterTypeForEncoding:@(paramType)];
        
        switch (type)
        {
            case PerformParamterTypeLongLong:
            {
                QINT64 value = [strParam longLongValue];
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            case PerformParamterTypeUnsignedLongLong:
            {
                QUINT64 value = [strParam longLongValue];
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            case PerformParamterTypeDouble:
            {
                double value = [strParam doubleValue];
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            case PerformParamterTypeFloat:
            {
                float value = [strParam floatValue];
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            case PerformParamterTypeNSString:
            {
                [invocation setArgument:&strParam atIndex:i + 2];
            }
                break;
            case PerformParamterTypeCGRect:
            {
                CGRect value = CGRectFromString(strParam);
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            case PerformParamterTypeCGPoint:
            {
                CGPoint value = CGPointFromString(strParam);
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            case PerformParamterTypeCGSize:
            {
                CGSize value = CGSizeFromString(strParam);
                [invocation setArgument:&value atIndex:i + 2];
            }
                break;
            default:
                break;
        }
    }
    
    [invocation invoke];
    
    id __unsafe_unretained res = nil;
    if ( signature.methodReturnLength != 0)
    {
        [invocation getReturnValue:&res];
    }
    
    return res;
}

/**转换支持的参数类型*/
- (PerformParamterType)parameterTypeForEncoding:(NSString *)encodingString
{
    if (!encodingString)
    {
        return PerformParamterTypeUnknown;
    }

    const char *encodingCString = [encodingString UTF8String];

    if (encodingCString[0] == '@')
    {
        return PerformParamterTypeNSString;
    }
    
    TRANSLATE(CGRect, PerformParamterTypeCGRect);
    TRANSLATE(CGPoint, PerformParamterTypeCGPoint);
    TRANSLATE(CGSize, PerformParamterTypeCGSize);
    TRANSLATE(NSInteger, PerformParamterTypeLongLong);
    TRANSLATE(NSUInteger, PerformParamterTypeLongLong);
    TRANSLATE(CGFloat, PerformParamterTypeFloat);
    TRANSLATE(BOOL, PerformParamterTypeLongLong);
    TRANSLATE(int, PerformParamterTypeLongLong);
    TRANSLATE(short, PerformParamterTypeLongLong);
    TRANSLATE(long, PerformParamterTypeLongLong);
    TRANSLATE(long long, PerformParamterTypeLongLong);
    TRANSLATE(unsigned char, PerformParamterTypeLongLong);
    TRANSLATE(unsigned int, PerformParamterTypeLongLong);
    TRANSLATE(unsigned short, PerformParamterTypeLongLong);
    TRANSLATE(unsigned long, PerformParamterTypeLongLong);
    TRANSLATE(unsigned long long, PerformParamterTypeUnsignedLongLong);
    TRANSLATE(float, PerformParamterTypeFloat);
    TRANSLATE(double, PerformParamterTypeDouble);
    TRANSLATE(long double, PerformParamterTypeDouble);

    return PerformParamterTypeUnknown;
}

@end
