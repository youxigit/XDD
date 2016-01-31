//
//  SingletonDef.h
//  FMFeiMaShiShop
//
//  Created by xdd on 15/9/7.
//  Copyright (c) 2015年 xdd-studio. All rights reserved.
//

#pragma mark - 单列宏
/**
 //  单例类 .h文件定义：AS_SINGLETON(className)
 //        .m文件定义：DEF_SINGLETON(className)
 //  调用方式为: [className sharedInstance] xxx
 */
#undef	AS_SINGLETON
#define AS_SINGLETON(__class) \
    + (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON(__class) \
    + (__class *)sharedInstance \
    { \
        static dispatch_once_t once; \
        static __class *__singleton__; \
        dispatch_once(&once, ^{__singleton__ = [[__class alloc] init];}); \
        return __singleton__; \
    }

#pragma mark -