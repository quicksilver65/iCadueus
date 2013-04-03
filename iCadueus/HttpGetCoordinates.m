//
//  HttpGetCoordinates.m
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "HttpGetCoordinates.h"

@interface HttpGetCoordinates ()
@property (nonatomic, strong) NSDictionary *coordinateData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;
@end


@implementation HttpGetCoordinates


@synthesize coordinateData=coordinateData;
@synthesize connection=_connection;
@synthesize responseData=_responseData;
@synthesize httpGetCoordinatesDelegate=_httpGetCoordinatesDelegate;
@synthesize providerId=_providerId;


- (void)startRequest {
    NSString *strUrl = [NSString stringWithFormat:@"http://www.azdevelop.net/client/mobileprovider/api/Provider/GetLatLong?Id=%d",self.providerId];
    NSURL* url = [[NSURL alloc] initWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	self.responseData = [[NSMutableData alloc] init];
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response {
	[self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
	[self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    self.responseData = nil;
    self.connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
    NSError *error;
    NSData *data = [NSData dataWithData:self.responseData];
	self.coordinateData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ];
    [self.httpGetCoordinatesDelegate didReturnCoordinates:self.coordinateData];
}

@end
