//
//  LPMineController.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/29.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "LPMineController.h"
#import "LPMineVM.h"
#import "LPMineCell.h"
#import "LPMineHeaderView.h"

@interface LPMineController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) LPMineVM *mineVM;
@property (nonatomic, strong) LPMineHeaderView *headerView;

@end

@implementation LPMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addMainView];
}

- (void)addMainView {
    
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.headerView;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (LPMineHeaderView *)headerView {
    if (!_headerView) {
//        _headerView = [LPMineHeaderView alloc] initWithFrame:<#(CGRect)#>
    }
    return _headerView;
}


#pragma mark ============================== 代理 ==============================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LPScalePX(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    LPMineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LPMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    return cell;
}


@end
