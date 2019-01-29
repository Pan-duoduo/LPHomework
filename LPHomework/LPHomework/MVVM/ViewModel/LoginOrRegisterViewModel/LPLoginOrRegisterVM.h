//
//  LPLoginOrRegisterVM.h
//  LPHomework
//
//  Created by 刘潘 on 2019/1/28.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPLoginOrRegisterVM : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSignal *btnEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommand;


@end

NS_ASSUME_NONNULL_END
