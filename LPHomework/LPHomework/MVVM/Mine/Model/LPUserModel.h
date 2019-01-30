//
//  LPUserModel.h
//  LPHomework
//
//  Created by 刘潘 on 2019/1/29.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPUserModel : LPBaseObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userHeader;
@property (nonatomic, copy) NSString *userPosition;

@end

NS_ASSUME_NONNULL_END
