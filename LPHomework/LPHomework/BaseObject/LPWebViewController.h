//
//  LPWebViewController.h
//  DigitalSchool
//
//  Created by Pan on 2018/4/11.
//  Copyright © 2018年 Pan. All rights reserved.
//

/** H5页面(新) */

#import <UIKit/UIKit.h>

@interface LPWebViewController : LPBaseViewController

@property(nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *titleStr;         // 标题（特别写明，区别分享和多层wang'ye）
@property(nonatomic, copy) NSString *shareImage;        //
@property (nonatomic, copy) NSString *shareDesc;        // 分享描述
@property (nonatomic, copy) NSString *shareUrl;         // 分享链接
@property (nonatomic, assign) BOOL share;               // 是否支持显示分享：默认不显示分享。

/** 统计 */
@property (nonatomic, copy) NSString *eventID;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *allEventId;
@property (nonatomic, copy) NSString *allEventName;

@end
