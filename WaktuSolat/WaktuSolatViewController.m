//
//  WaktuSolatViewController.m
//  WaktuSolat
//
//  Created by Muhammad Syahmi Ismail on 3/2/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WaktuSolatViewController.h"
#import "KawasanViewController.h"
#import "JakimPrayerTime.h"
#import "SettingsViewController.h"

@interface WaktuSolatViewController ()

@end

@implementation WaktuSolatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"solat.plist"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"solat" ofType:@"plist"];

        [fileManager copyItemAtPath:bundle toPath:path error:&error];
    }
    
    waktuSolatLabel = [[NSMutableArray alloc] initWithObjects:@"Imsak", @"Subuh", @"Syuruk", @"Zohor", @"Asar", @"Maghrib", @"Isyak", nil];
    
    self.navigationController.toolbarHidden = NO;
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] init];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_settings.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(settings)];
    self.navigationItem.leftBarButtonItem.enabled = YES;

    [leftButton release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.separatorColor = [UIColor clearColor];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];

    NSString *code = [data objectForKey:@"Code"] != nil ? [data objectForKey:@"Code"] : @"sgr03";
    
    JakimSolatParser *parser = [[JakimSolatParser alloc] initWithCode:code];
    parser.delegate = self;
    [parser parse];
    [parser release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)displayData
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    waktuSolat = [[NSMutableArray alloc] initWithObjects:[data objectForKey:@"Imsak"], [data objectForKey:@"Subuh"], [data objectForKey:@"Syuruk"], [data objectForKey:@"Zohor"], [data objectForKey:@"Asar"], [data objectForKey:@"Maghrib"], [data objectForKey:@"Isyak"], nil];
    
    UITapGestureRecognizer *locationLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kawasan)];
    locationLabelGesture.numberOfTapsRequired = 1;
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    locationLabel.textColor = [UIColor whiteColor];
    locationLabel.shadowColor = [UIColor blackColor];
    locationLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    locationLabel.textAlignment = UITextAlignmentCenter;
    locationLabel.numberOfLines = 2;
    locationLabel.lineBreakMode = UILineBreakModeWordWrap;
    locationLabel.text = [data objectForKey:@"Location"];
    [locationLabel setUserInteractionEnabled:YES];
    [locationLabel addGestureRecognizer:locationLabelGesture];
    
    UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithCustomView:locationLabel];
    [locationLabelGesture release];
    
    [self.navigationController.toolbar setItems:[NSArray arrayWithObject:location]];
    [locationLabel release];
    [location release];
    
    // Custom titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake((320-200)/2, (44-34)/2, 200, 34)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Waktu Solat";
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    [titleView addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 14)];
    dateLabel.textAlignment = UITextAlignmentCenter;
    dateLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.text = [data objectForKey:@"Date"];
    dateLabel.shadowColor = [UIColor blackColor];
    dateLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    [titleView addSubview:dateLabel];
    [dateLabel release];
    
    self.navigationItem.titleView = titleView;
    [titleView release];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [waktuSolat count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:44/255.0 green:128/255.0 blue:33/255.0 alpha:1];
    }
    
    cell.textLabel.text = [waktuSolatLabel objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [waktuSolat objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(IBAction)kawasan 
{
    KawasanViewController *kawasanViewController = [[KawasanViewController alloc] initWithNibName:@"KawasanViewController" bundle:nil];
    [self.navigationController pushViewController:kawasanViewController animated:YES];
}

-(IBAction)settings
{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)jakimSolatParser:(JakimSolatParser *)parser didParsePrayerTime:(JakimPrayerTime *)prayerTime
{

    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+8"]];
    [dateFormatter setDateFormat:@"h:mm a"];
    
    [data setObject:[dateFormatter stringFromDate:prayerTime.imsak] forKey:@"Imsak"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.subuh] forKey:@"Subuh"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.syuruk] forKey:@"Syuruk"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.zohor] forKey:@"Zohor"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.asar] forKey:@"Asar"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.maghrib] forKey:@"Maghrib"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.isyak] forKey:@"Isyak"];
    [dateFormatter setDateFormat:@"EEEE, dd LLLL yyyy"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.imsak] forKey:@"Date"];
    [data setObject:prayerTime.code forKey:@"Code"];
    [data setObject:prayerTime.location forKey:@"Location"];
    
    [data writeToFile:path atomically:YES];
    [data release];
    
    [self displayData];
}

- (void)jakimSolatParser:(JakimSolatParser *)parser didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Cannot load data from server. Try again!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self displayData];
}

- (void)dealloc
{
    [waktuSolat release];
    [waktuSolatLabel release];
    [path release];
    [super dealloc];
}

@end