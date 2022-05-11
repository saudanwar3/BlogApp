//
//  MapViewController.m
//  BlogApp
//
//  Created by Muhammad Saud Anwar on 21/04/2022.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];

    _mapView = [[MKMapView alloc]
           initWithFrame:CGRectMake(0,
                                    0,
                                    self.view.bounds.size.width,
                                    self.view.bounds.size.height)
           ];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeHybrid;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager{
    switch (manager.authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"Permission not determined");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"Permission denied");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation];
        } break;
        default:
            break;
        }
}

@end

