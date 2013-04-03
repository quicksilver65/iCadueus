//
//  MedProviderCell.h
//  iCadueus
//
//  Created by Les Brown on 9/28/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedProviderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *specialty;
@property (weak, nonatomic) IBOutlet UILabel *fullAddress;
@property (weak, nonatomic) IBOutlet UILabel *cityState;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@end
