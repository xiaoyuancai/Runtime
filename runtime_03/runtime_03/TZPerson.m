//
//  TZPerson.m
//  Runtime001
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZPerson.h"
#import "TZDog.h"
#import <objc/runtime.h>

@implementation TZPerson

//类方法消息转发
+ (id) forwardingTargetForSelector:(SEL)aSelector {
    
//    if (aSelector == @selector(walk)) {
//        return [TZDog new];
//    }
//
    return [super forwardingTargetForSelector:aSelector];
}

/// 方法名注册
+ (NSMethodSignature* ) methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(walk)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void) forwardInvocation:(NSInvocation *)anInvocation {



   // [anInvocation invokeWithTarget:[TZDog new]];

    /// 转发给自己
    anInvocation.selector = @selector(run);
    anInvocation.target = self;
    [anInvocation invoke];
}

+ (void) run {
    NSLog(@"%s", __func__);
}

//实例方法消息转发
-(id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(eat)) {
//        return [TZDog new];
//    }
    
    return [super forwardingTargetForSelector:aSelector];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(eat)) {

        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    anInvocation.selector = @selector(sing);
    anInvocation.target = self;
    [anInvocation invoke];
}

-(void) sing{
    NSLog(@"%s", __func__);
}

@end
