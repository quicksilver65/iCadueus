//
//  MedicalProvider.m
//  iCadueus
//
//  Created by Les Brown on 8/31/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "MedicalProvider.h"

#define Provider_Id @"Id"
#define First_Name @"FirstName"
#define Last_Name @"LastName"
#define Middle_Name @"MiddleName"
#define Medical_Specialty @"Specialty"
#define Location_Address @"Address"
#define Location_Suite @"Suite"
#define Location_City @"City"
#define Location_State @"State"
#define Zip_Code @"ZipCode"
#define Phone_Number @"PhoneNumber"

@implementation MedicalProvider

@synthesize Id;
@synthesize FirstName;
@synthesize LastName;
@synthesize MiddleName;
@synthesize Specialty;
@synthesize Address;
@synthesize Suite;
@synthesize City;
@synthesize State;
@synthesize ZipCode;
@synthesize PhoneNumber;





-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.Id= [aDecoder decodeIntegerForKey:Provider_Id];
        self.FirstName = [aDecoder decodeObjectForKey:First_Name];
        self.LastName = [aDecoder decodeObjectForKey:Last_Name];
        self.MiddleName = [aDecoder decodeObjectForKey:Middle_Name];
        self.Specialty = [aDecoder decodeObjectForKey:Medical_Specialty];
        self.Address = [aDecoder decodeObjectForKey:Location_Address];
        self.Suite = [aDecoder decodeObjectForKey:Location_Suite];
        self.City = [aDecoder decodeObjectForKey:Location_City];
        self.State = [aDecoder decodeObjectForKey:Location_State];
        self.ZipCode = [aDecoder decodeIntegerForKey:Zip_Code];
        self.PhoneNumber = [aDecoder decodeInt64ForKey:Phone_Number];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder   {
    [aCoder encodeInteger:self.Id forKey:Provider_Id];
    [aCoder encodeObject:self.FirstName forKey:First_Name];
    [aCoder encodeObject:self.LastName forKey:Last_Name];
    [aCoder encodeObject:self.MiddleName forKey:Middle_Name];
    [aCoder encodeObject:self.Specialty forKey:Medical_Specialty];
    [aCoder encodeObject:self.Address forKey:Location_Address];
    [aCoder encodeObject:self.Suite forKey:Location_Suite];
    [aCoder encodeObject:self.City forKey:Location_City];
    [aCoder encodeObject:self.State forKey:Location_State];
    [aCoder encodeInteger:self.ZipCode forKey:Zip_Code];
    [aCoder encodeInt64:self.PhoneNumber forKey:Phone_Number];
}

+(void) AddFavorite:(MedicalProvider *) provider{
    NSMutableArray *data = [self LoadData];
    if(!data)
        data=[[NSMutableArray alloc]init];
    for(MedicalProvider* obj in data){
        if(obj.Id==provider.Id)
            return;
    }
    [data addObject:provider];
    [self SaveData:data];
}
+(void) RemoveFavorite:(MedicalProvider *) provider{
    NSMutableArray *data = [self LoadData];
    for(MedicalProvider* obj in data){
        if(obj.Id==provider.Id){
            [data removeObject:obj];
            [self SaveData:data];
            return;
        }
    }
}
+(NSArray *) GetFavorites{
    return [NSArray arrayWithArray:[self LoadData]];

}
+(void) SaveData:(NSMutableArray *) data{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	NSURL *fileURL = [[urls lastObject] URLByAppendingPathComponent:@"iProviderFavorites.data"];
    NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:data];
	[fileData writeToURL:fileURL atomically:YES];
}
+(NSMutableArray *) LoadData{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	NSURL *fileURL = [[urls lastObject] URLByAppendingPathComponent:@"iProviderFavorites.data"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}



@end
