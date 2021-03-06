//
//  addTextFile.m
//  MultipleDetailViews
//
//  Created by Kowshik Gurram on 11/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addTextFile.h"
#import "databaseManager.h"
#import "NotesTableViewController.h"
#include "FileViewController.h"
@implementation addTextFile
@synthesize description, delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//this function will add new note to database
-(void)addNote
{
    databaseManager *dbManager=[[databaseManager alloc] init];
    [dbManager updateNames];
    dbManager.db = [FMDatabase databaseWithPath:dbManager.databasePath];
    if(![dbManager.db open]){
        NSLog(@"Could not open db.");
        [dbManager release];
        return;
    }
    else{
        NSLog(@"database is open.");
    }
    NSDate *now = [NSDate date];
    description=textview.text;
    int fileid=self.delegate.fileVC.fileID;
    NSDate *openedDate=self.delegate.fileVC.openedDate;
    //inserting to anotationTable
    NSString* query = [[NSString alloc] initWithString:[NSString stringWithFormat:@"insert into anotationTable (fid,description,annotationdate) values (%d,'%@','%@')",fileid,description,now]];
    //we also update the record in the history table
    NSString* query1 = [[NSString alloc] initWithString:[NSString stringWithFormat:@"UPDATE filehistory SET description='%@' WHERE fid='%d' and openeddate='%@'",description,fileid,openedDate]];
    BOOL suc = [dbManager.db executeUpdate:query];
    BOOL suc1 = [dbManager.db executeUpdate:query1];
    //checking if botht the queries are successful
    if(suc && suc1)
        NSLog(@"insert is successful.");
    else
        NSLog(@"insert failed.");
    
    [query release];
    [query1 release];
    [dbManager.db close];
    [dbManager release];
    [self cancelNote];
}

-(void)cancelNote
{
    [self.delegate loadAnnoataions];
    [self.delegate.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    description=textView.text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.title=@"Add Notes";
    self.navigationItem.rightBarButtonItem = doneButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNote)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [doneButton release];
    [cancelButton release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [textview release];
    textview = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [textview release];
    [super dealloc];
}
@end
