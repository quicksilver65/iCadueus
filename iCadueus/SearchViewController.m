//
//  SearchViewController.m
//  iCadueus
//
//  Created by Les Brown on 8/30/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "SearchViewController.h"
#import "SpecialtySearchController.h"
#import "CitySearchController.h"
#import "ProviderResultsController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize txtSpecialty;
@synthesize txtLocation;
@synthesize txtLastName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    

    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    


   
    // Do any additional setup after loading the view from its nib.
}




-(void) receiveTestNotification1{
    txtSpecialty.text=@"happy";
}
-(void) receiveTestNotification2{
    return;
    
}

- (void)viewDidUnload
{
    [self setTxtSpecialty:nil];
    [self setTxtLocation:nil];
    [self setTxtLastName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
 

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnSearch:(id)sender {
    NSMutableDictionary *searchCriteria = [[NSMutableDictionary alloc] init];

    if(self.txtLastName.text.length>0)
        [searchCriteria setObject:self.txtLastName.text forKey:@"lastName"];
    if(self.txtSpecialty.text.length>0)
        [searchCriteria setObject:self.txtSpecialty.text forKey:@"specialty"];
    if(self.txtLocation.text.length>0)
        [searchCriteria setObject:self.txtLocation.text forKey:@"city"];
    
    ProviderResultsController* prcView  = [[ProviderResultsController alloc] initWithNibName:@"ProviderResultsController" bundle:nil];
    prcView.searchCriteria=[NSDictionary dictionaryWithDictionary:searchCriteria];;
    [self presentViewController:prcView animated:YES completion:NULL];
  
}

- (IBAction)btnSearchSpecialities:(id)sender {
    
    SpecialtySearchController* sscView = [[SpecialtySearchController alloc] initWithNibName:@"SpecialtySearchController" bundle:nil];
    sscView.delegate=self;
    [self presentViewController:sscView animated:YES completion:NULL];
    
    
}

- (IBAction)btnSearchCities:(id)sender {
    CitySearchController* cscView = [[CitySearchController alloc] initWithNibName:@"CitySearchController" bundle:nil];
    cscView.delegate=self;
    [self presentViewController:cscView animated:YES completion:NULL];
}



//easy way to release keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void) didFinishSelectingSpecialty:(NSString *)specialty
{
    [self.txtSpecialty setText:specialty];

}

- (void) didFinishSelectingCity:(NSString *)city
{
    [self.txtLocation setText:city];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField==txtLastName)
        NSLog(@"I am a happy monkey");
    else
        NSLog(textField.text);
    return true;
   
    
    
}
@end
