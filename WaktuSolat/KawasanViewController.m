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
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"eSolat" ofType:@"plist"];
    
    kawasan = [[NSDictionary alloc] initWithDictionary:[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"eSolat"]];
    
    self.navigationItem.title = @"Kawasan";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    }
    
    // do something
    
    cell.textLabel.text = [[[[kawasan allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}

@end
