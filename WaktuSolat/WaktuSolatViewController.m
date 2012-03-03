//
//  WaktuSolatViewController.m
//  WaktuSolat
//
//  Created by Muhammad Syahmi Ismail on 3/2/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "WaktuSolatViewController.h"
#import "KawasanViewController.h"
#import "JakimPrayerTime.h"

@interface WaktuSolatViewController ()

@end

@implementation WaktuSolatViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"WaktuSolat.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"WaktuSolat" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    NSLog(@"%@", path);
    
    waktuSolatLabel = [[NSMutableArray alloc] initWithObjects:@"Imsak", @"Subuh", @"Syuruk", @"Zohor", @"Asar", @"Maghrib", @"Isyak", nil];
    
    self.navigationItem.title = @"Waktu Solat";
    self.navigationController.toolbarHidden = NO;
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    UIBarButtonItem *kawasan = [[UIBarButtonItem alloc] initWithTitle:@"Lokasi" style:UIBarButtonItemStyleBordered target:self action:@selector(kawasan)];
    self.navigationItem.rightBarButtonItem = kawasan;
    [kawasan release];
    
    JakimSolatParser *parser = [[JakimSolatParser alloc] initWithCode:@"sgr03"];
    parser.delegate = self;
    [parser parse];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)displayData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"WaktuSolat.plist"]; //3
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    waktuSolat = [[NSMutableArray alloc] initWithObjects:[data objectForKey:@"Imsak"], [data objectForKey:@"Subuh"], [data objectForKey:@"Syuruk"], [data objectForKey:@"Zohor"], [data objectForKey:@"Asar"], [data objectForKey:@"Maghrib"], [data objectForKey:@"Isyak"], nil];
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
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [waktuSolatLabel objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [waktuSolat objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
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

- (void)jakimSolatParser:(JakimSolatParser *)parser didParsePrayerTime:(JakimPrayerTime *)prayerTime
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"WaktuSolat.plist"]; //3
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+8"]];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSLog(@"Kawasan = %@", prayerTime.location);
    NSLog(@"Kod = %@", prayerTime.code);

    NSLog(@"Imsak = %@", [dateFormatter stringFromDate:prayerTime.imsak]);
    NSLog(@"Subuh = %@", [dateFormatter stringFromDate:prayerTime.subuh]);
    NSLog(@"Syuruk = %@", [dateFormatter stringFromDate:prayerTime.syuruk]);
    NSLog(@"Zohor = %@", [dateFormatter stringFromDate:prayerTime.zohor]);
    NSLog(@"Asar = %@", [dateFormatter stringFromDate:prayerTime.asar]);
    NSLog(@"Maghrib = %@", [dateFormatter stringFromDate:prayerTime.maghrib]);
    NSLog(@"Isyak = %@", [dateFormatter stringFromDate:prayerTime.isyak]);
    
    [data setObject:[dateFormatter stringFromDate:prayerTime.imsak] forKey:@"Imsak"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.subuh] forKey:@"Subuh"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.syuruk] forKey:@"Syuruk"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.zohor] forKey:@"Zohor"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.asar] forKey:@"Asar"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.maghrib] forKey:@"Maghrib"];
    [data setObject:[dateFormatter stringFromDate:prayerTime.isyak] forKey:@"Isyak"];
    [data setObject:prayerTime.code forKey:@"Code"];
    [data setObject:prayerTime.location forKey:@"Location"];
    
    [data writeToFile:path atomically:YES];
    [data release];
    
    [self displayData];
    NSLog(@"%@", waktuSolat);
}

- (void)jakimSolatParser:(JakimSolatParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"JakimSolatWrapper : Failed!");
}

- (void)dealloc
{
    [waktuSolat release];
    [super dealloc];
}

@end
