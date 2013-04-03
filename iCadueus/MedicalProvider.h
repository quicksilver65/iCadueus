//
//  MedicalProvider.h
//  iCadueus
//
//  Created by Les Brown on 8/31/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalProvider : NSObject <NSCoding>

@property int Id;
@property NSString *FirstName;
@property NSString *LastName;
@property NSString *MiddleName;
@property NSString *Specialty;
@property NSString *Address;
@property NSString *Suite;
@property NSString *City;
@property NSString *State;
@property int ZipCode;
@property long  PhoneNumber;

+(void) AddFavorite:(MedicalProvider *) provider;
+(void) RemoveFavorite:(MedicalProvider *) provider;
+(NSArray *) GetFavorites;

@end
