//
//  LPBaseTableView.m
//  DigitalSchool
//
//  Created by 刘潘 on 2018/5/14.
//  Copyright © 2018年 Pan. All rights reserved.
//

#import "LPBaseTableView.h"

@implementation LPBaseTableView

/**
同时识别多个手势

@param gestureRecognizer gestureRecognizer description
@param otherGestureRecognizer otherGestureRecognizer description
@return return value description
*/
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
