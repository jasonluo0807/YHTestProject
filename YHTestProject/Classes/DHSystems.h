//
//  DHSystems.h
//  yunbaolive
//
//  Created by XM on 2020/3/11.
//  Copyright © 2020 GuangKeSuo. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface DHSystems : NSObject

/**
 * 是否是全面屏
 */
+ (BOOL)isFullScreen;
+ (BOOL)isIPhone5s;
+ (BOOL)isIPhoneXsMax;
+ (BOOL)isIPhoneXR;
+ (BOOL)isIPhoneX;
+ (BOOL)isIPhonePlus;
+ (CGSize)getScreenSize;

/**
 * 获取文件路径
 */
+ (NSArray *)getCurrentFilePath;

/**
 * 获取Documents文件路径
 */
+ (NSString *)getDocumentsFilePath;

/**
 *  手机型号
 */
+ (NSString *)phoneModel;

/**
 *  手机别名
 */
+ (NSString *)phoneName;

/**
 * 获取当前版本号
 */
+ (NSString *)currentVersion;
+ (NSString *)buildVersion;

/**
 * 获取BundleID
 */
+ (NSString *)getBundleID;

/**
 * 手机系统版本
 */
+ (NSString *)currentPhoneSystemsiOSVersion;

/**
 * 获取设备当前时间
 */
+ (NSString *)currentDate;

/**
 * 获取设备真实型号
 */
+ (NSString *)getDeviceRealType;

/**
 * 获取设备型号
 */
+ (NSString *)getDeviceType;

/**
* 获取手机音量
*/
+ (CGFloat)getDeviceVolume;

/**
 * 是否开启了通知权限
 */
+ (BOOL)isOpenNotifyTheAuthority;

/**
 * 是否开启了通讯录权限
 */
+ (BOOL)isOpenAdBookTheAuthority;

/**
 * 震动效果，普通短震 （ios10）
 */
+ (void)ordinaryShortShock;

/**
* 打开设置
*/
+ (void)openSet;

/**
* 获取通知权限
*/
+ (BOOL)isGetNotifyAuthorWithController:(UIViewController *)vc;
/**
* 获取通讯录权限
*/
+ (BOOL)isGetAdBookAuthorWithController:(UIViewController *)vc;
/**
* 获取相机权限
*/
+ (BOOL)isGetCameraAuthorWithController:(UIViewController *)vc;
/**
* 获取相册权限
*/
+ (BOOL)isGetPhotoAuthorWithController:(UIViewController *)vc;

/**
* 获取音频权限
*/
+ (BOOL)isGetAudioAuthorWithController:(UIViewController *)vc;

/**
* 监测是否安装了微信
*/
+ (BOOL)isWXAppInstalled;

/**
* 监测是否安装了QQ
*/
+ (BOOL)isQQAppInstalled;

/**
* 获取手机运营商
*/
+ (NSString *)getMobileOperator;

/**
* 获取手机ip地址
*/
+ (NSString *)getDeviceIPAddresses;

/**
* 获取收据
*/
+ (NSString *)getReceipt;

/** 设置屏幕为竖屏 */
+ (void)setInterfaceOrientationPortrait;

/** 设置屏幕为横屏（右转） */
+ (void)setInterfaceOrientationLandscapeRight;
/**
* 设置系统震动（类似微信）
*/
+ (void)setSystemSound;

/** 创建SyanImageCaches临时缓存目录 */
+ (BOOL)createTemporaryDirectory:(NSString *)directory;
@end

NS_ASSUME_NONNULL_END
