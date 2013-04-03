//
//  DirectionsController.m
//  iCadueus
//
//  Created by Les Brown on 9/29/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "DirectionsController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"
#import "HttpGetCoordinates.h"

@interface DirectionsController ()

@end

@implementation DirectionsController

@synthesize selectedProvider=_selectedProvider;
@synthesize mapView=_mapView;
@synthesize coordinates=_coordinates;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setLatitude: (float)latitude setLongtitude:(float) longtitude
{
    MKCoordinateRegion region;
    region.center.latitude =latitude;
    region.center.longitude=longtitude;
    region.span.latitudeDelta=0.1f;
    region.span.longitudeDelta=0.1f;
    [self.mapView setRegion:region animated:YES];
    
    CLLocationCoordinate2D loc;
    loc.latitude=latitude;
    loc.longitude=longtitude;
    
    Annotation *annotation = [[Annotation alloc] init];
    annotation.coordinate=loc;
    annotation.title=@"Doctor location";
    annotation.subTitle=@"";
    [self.mapView addAnnotation:annotation];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.mapType=MKMapTypeStandard;
    self.coordinates=[[HttpGetCoordinates alloc]init];
    self.coordinates.httpGetCoordinatesDelegate=self;
    self.coordinates.providerId=self.selectedProvider.Id;
    [self.coordinates startRequest];
}

- (void)didReturnCoordinates:(NSDictionary *)coordinateArray{
    
    NSString* latitude = [coordinateArray objectForKey:@"Latitude"];
    NSString* longitude = [coordinateArray objectForKey:@"Longtitude"];
    
    //float n = [latitude floatValue];
    
    [self setLatitude:[latitude floatValue] setLongtitude:[longitude floatValue]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)viewDidUnload {

    [self setMapView:nil];
    [super viewDidUnload];
}
@end
