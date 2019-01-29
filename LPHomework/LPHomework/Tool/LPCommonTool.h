//
//  LPCommonTool.h
//  DigitalSchool
//
//  Created by Pan on 2017/10/31.
//  Copyright © 2017年 Pan. All rights reserved.
//

/** 通用工具类 */

#import <Foundation/Foundation.h>

@interface LPCommonTool : NSObject
@property(nonatomic,assign) NSInteger  messageCount;                    //消息数统计
@property(nonatomic,strong)NSMutableArray * labelTitleArray;            //标签数组统计
@property(nonatomic,strong)NSMutableArray *customLabelArray;            //自定义标签统计


/** 计算大小 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/** 计算宽度 */
+ (CGFloat)getWidthWithTextFont:(UIFont *)font text:(NSString *)text;
/** 计算高度 */
+ (CGFloat)getHeightWithTextFont:(UIFont *)font;
/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value andWidth:(float)width;
+ (float)heightForString:(NSString *)value attributedStrString:(NSAttributedString *)attrStr andWidth:(float)width;
/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForTextView:(UITextView *)textView andWidth:(float)width;

/**
 @method 数据对象存储到本地userDefault
 @param object 存储对象
 @param key 主键
 */
+(void)writeUserDefaultObject:(NSObject*)object forKey:(NSString*)key;
/**
 @method 获取userDefault对象
 */
+(id)readUserDefaultObjectForKey:(NSString*)key;
+(NSNumber *)readUserId;
/** 获取key对应用户信息 */
+(id)readUserInfoWithKey:(NSString *)key;

/**
    读取唯一标识符号
 */
+(NSString *)readUniqueCode;
/**
 读取学生ID
 */
+(NSNumber *)readStudId;
/**
 读取电话号码
 */
+(NSNumber *)readMobile;
/**
    读取昵称
 */
+ ( NSString * )readNickName;
/**
 @method 删除userDefault对象（数组）
 */
+ (void)removeUserDefaultObjectsForKeys:(NSArray *)keys;

/** 弹出消息 */
+ (void)viewWithOneMessage:(NSString *)message;

/** 时间戳转换， long转日期 (返回日期字符串) */
+ (NSString *)dateWithTimeIntervalSince1970:(NSTimeInterval)seconds formatter:(NSString *)formatter;

/** 判断是否是iPhone X （需真机，模拟器固定返回@"x86_64"）*/
+ (BOOL)deviceIsIPhoneX;

/** 是否登录，
 默认YES登录，NO不登录
 return：是否是登录状态
 */
+ (BOOL)isLogin:(BOOL)login superVC:(UIViewController *)superVC;
+ (BOOL)isLogin:(UIViewController *)superVC;
/** 登录成功后执行操作 */
+ (BOOL)isLogin:(BOOL)login superVC:(UIViewController *)superVC block:(void (^)(BOOL isLogin))block;

/** 对象 转 Jason字符串 */
+ (NSString*)objectToJsonWithObject:(id)object;
/** Json 转 对象 */
+ (id)jsonToObjectWithJsonString:(NSString *)jsonString;

//*********************************推送***********************
// 在应用启动的时候调用
+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction
  advertisingIdentifier:(NSString *)advertisingId;

// 在appdelegate注册设备处调用
+ (void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification;
//表情过滤
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)hasEmoji:(NSString*)string;

/*判断是非是九宫格键盘*/
+(BOOL)isNineKeyBoard:(NSString *)string;

+ (instancetype)defaultSingleton; /**< 单例便利构造器 */

/** 获取最顶端控制器 */
+ (nonnull UIViewController *)topWindowCotroller;
/**极光统计
 * eventID:ios点击事件ID
 * eventName:iOS点击事件名称
 * allEventId:ios+andorid点击事件ID
 * alleventName:ios +andorid点击事件名称
 */
+ (void)countAppEventID:(nullable NSString *)eventID eventName:(nullable NSString *)eventName allEventId:(nullable NSString *)allEventId allEventName:(nullable NSString *)allEventName;

/** 正则表达式判断输入（中文、英文、数字、符号） */
+(BOOL)predicateString:(nonnull NSString*)string;

/** 文字转换富文本（加行距） */
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;
/** unicodeStr 转 字符串*/
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
/** 字符串 转 unicodeStr */
+(NSString *) utf8ToUnicode:(NSString *)string;

/** 极光注册 */
+(void)registeredJPUSH;
/** 极光注册  方法弃用*/
+(void)uuid:(nullable NSString *)uuidId appkey:(nullable NSString *)AppKey channel:(nullable NSString *)Channel apsForProduction:(BOOL)ApsForProduction;

/** 获取图片大小 */
+ (CGSize)getImageSizeWithUrl:(id)imageUrl;

/** 获取设备UUID */
+ (NSString *)getDeviceUUID;
/** 查看当前缓存*/
+(void)getCachSize;
/** 清空当前缓存*/
+(void)handleClearView;

/** 隐藏导航栏分割线 */
+(void)hiddenNavigationLine:(BOOL)hidden;


@end
