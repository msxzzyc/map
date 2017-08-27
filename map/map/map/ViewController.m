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
        //每隔多远定位一次
        _lM.distanceFilter = 100;
        /**
         * kCLLocationAccuracyBestForNavigation 最适合导航
           kCLLocationAccuracyBest 最好的
           kCLLocationAccuracyNearestTenMeters 10m
           kCLLocationAccuracyHundredMeters 100m
           kCLLocationAccuracyKilometer 1000m
           kCLLocationAccuracyThreeKilometers 3000m
         */
        //精确度越高，越耗电，定位时间越长
        _lM.desiredAccuracy = kCLLocationAccuracyBest;
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

@end
