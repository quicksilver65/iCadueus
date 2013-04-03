//
//  Annotation.h
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@end
