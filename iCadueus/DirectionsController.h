//
//  DirectionsController.h
//  iCadueus
//
//  Created by Les Brown on 9/29/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MedicalProvider.h"
#import "HttpGetCoordinates.h"

@interface DirectionsController : UIViewController <MKMapViewDelegate, HttpGetCoordinatesDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property  (nonatomic, strong) HttpGetCoordinates* coordinates;
@property (nonatomic,strong) MedicalProvider *selectedProvider;

- (IBAction)close:(id)sender;

@end
