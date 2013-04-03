//
//  SpecialtySearchController.m
//  iCadueus
//
//  Created by Les Brown on 9/27/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "SpecialtySearchController.h"
#import "SearchViewController.h"
#import "HttpGetStringArray.h"

@interface SpecialtySearchController ()

@property (nonatomic, strong) NSMutableArray *specialties;
@property (nonatomic,strong) UIActivityIndicatorView *spinner;
@property (nonatomic,strong) NSString *selectedSpecialty;
@end

@implementation SpecialtySearchController

@synthesize httpGetter=_httpGetter;
@synthesize delegate;
@synthesize specialties = _specialties;
@synthesize spinner = _spinner;
@synthesize selectedSpecialty = _selectedSpecialty;

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
    return self.specialties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    cell.textLabel.text= [self.specialties objectAtIndex:indexPath.row];
    
    return cell;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    self.selectedSpecialty = [self.specialties objectAtIndex:indexPath.row];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle: self.selectedSpecialty
                                                       delegate:self
                                              cancelButtonTitle:@"Close"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Select", @"Cancel", nil];
    
    // Show the sheet
    [sheet showInView:self.view];
                          
}

- (IBAction)closeSpecialties:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)startRequest {
    self.specialties= [[NSMutableArray alloc] init];
    self.httpGetter=[[HttpGetStringArray alloc]init];
    self.spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.spinner.center = CGPointMake(160, 240);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];

    
    self.httpGetter.getStringArrayDelegate=self;
    self.httpGetter.requestUrl=@"http://www.azdevelop.net/client/mobileprovider/api/Provider/GetDimensions?field=specialty";
    [self.httpGetter startRequest];



}

- (void)didReturnStringArray:(NSMutableArray *)stringArray{
    self.specialties = stringArray;
    [self.spinner stopAnimating];
    [self.tableView reloadData];
}




- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.delegate didFinishSelectingSpecialty:self.selectedSpecialty];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else if(buttonIndex == 1)
    {
        self.selectedSpecialty=nil;
        [self.delegate didFinishSelectingSpecialty:self.selectedSpecialty];
    }
    else{
        self.selectedSpecialty=nil;
        [self.delegate didFinishSelectingSpecialty:self.selectedSpecialty];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}



@end
