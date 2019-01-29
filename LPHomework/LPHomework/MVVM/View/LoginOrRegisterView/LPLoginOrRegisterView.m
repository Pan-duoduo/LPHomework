//
//  LPLoginOrRegisterView.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/28.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "LPLoginOrRegisterView.h"

@implementation LPLoginOrRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createUI];
    }
    
    return self;
}

- (void)createUI {
    
    
    self.acountTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, LPScalePX(500), LPScalePX(100))];
    self.acountTF.center = CGPointMake(LPScreen_W / 2.0, LPScalePX(300));
    self.acountTF.layer.borderWidth = 1.0f;
    self.acountTF.layer.borderColor = LPColorWithHex(0x333333).CGColor;
    self.acountTF.placeholder = @"请输入用户名";
    
    self.passworkTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, LPScalePX(500), LPScalePX(100))];
    self.passworkTF.center = CGPointMake(LPScreen_W / 2.0, CGRectGetMaxY(self.acountTF.frame) +  LPScalePX(100));
    self.passworkTF.layer.borderWidth = 1.0f;
    self.passworkTF.layer.borderColor = LPColorWithHex(0x333333).CGColor;
    self.passworkTF.placeholder = @"请输入密码";
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LPScreen_W - LPScalePX(100), LPScalePX(100))];
    self.loginButton.center = CGPointMake(LPScreen_W / 2.0, CGRectGetMaxY(self.passworkTF.frame) + LPScalePX(100));
    self.loginButton.backgroundColor = [UIColor redColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    
    [self addSubview:self.acountTF];
    [self addSubview:self.passworkTF];
    [self addSubview:self.loginButton];
    
    self.acountTF.userInteractionEnabled = YES;
}


@end
