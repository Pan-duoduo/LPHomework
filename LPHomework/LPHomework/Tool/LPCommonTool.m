//
//  LPCommonTool.m
//  DigitalSchool
//
//  Created by Pan on 2017/10/31.
//  Copyright © 2017年 Pan. All rights reserved.
//

/** 通用工具类 */

#import "LPCommonTool.h"
#import <sys/utsname.h>
#import "LPLoginOrRegisterController.h"


static LPCommonTool *singleton = nil;


@implementation LPCommonTool


+ (instancetype)defaultSingleton {
    
    // GCD创建单例，效率更高，性能更好，消耗更低。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[LPCommonTool alloc] init];
    });
    return singleton;
}

/** 计算宽度 */
+ (CGFloat)getWidthWithTextFont:(UIFont *)font text:(NSString *)text {
    CGSize size = [self sizeWithText:text font:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    return size.width;
}

/** 计算高度 */
+ (CGFloat)getHeightWithTextFont:(UIFont *)font {
    CGSize size = [self sizeWithText:@"计算" font:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    return size.height;
}

/** 计算文字大小 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    if (text.length <= 0) {
        text = @"";
    }
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value andWidth:(float)width{
    if (!value) {
        return 0;
    }
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    
    return [LPCommonTool heightForString:value attributedStrString:attrStr andWidth:width];
}

+ (float)heightForString:(NSString *)value attributedStrString:(NSAttributedString *)attrStr andWidth:(float)width {
    if (!attrStr || !value) {
        return 0;
    }

    //    _text.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForTextView:(UITextView *)textView andWidth:(float)width {
    
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

/**
 @method 存储数据对象到本地userDefault
 */
+(void)writeUserDefaultObject:(NSObject*)object forKey:(NSString*)key {
    if (!object || !key)
    {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *objc = object ; // set value
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objc];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

/**
 @method 获取userDefault对象
 */
+(id)readUserDefaultObjectForKey:(NSString*)key {
    if (key) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:key];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    else {
        return nil;
    }
}

+ (NSNumber *)readUserId {
    
    if ([LPCommonTool readUserDefaultObjectForKey:LPUSERKEY][@"id"]) {
        NSDictionary *dic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
        return @([dic[@"id"] integerValue]);
    }
    return nil;
}
+(NSString *)readUniqueCode{
    if ([LPCommonTool readUserDefaultObjectForKey:LPUSERKEY][@"uniqueCode"]) {
        NSDictionary * dic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
        NSString *uniqueCodeStirng=[NSString stringWithFormat:@"%@",dic[@"uniqueCode"]];
        
        NSLog(@"%@",dic[@"uniqueCode"]);
        
        return uniqueCodeStirng;
    }
    return nil;
}



/** 获取key对应用户信息 */
+(id)readUserInfoWithKey:(NSString *)key {
    
    if ([LPCommonTool readUserDefaultObjectForKey:LPUSERKEY]) {
        NSDictionary *dic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
        if (![dic[key] isKindOfClass:[NSNull class]]) {
            return dic[key];
        }
    }
    return nil;
}
+(NSNumber *)readStudId{
    if ([LPCommonTool readUserDefaultObjectForKey:LPUSERKEY][@"stuId"]) {
        NSDictionary *dic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
        return @([dic[@"stuId"] integerValue]);
    }
    return nil;
    
}

+(NSNumber *)readMobile{
    if ([LPCommonTool readUserDefaultObjectForKey:LPUSERKEY][@"mobile"]) {
        NSDictionary *dic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
        return @([dic[@"mobile"] integerValue]);
    }
    return nil;
}
+ ( NSString * )readNickName {
    if ([LPCommonTool readUserDefaultObjectForKey:LPUSERKEY][@"nickName"]) {
        NSDictionary *dic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
        return dic[@"nickName"];
        
    }
    return nil;
}



/**
 @method 删除userDefault对象（数组）
 */
+ (void)removeUserDefaultObjectsForKeys:(NSArray *)keys {
    for (NSString *key in keys) {
        if (![key length] || ![key isKindOfClass:[NSString class]])continue;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 自定义view(一条信息，自动消失)
+ (void)viewWithOneMessage:(NSString *)message{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(LPScreen_W / 2, LPScreen_H / 2, 2, 2)];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LPScreen_W, LPScreen_H)];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.4;
    backGroundView.center = CGPointMake(  0,  0);
    [view addSubview:backGroundView];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0.1 * LPScreen_W, 0.8 * LPScreen_H, LPScreen_W * 0.8, LPScreen_H * 0.05)];
    button.layer.borderWidth=1;
   // button.layer.borderColor=MY_COLOR(225, 225, 225).CGColor;
    button.layer.borderColor = LPColorWithRGB(255, 255, 255).CGColor;
    button.center = CGPointMake(0, 0);
    [button setTitleColor:LPColorWithRGB(50, 50, 50) forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:message forState:UIControlStateNormal];
    button.titleLabel.font = LPFontSize(16);
    button.layer.cornerRadius = LPScreen_H * 0.025;
    [view addSubview:button];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    [UIView animateWithDuration:4 animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:3 animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }];
}

/** long转日期 (返回日期字符串) */
+ (NSString *)dateWithTimeIntervalSince1970:(NSTimeInterval)seconds formatter:(NSString *)formatter {
    
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds / 1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    return [dateFormatter stringFromDate:timeDate];
}

/** 判断是否是iPhone X （需真机，模拟器固定返回@"x86_64"）*/
+ (BOOL)deviceIsIPhoneX {
//    struct utsname systemInfo;
//
//    uname(&systemInfo);
//
//    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
//    /**
//     @"iPhone10,3"：国行(A1865)、日行(A1902)iPhone X
//     @"iPhone10,6"：美版(Global/A1901)iPhone X
//     */
//    if([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"]) {
//        return YES;
//    }
//    return NO;
    
    // 高度判断iPhone X
    if (LPScreen_H == 812) {
        return YES;
    }else {
        return NO;
    }
}

/** 是否登录，
 默认YES登录，NO不登录
 return：是否是登录状态
 */
+ (BOOL)isLogin:(BOOL)login superVC:(UIViewController *)superVC {
    
    return [LPCommonTool isLogin:login superVC:superVC block:nil];
}
+ (BOOL)isLogin:(UIViewController *)superVC {
    return [LPCommonTool isLogin:YES superVC:superVC block:nil];
}
+ (BOOL)isLogin:(BOOL)login superVC:(UIViewController *)superVC block:(void (^)(BOOL isLogin))block {
    NSDictionary *userDic = [LPCommonTool readUserDefaultObjectForKey:LPUSERKEY];
    
    if ([userDic valueForKey:@"id"]) {
        return YES;
    }else {
        if (login) {
            LPLoginOrRegisterController *loginVC = [[LPLoginOrRegisterController alloc] init];
            loginVC.title = @"登录";
            loginVC.hidesBottomBarWhenPushed = YES;
//            if (block) {
//                loginVC.loginBlock = block;
//            }
            [superVC.navigationController pushViewController:loginVC animated:YES];
        }
        return NO;
    }
}

/**
    isCode
 */



/** 对象 转 Jason字符串 */
+ (NSString*)objectToJsonWithObject:(id)object {
    if (!object) {
        return nil;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** Json 转 对象 */
+ (id)jsonToObjectWithJsonString:(NSString *)jsonString {
    if (jsonString == nil || [jsonString isKindOfClass:[NSNull class]]) {
        return nil;
    }
   // NSLog(@"请求结果：result = %@", jsonString);

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"message",@"400",@"code",nil];
        NSLog(@"%@", dic);
        return dic;
    }
    return dic;
}




//判断是否输入了emoji 表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[string characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             //             ||((a=='_') || (a == '-')) //判断是否允许下划线，昵称可能会用上
             ||((a==' '))                 //判断是否允许控制
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ||([other rangeOfString:string].location != NSNotFound)
             ))
            
        
        
//        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
        
    }
    return YES;
}


/** 获取最顶端控制器 */
+ (nonnull UIViewController *)topWindowCotroller {
    
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [self topWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
            
        }
    }
    while (activityViewController.presentedViewController != nil)
    {
        activityViewController = activityViewController.presentedViewController;
    }
    
    if([activityViewController isKindOfClass:[UITabBarController class]]){
        UITabBarController * tab = (UITabBarController *)activityViewController;
        activityViewController = tab.viewControllers[tab.selectedIndex];
    }
    if ([activityViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)activityViewController;
        activityViewController  = nav.topViewController;
    }
    
    return activityViewController;
}

+ (nonnull UIWindow *)topWindow {
    
    UIWindow *window;
    NSArray *ws = [UIApplication sharedApplication].windows;
    for (UIWindow *w in ws) {
        
        if (![w isKindOfClass:NSClassFromString(@"UITextEffectsWindow")] && (CGRectGetHeight(w.bounds) == CGRectGetHeight([UIScreen mainScreen].bounds))) {
            
            window = w;
            break;
        }
    }
    return window;
}


/** 正则表达式判断输入（中文、英文、数字、符号） */
+(BOOL)predicateString:(NSString*)string {
    
    // 空字符，删除键
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    NSString *other = @"➋➌➍➎➏➐➑➒";     //九宫格的输入值
    if ([other rangeOfString:string].location != NSNotFound) {
        // 九宫格输入
        return YES;
    }
    
    // 正则匹配字符串
    NSString *predicateString =@"[0-9a-zA-Z\u4e00-\u9fa5\\s\\.\\*\\)\\(\\+\\$\\[\\?\\\\\\^\\{\\|\\]\\}\\-\\￥\\`\\·\\～\\~%%%@\'\",。‘、-【】·.！_——=:;；<>《》‘’“”!#~·……&/?]+";
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",predicateString];
    
    BOOL isMatch = [predicate evaluateWithObject:string];
    
    return isMatch;
}

//unicond 转中文
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    if (unicodeStr.length <= 0) {
        return @"";
    }
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}



//iso8859－1 到 unicode编码转换:  弃用
+ (NSString *)changeISO88591StringToUnicodeString:(NSString *)iso88591String
{
    
    NSMutableString *srcString = [[NSMutableString alloc]initWithString:iso88591String];
    [srcString replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    [srcString replaceOccurrencesOfString:@"&#x" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    NSMutableString *desString = [[NSMutableString alloc]init];
    NSArray *arr = [srcString componentsSeparatedByString:@";"];
    
    for(int i=0;i<[arr count]-1;i++){
        NSString *v = [arr objectAtIndex:i];
        char *c = malloc(3);
      //  int value = [StringUtil changeHexStringToDecimal:v];
        int  value = 1;
        c[1] = value  &0x00FF;
        c[0] = value >>8 &0x00FF;
        c[2] = '\0';
        [desString appendString:[NSString stringWithCString:c encoding:NSUnicodeStringEncoding]];
        free(c);
    }
    return desString;
}


+(NSString *) utf8ToUnicode:(NSString *)string{
   // NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@";¥?![]{}#%^*£€•$><~|/？！@[]{}（#-%*+=）\\|~(＜＞$%^&*)+"];
    
    
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        //真的搞不懂，为什么要去区分中文，英文还是特殊字符，直接把所有的内容编码不就好了，因为，人家根本就不在乎
     //   unichar _char = [string characterAtIndex:i];
     //   NSString * mystring = [NSString stringWithFormat:@"%c",_char];
      //  NSLog(@"%@",mystring);
//        NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
//        NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
//        if (![emailTest evaluateWithObject:mystring]) {
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else if ([mystring isEqualToString:@" "]){
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }
//        //判断是否为英文和数
//        else if (_char <= '9' && _char >='0'){
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else if(_char >='a' && _char <= 'z'){
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else if(_char >='A' && _char <= 'Z'){
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else{
//            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
//        }
        
         [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
    }
    return s;
}

/** 文字转换富文本（加行距） */
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    
    if (string.length <= 0) {
        string = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

///** 获取图片大小 */
//+ (CGSize)getImageSizeWithUrl:(id)imageUrl {
//
//    NSURL* URL = nil;
//    if([imageUrl isKindOfClass:[NSURL class]]){
//        URL = imageUrl;
//    } else if([imageUrl isKindOfClass:[NSString class]]){
//        URL = [NSURL URLWithString:imageUrl];
//    }else {
//        return CGSizeZero;                  // url不正确返回CGSizeZero
//    }
//
//    UIImage *img = [[YYImageCache sharedCache] getImageForKey:URL.absoluteString];
//
//    if (img) {
//
//        return img.size;
//    }
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
//    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
//
//    CGSize size = CGSizeZero;
//    if([pathExtendsion isEqualToString:@"png"]){
//        size =  [self downloadPNGImageSizeWithRequest:request];
//    }
//    else if([pathExtendsion isEqual:@"gif"])
//    {
//        size =  [self downloadGIFImageSizeWithRequest:request];
//    }
//    else{
//        size = [self downloadJPGImageSizeWithRequest:request];
//    }
//    if(CGSizeEqualToSize(CGSizeZero, size))
//    {
//        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
//        UIImage* image = [UIImage imageWithData:data];
//        if(image)
//        {
//            [[YYImageCache sharedCache] setImage:image forKey:URL.absoluteString];
//            size = image.size;
//        }
//    }
//
//    if(CGSizeEqualToSize(CGSizeZero, size))  {
//        size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
//    }
//
//    // 容错处理
//    if (size.width <= 0 || size.height <= 0) {
////        float width = float abs(size.width);
////        float height = float abs(size.height);
//        size = CGSizeMake(0.1, 0.1);
//    }
//
//    return size;
//}

+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

//研究发现七牛图片的二进制标志位0xffdb向后偏移了0x3d，所以改良了算法，不知道以后其他图片是否还有其他偏移
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-228" forHTTPHeaderField:@"Range"]; //原始为209，改进七牛云向后偏移了61（0x3d）实际需要的最大值为(0xa6+0x3d)
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb)
        {
            return [self jpgSize:data offset:0];
        } else {
            //            if (data.length>=(0xa6+0x3d)){//改进点，向后偏移0x3d
            //
            //                return [self jpgSize:data offset:0x3d];
            //            }
            return CGSizeZero;
        }
    }
}

+ (CGSize)jpgSize:(NSData*)data offset:(int)f{
    
    short word = 0x0;
    [data getBytes:&word range:NSMakeRange(f+0x5a, 0x1)];
    if (word == 0xdb) {// 两个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(f+0xa5, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(f+0xa6, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(f+0xa3, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(f+0xa4, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {// 一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(f+0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(f+0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(f+0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(f+0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    }
}

/** 获取设备UUID */
+ (NSString *)getDeviceUUID {
    NSString * UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UUIDString = [UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return UUIDString;
}
/** 查看当前缓存*/
+(void)getCachSize{
    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    //获取自定义缓存大小
    //用枚举器遍历 一个文件夹的内容
    //1.获取 文件夹枚举器
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    __block NSUInteger count = 0;
    //2.遍历
    for (NSString *fileName in enumerator) {
        NSString *path = [myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        count += fileDict.fileSize;//自定义所有缓存大小
    }
    // 得到是字节  转化为M
    CGFloat totalSize = ((CGFloat)imageCacheSize+count)/1024/1024;
    NSLog(@"缓存大小：%f",totalSize);
    
  //  return totalSize;
}

/**清空当前缓存*/
+(void)handleClearView {
    //删除两部分
    //1.删除 sd 图片缓存
    //先清除内存中的图片缓存
    [[SDImageCache sharedImageCache] clearMemory];
    //清除磁盘的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    //2.删除自己缓存
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
}


/** 隐藏导航栏分割线 */
+(void)hiddenNavigationLine:(BOOL)hidden {
    
    UIView *backgroundView = [[LPCommonTool topWindowCotroller].navigationController.navigationBar subviews].firstObject;
    UIView *navigationLine = backgroundView.subviews.firstObject;
    navigationLine.hidden = hidden;
}



@end
