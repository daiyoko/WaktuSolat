//
//  ViewController.m
//  WaktuSolat
//
//  Created by Sumardi Shukor on 2/25/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "KawasanViewController.h"

@interface KawasanViewController ()

@end

@implementation KawasanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"eSolat" ofType:@"plist"];
    
    kawasan = [[NSDictionary alloc] initWithDictionary:[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"eSolat"]];
    
    self.navigationItem.title = @"Kawasan";
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [kawasan count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[kawasan allValues] objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[kawasan allKeys] objectAtIndex:section];
}

- (void)dealloc
{
    [kawasan dealloc];
    [super dealloc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    }
    
    cell.textLabel.text = [[[[kawasan allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [[[[kawasan allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1]);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"solat.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:[[[[kawasan allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1] forKey:@"Code"];
    [data writeToFile:path atomically:YES];
    [data release];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headerView.png"]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 320, 20)];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    
    return headerView;
}

@end
