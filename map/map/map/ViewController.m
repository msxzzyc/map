//
//  ViewController.m
//  map
//
//  Created by wpzyc on 2017/8/26.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
/** 位置管理者 */
@property(nonatomic,strong)CLLocationManager *lM;
@end

@implementation ViewController
 - (CLLocationManager *)lM
{
    if (!_lM) {
        //1.创建位置管理者
        _lM = [[CLLocationManager alloc]init];
        //1.1设代理
        _lM.delegate = self;
        //每隔多少米定位一次
//        _lM.distanceFilter = 100;
        /**
         * kCLLocationAccuracyBestForNavigation 最适合导航
           kCLLocationAccuracyBest 最好的
           kCLLocationAccuracyNearestTenMeters 10m
           kCLLocationAccuracyHundredMeters 100m
           kCLLocationAccuracyKilometer 1000m
           kCLLocationAccuracyThreeKilometers 3000m
         */
        //精确度越高，越耗电，定位时间越长
//        _lM.desiredAccuracy = kCLLocationAccuracyBest;
        
        /**-----  iOS8.0+定位适配  ----*/
//        if ([[UIDevice currentDevice].systemName floatValue]>=8.0) {
//            //前后台定位授权（请求永久授权）
//            [_lM requestAlwaysAuthorization];
//            //前台定位授权（默认不可以在后台获取位置，后台需在target中勾选location update，且会出现蓝条）
//            //        [_lM requestWhenInUseAuthorization];
//        }
        if ([_lM respondsToSelector:@selector(requestAlwaysAuthorization)] || [_lM respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            //前台定位授权（默认不可以在后台获取位置，后台需在target中勾选location update，且会出现蓝条）如果+authorizationStatus != kCLAuthorizationStatusNotDetermined ，该方法不调用
            [_lM requestWhenInUseAuthorization];
            //前后台定位授权（请求永久授权） 如果+authorizationStatus != kCLAuthorizationStatusNotDetermined ，该方法不调用
            //当前授权状态为前台授权时，此方法也会调用
            [_lM requestAlwaysAuthorization];
           
        }
        
    }
    return _lM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //2.使用位置管理者，开始更新用户位置
    //默认只能前台定位
    //后台定位需要勾选在target中勾选location update
    [self.lM startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"定位到了");
    //停止更新
    [manager stopUpdatingLocation];
}
/**
 *  当用户授权状态发生变化时调用
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }
    
}

@end
