//
//  main.m
//  runtime01
//
//  Created by Yuan Le on 2018/9/26.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/message.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Person* p = [Person new];
//        [p run];
        
        //上面两行代码的底层实现
        Person* p = objc_msgSend(objc_getClass("Person"), sel_registerName("new"));
        objc_msgSend(p, sel_registerName("run"));
        
       // sel_registerName 等价于 @selector(run)，可以通过 NSLog(@"%p,%p",@selector(run),sel_registerName("run"))得到结果，如以如下等价
        /**
         *等价
         objc_msgSend((p, sel_registerName("run"));
         objc_msgSend((p, @selector(run));
         */
        
        
    }
    return 0;
}
