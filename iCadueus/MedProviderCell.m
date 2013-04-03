//
//  MedProviderCell.m
//  iCadueus
//
//  Created by Les Brown on 9/28/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "MedProviderCell.h"

@implementation MedProviderCell

@synthesize fullName=_fullName;
@synthesize fullAddress=_fullAddress;
@synthesize specialty=_specialty;
@synthesize cityState=_cityState;
@synthesize phoneNumber=_phoneNumber;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
