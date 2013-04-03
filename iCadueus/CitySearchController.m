//
//  CitySearchController.m
//  iCadueus
//
//  Created by Les Brown on 9/27/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "CitySearchController.h"
#import "HttpGetStringArray.h"

@interface CitySearchController ()

@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic,strong) UIActivityIndicatorView *spinner;
@property (nonatomic,strong) NSString *selectedCity;
@end

@implementation CitySearchController

@synthesize delegate;
@synthesize cities = _cities;
@synthesize spinner = _spinner;
@synthesize selectedCity=_selectedCity;
@synthesize httpGetter=_httpGetter;

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

    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text= [self.cities objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.selectedCity = [self.cities objectAtIndex:indexPath.row];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle: self.selectedCity
                                                       delegate:self
                                              cancelButtonTitle:@"Close"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Select", @"Cancel", nil];
    
    // Show the sheet
    [sheet showInView:self.view];
}

- (IBAction)btnClose:(id)sender {
    

    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)startRequest {
    self.cities= [[NSMutableArray alloc] init];
    self.httpGetter=[[HttpGetStringArray alloc]init];
    self.spinner = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.spinner.center = CGPointMake(160, 240);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    
    
    self.httpGetter.getStringArrayDelegate=self;
    self.httpGetter.requestUrl=@"http://www.azdevelop.net/client/mobileprovider/api/Provider/GetDimensions?field=city";
    [self.httpGetter startRequest];
    

}



- (void)didReturnStringArray:(NSMutableArray *)stringArray{
    self.cities = stringArray;
    [self.spinner stopAnimating];
    [self.tableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.delegate didFinishSelectingCity:self.selectedCity];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else if(buttonIndex == 1)
    {
        self.selectedCity=nil;
        [self.delegate didFinishSelectingCity:self.selectedCity];
    }
    else{
        self.selectedCity=nil;
        [self.delegate didFinishSelectingCity:self.selectedCity];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}



@end
