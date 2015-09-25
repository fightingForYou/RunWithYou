//
//  RunningViewController.m
//  RUNwithu
//
//  Created by mty on 15/9/7.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import "RunningViewController.h"
#import "UIViewExt.h"

@interface RunningViewController () 
{
    
    NSMutableArray *mLocations;
    NSInteger noUpdates;
    MKPolyline *routeLine;
    MKMapRect _reouteRect;
    MKPolylineView *linView;
    
    CLLocationManager *locationManager;
    
    UIView *promptView;
    NSDate *date;
    
    UILabel *runLabel;
    UIView *startView;
    UIButton *start;
    UIButton *stop;
    
    BOOL isRunning;
}

@end

@implementation RunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isRunning = NO;
    noUpdates = 0;
    
    
    date = [[NSDate alloc] init];
    pedometer = [[CMPedometer alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [locationManager requestAlwaysAuthorization];

    mLocations = [[NSMutableArray alloc] init];
    
    map.showsUserLocation = YES;
    map.mapType = MKMapTypeStandard;
    map.delegate = self;
    
    [self.view addSubview:map];
    
    [self createStartView];
    [self createPromptView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createPromptView {
    
    promptView = [[UIView alloc] initWithFrame:CGRectMake(50, 90 , 275 , 60)];
    promptView.backgroundColor = [UIColor whiteColor];
    promptView.alpha = 0.5;
    
    runLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 275, 60)];
    runLabel.backgroundColor = [UIColor clearColor];
    runLabel.textColor = [UIColor blackColor];
    runLabel.text = @"跑步即将开始";
    runLabel.textAlignment = NSTextAlignmentCenter;
    runLabel.font = [UIFont systemFontOfSize:20];
    
    [promptView addSubview:runLabel];
    
    
    [self.view addSubview:promptView];
}

- (void)createStartView {
    
    
    startView = [[UIView alloc] initWithFrame:CGRectMake(40, self.view.bottom - 80, (self.view.width - 40), 50)];
    startView.alpha = 0.5;
    startView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:startView];
    
    start = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (self.view.width - 40) / 2, 50)];
    
    [start addTarget:self action:@selector(startRun) forControlEvents:UIControlEventTouchUpInside];
    [start setTitle:@"开始运动" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [startView addSubview:start];
    
    
    stop = [[UIButton alloc] initWithFrame:CGRectMake((self.view.width - 40) / 2, 0, (self.view.width - 40) / 4, 50)];
    stop.tag = 1;
    
    [stop addTarget:self action:@selector(stopRun:) forControlEvents:UIControlEventTouchUpInside];
    [stop setTitle:@"暂停" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [startView addSubview:stop];
    
}

- (void)startRun {
    
    [pedometer startPedometerUpdatesFromDate:date withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        float distance = pedometerData.distance.floatValue / 1000;
        float velocity = pedometerData.currentPace.floatValue;
        
        runLabel.text = [NSString stringWithFormat:@"%.1f公里,%.1fm/s", distance, velocity];
    }];
    isRunning = YES;
    
}

- (void)stopRun: (UIButton *)button {
    
    if (button.tag == 0) {
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否结束运动(将会保存运动结果)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
        
    } else {
        
        [pedometer stopPedometerUpdates];
        [button setTitle:@"结束运动" forState:UIControlStateNormal];
        isRunning = NO;
        button.tag = 0;
        
    }
    
}

- (void)loadRoute {
    
    
    MKMapPoint northEastPoint;
    MKMapPoint southWestPoint;
    
    MKMapPoint *pointArr = malloc(sizeof(CLLocationCoordinate2D) * mLocations.count);
    
    for (int i = 0; i < mLocations.count; i++) {
        
        NSString *currentPointString = [mLocations objectAtIndex:i];
        
        NSArray *array = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        CLLocationDegrees latitude = [[array firstObject] doubleValue];
        CLLocationDegrees longitude = [[array lastObject] doubleValue];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        if (i == 0) {
            northEastPoint = point;
            southWestPoint = point;
        } else {
            
            if (point.x > northEastPoint.x) {
                northEastPoint.x = point.x;
            }
            
            if (point.y > northEastPoint.y) {
                northEastPoint.y = point.y;
            }
            
            if (point.x < southWestPoint.x) {
                southWestPoint.x = point.x;
            }
            
            if (point.y < southWestPoint.y) {
                southWestPoint.y = point.y;
            }
            
        }
        
        pointArr[i] = point;
    }
    
    routeLine = [MKPolyline polylineWithPoints: pointArr count:mLocations.count];
    
    _reouteRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    free(pointArr);
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.002;
    span.longitudeDelta = 0.002;
    
    MKCoordinateRegion region = {userLocation.coordinate, span};
    
    [map setRegion:region];
    
    if (isRunning) {
        
        [mLocations addObject:[NSString stringWithFormat:@"%f,%f", userLocation.coordinate.latitude, userLocation.coordinate.longitude]];
        
        if (routeLine) {
            [map removeOverlay:routeLine];
            routeLine = nil;
        }
        
        [self loadRoute];
        
        if (routeLine != nil) {
            [map addOverlay:routeLine];
        }
    }
  
    
    
    
    
    
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    
    MKOverlayView *overView = nil;
    
    
    
    
    MKPolylineView *linView1 = [[MKPolylineView alloc] initWithPolyline:routeLine];
    
    linView1.fillColor = [UIColor greenColor];
    linView1.strokeColor = [UIColor greenColor];
    linView1.lineWidth = 8;
    
    overView = linView1;
    
    return overView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        
        startView.hidden = YES;
        
        UIGraphicsBeginImageContext(self.view.size);
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        [self.view.layer renderInContext:ctx];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        UIGraphicsEndImageContext();
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}











@end
