//
//  LPBaseObject.h
//  DigitalSchool
//
//  Created by Pan on 2017/10/25.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPBaseObject : NSObject

@property (nonatomic, assign) NSNumber *Id;                     // id


//- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
//+ (NSDictionary *)modelContainerPropertyGenericClass;

/** 属性矫正 */
+ (NSDictionary *)modelCustomPropertyMapper;
/** 数组对象矫正 */
+ (NSDictionary *)modelContainerPropertyGenericClass;

@end


