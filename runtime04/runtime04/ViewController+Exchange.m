//
//  ViewController+Exchange.m
//  runtime04
//
//  Created by Yuan Le on 2018/9/29.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import "ViewController+Exchange.h"
#import <objc/runtime.h>

@implementation UIViewController (Exchange)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method m2 = class_getInstanceMethod(self, @selector(xyc_viewWillAppear:));
        method_exchangeImplementations(m1, m2);
    });
}
-(void)xyc_viewWillAppear:(BOOL)animated{
    NSLog(@"%s",__func__);

}
@end
