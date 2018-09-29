//
//  Person.m
//  runtime04
//
//  Created by Yuan Le on 2018/9/29.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    //不用runtime的做法
//    [aCoder encodeObject:_name forKey:@"name"];
//    [aCoder encodeObject:@(_age) forKey:@"age"];
//    [aCoder encodeObject:_nick forKey:@"nick"];
    
    //使用runtime
    //获取所有属性
    unsigned int count = 0;
    //获取属性列表，class_copyIvarList获取实例变量列表
    objc_property_t* ivar = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t pro = ivar[i];
        const char* name = property_getName(pro);//实例变量ivar_getName
        NSString* key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivar);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self==[super init]) {
        unsigned int count = 0;
        //获取属性列表，class_copyIvarList获取实例变量列表
        objc_property_t* ivar = class_copyPropertyList([self class], &count);
        for (int i = 0; i<count; i++) {
            objc_property_t pro = ivar[i];
            const char* name = property_getName(pro);//实例变量ivar_getName
            NSString* key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivar);
        return self;
    } 
    return self;
}

@end
