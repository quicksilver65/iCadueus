//
//  HttpGetStringArray.m
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "HttpGetStringArray.h"

@interface HttpGetStringArray ()
@property (nonatomic, strong) NSMutableArray *stringArray;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation HttpGetStringArray

@synthesize requestUrl=_requestUrl;
@synthesize stringArray=_stringArray;
@synthesize connection=_connection;
@synthesize responseData=_responseData;
@synthesize getStringArrayDelegate=_getStringArrayDelegate;



- (void)startRequest {
    NSURL* url = [[NSURL alloc] initWithString:self.requestUrl];
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
	self.stringArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ];
    
    self.stringArray = [self.stringArray sortedArrayUsingComparator:^(id firstObject, id secondObject) {
        return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
    }];
    
    [self.getStringArrayDelegate didReturnStringArray:self.stringArray];

    
    
}


@end
