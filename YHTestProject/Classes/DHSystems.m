//
//  DHSystems.m
//  yunbaolive
//
//  Created by 罗乙洪 on 2020/3/11.
//  Copyright © 2020 GuangKeSuo. All rights reserved.
//

#import "DHSystems.h"
#import "sys/utsname.h"
#include <sys/param.h>
#include <sys/mount.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>
#import <Photos/Photos.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <Contacts/Contacts.h>
#import <UserNotifications/UserNotifications.h>

@implementation DHSystems

/** 是否是全面屏 */
+ (BOOL)isFullScreen{
    if ((DH_ScreenHeight/DH_ScreenWidth)>2) {
        return YES;
    }else{
        return NO;
    }
}

// 6.5英寸
+ (BOOL)isIPhoneXsMax{
    
    BOOL iPhoneXsMax =  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO);
    return iPhoneXsMax;
}

// 6.1英寸
+ (BOOL)isIPhoneXR{
    
    BOOL iPhoneXR =  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO);
    return iPhoneXR;
}

 // 5.8英寸
+ (BOOL)isIPhoneX{
    
    return  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)isIPhonePlus{
    
    BOOL iPhonePlus =  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO);
    
    return iPhonePlus;
}

+ (CGSize)getScreenSize{
    
    return [[UIScreen mainScreen] currentMode].size;
}

+ (BOOL)isIPhone5s{
    
    BOOL iPhone5s =  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
    return iPhone5s;
}

// 获取文件路径
+ (NSArray *)getCurrentFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                         , NSUserDomainMask
                                                         , YES);
    return paths;
}

// 获取Documents文件路径
+ (NSString *)getDocumentsFilePath{
    return [self getCurrentFilePath].firstObject;
}

/**
 *  手机型号
 *
 *  @return e.g. iPhone
 */
+ (NSString *)phoneModel{
    return [[UIDevice currentDevice] model];
}

/**
 *  手机别名
 */
+ (NSString *)phoneName{
    return [[UIDevice currentDevice] name];
}

/**
 * 获取当前版本号
 */
+ (NSString *)currentVersion{
    NSString *key = @"CFBundleShortVersionString";
    // 当前软件的版本号（从Info.plist中获得）
    return [NSBundle mainBundle].infoDictionary[key];
}

+ (NSString *)buildVersion {
    NSString *key = @"CFBundleVersion";
    return [NSBundle mainBundle].infoDictionary[key];
}

/**
 * 获取BundleID
 */
+ (NSString*)getBundleID{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

/**
 * 手机系统版本
 */
+ (NSString *)currentPhoneSystemsiOSVersion{
    
    return [[UIDevice currentDevice] systemVersion];
}

/**
 * 获取当前APP的name
 */
+ (NSString *)currentAPPName{
    
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *name = [infoPlist objectForKey:@"CFBundleDisplayName"];
    
    return name;
}

/**
 * 获取设备真实型号
 */
+ (NSString *)getDeviceRealType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    return  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

/**
 * 获取设备当前时间
 */
+ (NSString *)currentDate{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
}

/**
 * 获取设备型号
 */
+ (NSString *)getDeviceType {
    
    
    NSString *deviceString = [self getDeviceRealType];
    
    if([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if([deviceString isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if([deviceString isEqualToString:@"iPhone11,4"] || [deviceString isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if([deviceString isEqualToString:@"iPhone11,8"])  return @"iPhone XR";
    
    //--------------------ipod-----------------------
    if([deviceString isEqualToString:@"iPod1,1"]) return @"iPod touch";
    if([deviceString isEqualToString:@"iPod2,1"]) return @"iPod touch 2G";
    if([deviceString isEqualToString:@"iPod3,1"]) return @"iPod touch 3G";
    if([deviceString isEqualToString:@"iPod4,1"]) return @"iPod touch 4G";
    if([deviceString isEqualToString:@"iPod5,1"]) return @"iPod touch 5G";
    if([deviceString isEqualToString:@"iPod7,1"]) return @"iPod touch 6G";
    
    //--------------------ipad-------------------------
    if([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    if([deviceString isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if([deviceString isEqualToString:@"iPad2,1"] || [deviceString isEqualToString:@"iPad2,2"] || [deviceString isEqualToString:@"iPad2,3"] || [deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if([deviceString isEqualToString:@"iPad3,1"] || [deviceString isEqualToString:@"iPad3,2"] || [deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if([deviceString isEqualToString:@"iPad3,4"] || [deviceString isEqualToString:@"iPad3,5"] || [deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if([deviceString isEqualToString:@"iPad4,1"] || [deviceString isEqualToString:@"iPad4,2"] || [deviceString isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if([deviceString isEqualToString:@"iPad5,3"] || [deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if([deviceString isEqualToString:@"iPad6,7"] || [deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if([deviceString isEqualToString:@"iPad6,3"] || [deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro iPad 9.7-inch";
    if([deviceString isEqualToString:@"iPad6,11"] || [deviceString isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if([deviceString isEqualToString:@"iPad7,1"] || [deviceString isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if([deviceString isEqualToString:@"iPad7,3"] || [deviceString isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    //----------------iPad mini------------------------
    if([deviceString isEqualToString:@"iPad2,5"] || [deviceString isEqualToString:@"iPad2,6"] || [deviceString isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if([deviceString isEqualToString:@"iPad4,4"] || [deviceString isEqualToString:@"iPad4,5"] || [deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if([deviceString isEqualToString:@"iPad4,7"] || [deviceString isEqualToString:@"iPad4,8"] || [deviceString isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if([deviceString isEqualToString:@"iPad5,1"] || [deviceString isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    if([deviceString isEqualToString:@"iPad4,1"]) return @"ipad air";
    if([deviceString isEqualToString:@"i386"]) return @"Simulator";
    if([deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    
    return deviceString;
}

/**
 * 是否开启了通知权限
 */
+ (BOOL)isOpenNotifyTheAuthority{
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    __block UNAuthorizationStatus notiStatus = 0;
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        notiStatus = settings.authorizationStatus;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    if (notiStatus == UNAuthorizationStatusDenied) {
        return NO;
    }else {
        return YES;
    }
}

/**
 * 是否开启了通讯录权限
 */
+ (BOOL)isOpenAdBookTheAuthority{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status != CNAuthorizationStatusAuthorized) {
        // 未授权
        return NO;
    }else {
        return YES;
    }
}


/**
 * 震动效果，普通短震 （ios10）
 */
+ (void)ordinaryShortShock{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [feedBackGenertor impactOccurred];
    }
}

/**
* 打开设置
*/
+ (void)openSet{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
       [[UIApplication sharedApplication] openURL:url];
    }
}

/**
* 获取手机音量
*/
+ (CGFloat)getDeviceVolume{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    return audioSession.outputVolume;
}

/**
* 获取通知权限
*/
+ (BOOL)isGetNotifyAuthorWithController:(UIViewController *)vc {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请打开你的通知权限" message:@"设置 -> TakTak -> 通知" preferredStyle:UIAlertControllerStyleAlert];

                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    
                    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                    
                    [alertC addAction:okAction];
                    [alertC addAction:setAction];
                } else {
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertC addAction:okAction];
                }
                
                [vc presentViewController:alertC animated:YES completion:nil];
            });
        }];
        return NO;
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == 0) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请打开你的通知权限" message:@"设置 -> TakTak -> 通知" preferredStyle:UIAlertControllerStyleAlert];

            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                
                [alertC addAction:okAction];
                [alertC addAction:setAction];
            } else {
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertC addAction:okAction];
            }
            
            [vc presentViewController:alertC animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}

/**
* 获取通讯录权限
*/
+ (BOOL)isGetAdBookAuthorWithController:(UIViewController *)vc {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusRestricted || status == CNAuthorizationStatusDenied) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请打开你的通讯录权限" message:@"设置 -> 隐私 -> 通讯录" preferredStyle:UIAlertControllerStyleAlert];

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            
            [alertC addAction:okAction];
            [alertC addAction:setAction];
        } else {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:okAction];
        }
        
        [vc presentViewController:alertC animated:YES completion:nil];
        return NO;
    }
    return YES;
}

// 获取相机权限
+ (BOOL)isGetCameraAuthorWithController:(UIViewController *)vc{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请打开你的相机权限" message:@"设置 -> 隐私 -> 相机" preferredStyle:UIAlertControllerStyleAlert];

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            
            [alertC addAction:okAction];
            [alertC addAction:setAction];
        } else {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:okAction];
        }
        
        [vc presentViewController:alertC animated:YES completion:nil];
        return NO;
    }
    return YES;
}

/**
* 获取相册权限
*/
+ (BOOL)isGetPhotoAuthorWithController:(UIViewController *)vc{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请打开你的相册权限" message:@"设置 -> 隐私 -> 照片" preferredStyle:UIAlertControllerStyleAlert];

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            
            [alertC addAction:okAction];
            [alertC addAction:setAction];
        } else {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:okAction];
        }
        
        [vc presentViewController:alertC animated:YES completion:nil];
        
        return NO;
    }

    return YES;
}

/**
* 获取音频权限
*/
+ (BOOL)isGetAudioAuthorWithController:(UIViewController *)vc{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请打开你的麦克风权限" message:@"设置 -> 隐私 -> 麦克风" preferredStyle:UIAlertControllerStyleAlert];

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            
            [alertC addAction:okAction];
            [alertC addAction:setAction];
        } else {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:okAction];
        }
        
        [vc presentViewController:alertC animated:YES completion:nil];
        
        return NO;
    }
    
    return YES;
}


// 监测是否安装了微信
+ (BOOL)isWXAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
}

// 监测是否安装了QQ
+ (BOOL)isQQAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}

// 获取手机运营商
+ (NSString *)getMobileOperator{
    
    // 获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    NSString *mobile;
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode) {
        mobile = @"";
    }else{
        mobile = [carrier carrierName];
    }
    
    return mobile;
}

/**
* 获取手机ip地址
*/
+ (NSString *)getDeviceIPAddresses{
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE =4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0) {
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len =sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    
    NSString *deviceIP =@"";
    
    for (int i=0; i < ips.count; i++) {
        
        if (ips.count >0) {
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

/**
* 获取收据
*/
+ (NSString *)getReceipt
{
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData*receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *receipt = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return receipt;
}

/** 设置屏幕为竖屏 */
+ (void)setInterfaceOrientationPortrait{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

/** 设置屏幕为横屏（右转） */
+ (void)setInterfaceOrientationLandscapeRight{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
}

/**
* 设置系统震动
*/
+ (void)setSystemSound{
    // 微信震动（https://blog.csdn.net/wlm0813/article/details/51170574）
    AudioServicesPlaySystemSound(1011);
}


/** 创建SyanImageCaches临时缓存目录 */
+ (BOOL)createTemporaryDirectory:(NSString *)directory {
    NSString * path = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(),directory];;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        //先判断目录是否存在，不存在才创建
        BOOL res = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    } else {
        return NO;
    }
}

@end
