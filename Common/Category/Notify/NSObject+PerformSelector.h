//
//  NSObject+PerformSelector.h
//  XDD
//
//  Created by xdd on 15/9/9.
//  Copyright (c) 2015年 xdd-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withParams:(NSArray*)params;

@end
