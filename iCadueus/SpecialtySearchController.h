//
//  SpecialtySearchController.h
//  iCadueus
//
//  Created by Les Brown on 9/27/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpGetStringArray.h"

@protocol SpecialtySearchDelegate <NSObject>
- (void)didFinishSelectingSpecialty:(NSString *)specialty;
@end



@interface SpecialtySearchController : UITableViewController <UIActionSheetDelegate,HttpGetStringArrayDelegate>

- (IBAction)closeSpecialties:(id)sender;
@property (nonatomic, weak) id <SpecialtySearchDelegate> delegate;
@property   (nonatomic,strong) HttpGetStringArray* httpGetter;

@end
