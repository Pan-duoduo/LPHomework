//
//  LPHomeView.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/25.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "LPHomeView.h"

@interface LPHomeView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LPHomeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        _titleLabel.frame = CGRectMake(100, 100, 100, 100);
        _titleLabel.textColor = [UIColor redColor];
    }
    return self;
}

@end
