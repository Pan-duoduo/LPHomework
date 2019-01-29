//
//  LPHomeViewController.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/25.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "LPHomeViewController.h"
#import "LPHomeView.h"
#import "LPHomeViewModel.h"
#import "LPHomeModel.h"

@interface LPHomeViewController ()

@property (nonatomic, strong) LPHomeView *mvvmView;
@property (nonatomic, strong) LPHomeViewModel *viewModel;
@property (nonatomic, strong) LPHomeModel *model;

@end

@implementation LPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.model = [LPHomeModel new];
    self.mvvmView = [LPHomeView new];
    self.viewModel = [LPHomeViewModel new];
    
    _mvvmView.frame = self.view.bounds;
    [self.view addSubview:_mvvmView];
    
    [self GCD];
}

- (void)GCD {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"HELLOC CC");
    });
}

@end
