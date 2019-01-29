//
//  LPBaseObject.m
//  DigitalSchool
//
//  Created by Pan on 2017/10/25.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import "LPBaseObject.h"

@implementation LPBaseObject

//- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
//    return self;
//}

/** 属性矫正 */
+ (NSDictionary *)modelCustomPropertyMapper {
    
    NSDictionary *dic=@{@"Id" :@"id"};
    return dic;
}

/** 数组对象矫正 */
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return nil;
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//        if ([key isEqualToString:@"id"]) {
//            _Id = (NSInteger)value;
//        }
//}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    
//    return @{@"pid":[LPFunctionItemObject class]};
//}

@end
