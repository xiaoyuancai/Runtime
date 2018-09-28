//
//  Person.m
//  runtime01
//
//  Created by Yuan Le on 2018/9/26.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

+ (void) run {
    NSLog(@"%s", __func__);
}

-(void)sing{
    NSLog(@"%s", __func__);
}

void sing(){
    NSLog(@"%s", __func__);
}

/**
 找不到类方法就会通过此方法进行动态解析

 @param sel 方法
 @return bool值
 */
+(BOOL)resolveClassMethod:(SEL)sel{
    
    NSLog(@"not found %s",__func__);
    //没有找到，但是我们可以动态添加方法
    if (sel==@selector(walk)) {
        
        Method runMethod = class_getClassMethod(self, @selector(run));
        IMP runImp = method_getImplementation(runMethod);
        const char* types = method_getTypeEncoding(runMethod);
        return class_addMethod(object_getClass(self), sel, runImp, types);
    }
    
    return [super resolveClassMethod:sel];
}


/**
 找不到实例方法就会通过此方法进行动态解析

 @param sel 方法
 @return bool
 */
+(BOOL)resolveInstanceMethod:(SEL)sel{
 
    NSLog(@"not found %s",__func__);
    
    //没有找到，但是我们可以动态添加方法
    //添加方式一，添加C方法
//    if (sel==@selector(eat)) {
//        return class_addMethod(self, sel, (IMP)sing, "v@:");
//    }
    
    //添加方式二，添加OC方法
    if (sel==@selector(eat)) {

        Method runMethod = class_getInstanceMethod(self, @selector(sing));
        IMP runImp = method_getImplementation(runMethod);
        const char* types = method_getTypeEncoding(runMethod);
        return class_addMethod(self, sel, runImp, types);
    }
    return [super resolveInstanceMethod:sel];
}

@end
