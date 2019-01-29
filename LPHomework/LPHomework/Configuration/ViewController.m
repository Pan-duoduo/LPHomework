//
//  ViewController.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/24.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addMainView];
}

- (void)addMainView {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LPScreen_W, LPScalePX(80))];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)push {
    
    
}

@end
