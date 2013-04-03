 //
//  SearchViewController.h
//  iCadueus
//
//  Created by Les Brown on 8/30/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialtySearchController.h"
#import "CitySearchController.h"

@interface SearchViewController : UIViewController<UITextFieldDelegate, SpecialtySearchDelegate, CitySearchDelegate>

@property (retain, nonatomic) IBOutlet UITextField *txtSpecialty;

@property (retain, nonatomic) IBOutlet UITextField *txtLocation;

@property (retain, nonatomic) IBOutlet UITextField *txtLastName;

- (IBAction)btnSearch:(id)sender;
- (IBAction)btnSearchSpecialities:(id)sender;
- (IBAction)btnSearchCities:(id)sender;

@end



