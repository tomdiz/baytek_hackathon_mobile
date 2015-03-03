//
//  VGLAddLocationViewController.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "MBProgressHUD.h"
#import "VGLAddLocationViewController.h"

@interface VGLAddLocationViewController () <MKMapViewDelegate,  CLLocationManagerDelegate>

@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) VGLLocationModel *storeInfo;

@end

@implementation VGLAddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
}

- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addStoreLocation:(id)sender {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Creating New Location...";
    hud.dimBackground = YES;
    [hud setProgress:12.0/360.0];
    
    CLLocationCoordinate2D coords = [self.locationManager.location coordinate];
    
    [[VGLLocationModel instance] postLocation:^(BOOL success, NSString *errMessage){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (!success) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Creating Location Error"
                                                                message:errMessage
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    } withLocationName:self.name.text withNotes:self.notes.text withLat:coords.latitude withLong:coords.longitude andWithHUD:hud];

    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Navigation

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

@end
