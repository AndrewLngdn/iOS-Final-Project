//
//  ARLTableViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/1/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLTableViewController.h"
#import "ARLNoteViewController.h"
#import "ARLNoteData.h"

@interface ARLTableViewController () <UITableViewDataSource, UITableViewDelegate, ARLNoteViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *notes;
@property (nonatomic) NSInteger editIndex;

@end

@implementation ARLTableViewController


- (instancetype) init
{
    if (self = [self initWithNibName:nil bundle:nil]){
        self.notes = [self loadArray];
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notes";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNoteButtonPressed:)];

    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
}

#pragma mark - Buttons
// make a new note view when the plus button is pressed
- (void) addNoteButtonPressed:(UIBarButtonItem *) sender
{
    ARLNoteViewController *inputVC = [[ARLNoteViewController alloc] init];
    inputVC.delegate = self;
    
    [self presentViewController:inputVC animated:YES completion:nil];
}

- (NSInteger)tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"row count is %d", self.notes.count);
    NSLog(@"row count is %d", [self.notes count]);
    return self.notes.count;
}

#pragma mark - Delegate Methods
// if we finished creating a new note, add it to our notes array
-(void)inputController:(ARLNoteViewController *)controller didFinishWithNote:(ARLNoteData *)note
{
    [self.notes addObject:note];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self saveArray:self.notes];
    });
}

// if we just finished editing a note, replace the note in the array with this one
- (void)inputController: (ARLNoteViewController *)controller didFinishEditingNote:(ARLNoteData *)note
{
    [self.notes replaceObjectAtIndex:self.editIndex withObject: note];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self saveArray:self.notes];
    });
}

-(void) inputController:(ARLNoteViewController *)controller didFinishWithDelete: (ARLNoteData *) note andWasEditing:(BOOL)editing
{
    if (editing){
        [self.notes removeObjectAtIndex:self.editIndex];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self saveArray:self.notes];
    });
}

#pragma mark - TableView Protocol
// Fill the cells with the titles of the notes
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseID"];
    }

    cell.textLabel.text = ((ARLNoteData *)self.notes[indexPath.row]).titleText;

    return cell;
}

// When a user touches a row, load up the Note View controller with the note
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    ARLNoteViewController *noteVC = [[ARLNoteViewController alloc] initWithNote: self.notes[indexPath.row]];

    self.editIndex = indexPath.row;
    
    noteVC.delegate = self;
    
    [self presentViewController:noteVC animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Data Persistence

// Use nasty methods to get document directory
- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

// Helper for getting datapath
- (NSString *)noteFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"note-data.plist"];
}

// Loads the array from the file or creates an empty mutable array
- (NSMutableArray *)loadArray
{
    NSMutableArray *array;
    NSString *path = [self noteFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        array = [unarchiver decodeObjectForKey:@"notes_array"];
        [unarchiver finishDecoding];
        if ([array count] == 0){
          array = [[NSMutableArray alloc] initWithCapacity:20];
        }
    } else {
        array = [[NSMutableArray alloc] initWithCapacity:20];
    }

    return array;
}

// Used to save the notes array
- (void)saveArray:(NSMutableArray *)array
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:array forKey:@"notes_array"];
    [archiver finishEncoding];
    [data writeToFile:[self noteFilePath] atomically:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
