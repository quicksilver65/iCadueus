//
//  HttpGetCoordinates.h
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpGetCoordinatesDelegate <NSObject>
- (void)didReturnCoordinates:(NSDictionary *)coordinateArray;
@end

@interface HttpGetCoordinates : NSObject
@property int providerId;
@property (nonatomic, weak) id <HttpGetCoordinatesDelegate> httpGetCoordinatesDelegate;
- (void)startRequest;
@end
