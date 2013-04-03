//
//  CitySearchController.h
//  iCadueus
//
//  Created by Les Brown on 9/27/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpGetStringArray.h"

@protocol CitySearchDelegate <NSObject>
- (void)didFinishSelectingCity:(NSString *)city;
@end


@interface CitySearchController : UITableViewController <UIActionSheetDelegate, HttpGetStringArrayDelegate>

- (IBAction)btnClose:(id)sender;
@property (nonatomic, weak) id <CitySearchDelegate> delegate;
@property   (nonatomic,strong) HttpGetStringArray* httpGetter;
@end
