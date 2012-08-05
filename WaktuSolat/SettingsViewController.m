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
        if(indexPath.row == 0) {
            /* Add some function here */
        } else if(indexPath.row == 1) {
            /* Add some function here */
        } else if(indexPath.row == 2) {
            [self showEmailModalView];
        }
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

- (void)showEmailModalView
{
	if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Feedback"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"syahmi@wutmedia.com", nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
        
        [mailer release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Your device doesn't support the composer sheet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
	
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void) dealloc
{
    [settingsView release];
    [super dealloc];
}

@end