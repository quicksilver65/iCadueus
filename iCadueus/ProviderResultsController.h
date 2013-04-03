//
//  ProviderResultsController.h
//  iCadueus
//
//  Created by Les Brown on 9/27/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpPostProviderArray.h"

@interface ProviderResultsController : UITableViewController <UIActionSheetDelegate, HttpPostProviderArrayDelegate>

- (IBAction)close:(id)sender;

@property NSDictionary *searchCriteria;
@property (nonatomic,strong) HttpPostProviderArray* httpProviderArray;

@end
