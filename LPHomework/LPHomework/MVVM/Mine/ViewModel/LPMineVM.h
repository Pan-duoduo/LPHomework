//
//  LPMineVM.h
//  LPHomework
//
//  Created by 刘潘 on 2019/1/29.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPMineVM : NSObject

// command处理实际事务  网络请求
@property (nonatomic, strong) RACCommand *mineCommand;


@end

NS_ASSUME_NONNULL_END
