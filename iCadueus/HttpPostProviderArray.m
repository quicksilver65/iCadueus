//
//  HttpPostProviderArray.m
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "HttpPostProviderArray.h"
#import "MedicalProvider.h"

@interface HttpPostProviderArray ()

@property (nonatomic, strong) NSMutableArray *providerResults;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic,strong) MedicalProvider *selectedProvider;
@end


@implementation HttpPostProviderArray

@synthesize connection = _connection;
@synthesize responseData = _responseData;
@synthesize providerResults = _providerResults;
@synthesize selectedProvider=_selectedProvider;
@synthesize searchCriteria=_searchCriteria;
@synthesize postProviderArrayDelegate=_postProviderArrayDelegate;


- (void)startRequest {
    

    self.responseData = [[NSMutableData alloc]init];
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://www.azdevelop.net/client/mobileprovider/api/Provider/GetProvidersByDimensionCollection"];
	NSString *jsonRequest = [self createJsonPost];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
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
    self.providerResults=[[NSMutableArray alloc]init];
    NSData *data = [NSData dataWithData:self.responseData];
    
    for(NSDictionary *item in [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ]) {
        MedicalProvider *obj = [[MedicalProvider alloc]init];
        obj.Id= [[item objectForKey:@"Id"]intValue];
        obj.FirstName=[item objectForKey:@"FirstName"];
        obj.MiddleName=[item objectForKey:@"MiddleName"];
        obj.LastName=[item objectForKey:@"LastName"];
        obj.Specialty=[item objectForKey:@"Specialty"];
        obj.Address=[item objectForKey:@"Address"];
        obj.Suite=[item objectForKey:@"Suite"];
        obj.City=[item objectForKey:@"City"];
        obj.State=[item objectForKey:@"State"];
        obj.ZipCode=[[item objectForKey:@"ZipCode"]intValue];
        obj.PhoneNumber=[[item objectForKey:@"PhoneNumber"]longValue];
        [self.providerResults addObject:obj];
    }
    
    [self.postProviderArrayDelegate didReturnProviderArray:self.providerResults];
    
    
}

-(NSString *) createJsonPost{
    if(self.searchCriteria){
        NSMutableString *jsonBuilder = [[NSMutableString alloc] init];
        [jsonBuilder appendString:@"["];
        for( NSString *aKey in self.searchCriteria ){
            NSString *criteria = [self.searchCriteria objectForKey:aKey];
            NSString *json = [NSString stringWithFormat:@"{\"Selector\":\"%@\", \"Parameter\":\"%@\"},", aKey, criteria];
            [jsonBuilder appendString:json];
        }
        [jsonBuilder deleteCharactersInRange:NSMakeRange([jsonBuilder length]-1, 1)];
        [jsonBuilder appendString:@"]"];
        return [NSString stringWithString: jsonBuilder];
    }
    return nil;
}


@end
