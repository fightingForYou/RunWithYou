//
//  RunningViewController.h
//  RUNwithu
//
//  Created by mty on 15/9/7.
//  Copyright (c) 2015年 mty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>

@interface RunningViewController : UIViewController<MKMapViewDelegate, UIAlertViewDelegate>
{
    
    CMPedometer *pedometer;
    MKMapView *map;
}

@end
