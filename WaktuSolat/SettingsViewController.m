//
//  SettingsViewController.m
//  WaktuSolat
//
//  Created by MSi on 7/31/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize settingsView;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *section1 = [NSArray arrayWithObjects:@"Location", @"Notification", @"Time Format", nil];
    NSArray *section2 = [NSArray arrayWithObjects:@"Source Code", @"License", @"Send Feedback", nil];
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    
    items = [[NSMutableArray alloc] initWithObjects:section1, section2, nil];
    window = [[UIApplication sharedApplication] keyWindow];
    
    self.navigationItem.title = @"Settings";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.settingsView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_settings.png"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[items objectAtIndex:section] count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            KawasanViewController *location = [[KawasanViewController alloc] initWithNibName:@"KawasanViewController" bundle:nil];
            [self.navigationController pushViewController:location animated:YES];
        } else if(indexPath.row == 1) {
            /* Add some function here */
        }
    } else if(indexPath.section == 1) {
        /* Add some function here */
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.settingsView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cells"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.textLabel.text = [[items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return @"About Waktu Solat";
    else
        return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 1)
        return @"Version 1.3";
    else
        return @"";
}

- (void) dealloc
{
    [settingsView release];
    [super dealloc];
}

@end