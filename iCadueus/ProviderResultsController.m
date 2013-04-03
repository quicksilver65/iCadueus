//
//  ProviderResultsController.m
//  iCadueus
//
//  Created by Les Brown on 9/27/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "ProviderResultsController.h"
#import "MedicalProvider.h"
#import "MedProviderCell.h"
#import <MapKit/MapKit.h>
#import "DirectionsController.h"
#import "HttpPostProviderArray.h"

@interface ProviderResultsController ()

@property (nonatomic, strong) NSMutableArray *providerResults;
@property (nonatomic,strong) UIActivityIndicatorView *spinner;
@property (nonatomic,strong) MedicalProvider *selectedProvider;

@end

@implementation ProviderResultsController
@synthesize providerResults = _providerResults;
@synthesize spinner = _spinner;
@synthesize selectedProvider=_selectedProvider;
@synthesize searchCriteria=_searchCriteria;
@synthesize httpProviderArray= _httpProviderArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.providerResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    MedProviderCell *cell = (MedProviderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MedProviderCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    MedicalProvider *mp = [self.providerResults objectAtIndex:indexPath.row];
    cell.fullName.text=[NSString stringWithFormat:@"%@ %@", mp.FirstName, mp.LastName];
    cell.specialty.text=mp.Specialty;
    cell.fullAddress.text=[NSString stringWithFormat:@"%@  %@", mp.Address, mp.Suite==[NSNull null]?@"":mp.Suite];
    cell.cityState.text=[NSString stringWithFormat:@"%@, %@   %d", mp.City, mp.State, mp.ZipCode];
    cell.phoneNumber.text=[self convertToPhoneNumber:mp.PhoneNumber];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalProvider *mp = [self.providerResults objectAtIndex:indexPath.row];
    self.selectedProvider=mp;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@", mp.FirstName, mp.LastName]
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"Make Favorite", @"Call", @"Directions", nil];
    
    // Show the sheet
    [sheet showInView:self.view];
}



- (void)startRequest {
    self.providerResults=[[NSMutableArray alloc]init];
    self.httpProviderArray=[[HttpPostProviderArray alloc]init];
    
    self.spinner = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(160, 240);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    
    self.httpProviderArray.searchCriteria=self.searchCriteria;
    self.httpProviderArray.postProviderArrayDelegate=self;
    [self.httpProviderArray startRequest];
    

}

- (void)didReturnProviderArray:(NSMutableArray *)providerArray{
    self.providerResults=providerArray;
    [self.spinner stopAnimating];
    [self.tableView reloadData];
}



-(void) doPhoneCall:(long) phoneNumber{
    NSString *tel = [NSString stringWithFormat:@"telprompt://%ld",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
}



-(NSString *) convertToPhoneNumber: (long) phoneNumber{
    NSString *unformatted = [NSString stringWithFormat:@"%ld", phoneNumber];

    NSArray *stringComponents = [NSArray arrayWithObjects:[unformatted substringWithRange:NSMakeRange(0, 3)],
                                 [unformatted substringWithRange:NSMakeRange(3, 3)],
                                 [unformatted substringWithRange:NSMakeRange(6, [unformatted length]-6)], nil];
    
    return [NSString stringWithFormat:@"(%@) %@-%@", [stringComponents objectAtIndex:0], [stringComponents objectAtIndex:1], [stringComponents objectAtIndex:2]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)//make favorite
    {
        [MedicalProvider AddFavorite:self.selectedProvider];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else if(buttonIndex == 1)//make call
    {
        [self doPhoneCall:self.selectedProvider.PhoneNumber];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else if(buttonIndex == 2)//directions
    {
        DirectionsController* dcView = [[DirectionsController alloc] initWithNibName:@"DirectionsController" bundle:nil];
        dcView.selectedProvider=self.selectedProvider;
        [self presentViewController:dcView animated:YES completion:NULL];
    }
    else{
        self.selectedProvider=nil;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


- (IBAction)close:(id)sender {
            [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
