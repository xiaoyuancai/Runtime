//
//  main.m
//  runtime_02
//
//  Created by Yuan Le on 2018/9/26.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

//objc_msgSend执行过程

extern void test();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 动态方法解析
        
        //class method
        [Person walk];
        
        //instance method
        [[Person new]eat];
        
        test();
        
    }
    return 0;
}
