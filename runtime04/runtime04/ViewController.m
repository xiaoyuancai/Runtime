//
//  ViewController.m
//  runtime04
//
//  Created by Yuan Le on 2018/9/29.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //简单使用runtime动态添加类、方法、实例变量
//    [self dynamicAdd];
    
    //简单使用runtime进行归档和解档
    
    Person* per = [Person new];
    per.name = @"xiaoyuancai";
    per.age = 18;
    per.nick = @"cai";
    
    NSString* path = [NSString stringWithFormat:@"%@/archiver.plist",NSHomeDirectory()];//当档路径
    
    
    if ([NSKeyedArchiver archiveRootObject:per toFile:path]/*归档*/) {
        //解档
        id data =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSLog(@"data = %@",data);
    }
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //方法交换，代码查看ViewController+Exchange.m文件
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

void print(){
    NSLog(@"%s",__func__);
}

-(void)dynamicAdd{
    
    //动态创建一个类
    Class Cat = objc_allocateClassPair([NSObject class], "Cat", 0);
    
    //动态添加实例变量，一定要放在注册之前
    NSString* name = @"name";
    class_addIvar(Cat, name.UTF8String, sizeof(id), log2(sizeof(id)), @encode(id));
    
    //动态添加方法
    class_addMethod(Cat, @selector(print), (IMP)print, "v@:");
    
    //注册类
    objc_registerClassPair(Cat);
    
    //使用类
    id cat = [[Cat alloc]init];
    [cat performSelector:@selector(print)];
    [cat setValue:@"xiaoyuancai" forKey:name];
    NSString* nameRes = [cat valueForKey:name];
    NSLog(@"name is %@",nameRes);
    
    //注意，一旦类进行了注册操作，之后就不能再进行动态添加变量的操作了
//    NSString* age = @"age";
//    class_addIvar(Cat, age.UTF8String, sizeof(id), log2(sizeof(id)), @encode(id));
//    [cat setValue:@"20" forKey:age];
    
}


@end
