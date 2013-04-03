//
//  HttpGetStringArray.h
//  iCadueus
//
//  Created by Les Brown on 10/1/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HttpGetStringArrayDelegate <NSObject>
- (void)didReturnStringArray:(NSMutableArray *)stringArray;
@end

@interface HttpGetStringArray : NSObject

@property (nonatomic,strong) NSString* requestUrl;
@property (nonatomic, weak) id <HttpGetStringArrayDelegate> getStringArrayDelegate;
- (void)startRequest;

@end
