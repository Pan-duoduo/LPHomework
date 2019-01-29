//
//  LPLoginOrRegisterVM.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/28.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "LPLoginOrRegisterVM.h"

@implementation LPLoginOrRegisterVM

- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    // RACObserve可以吧KVO转化为信号
    self.btnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, password)] reduce:^id _Nonnull{
        return @(self.account.length && self.password.length >= 6);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"组合参数， 准备发送登录请求 -- %@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"开始请求数据");
            NSLog(@"请求成功");
            NSLog(@"处理数据");
            
            [subscriber sendNext:@"请求完成，数据给你"];
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行中....");
        }else {
            NSLog(@"执行结束了！！！！");
        }
    }];
}

@end
