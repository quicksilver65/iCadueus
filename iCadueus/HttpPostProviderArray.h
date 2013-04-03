//
//  HttpPostProviderArray.h
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HttpPostProviderArrayDelegate <NSObject>
- (void)didReturnProviderArray:(NSMutableArray *)providerArray;
@end



@interface HttpPostProviderArray : NSObject

@property (nonatomic, weak) id <HttpPostProviderArrayDelegate> postProviderArrayDelegate;
@property (nonatomic,strong) NSDictionary *searchCriteria;

- (void)startRequest;

@end
