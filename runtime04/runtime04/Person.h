//
//  Person.h
//  runtime04
//
//  Created by Yuan Le on 2018/9/29.
//  Copyright © 2018年 Yuan Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign)int age;
@property (nonatomic,strong)NSString* nick;

@end
