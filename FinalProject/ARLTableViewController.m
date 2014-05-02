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

@property (nonatomic, strong) NSMutableArray *strings;

@property (nonatomic, strong) NSMutableArray *notes;

@property (nonatomic) NSInteger editIndex;

@end

@implementation ARLTableViewController

- (instancetype) init
{
    if (self = [self initWithNibName:nil bundle:nil]){
        self.strings = [NSMutableArray array];
        self.notes = [NSMutableArray array];
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
    
    self.title = @"List";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNoteButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) addNoteButtonPressed:(UIBarButtonItem *) sender
{
    ARLNoteViewController *inputVC = [[ARLNoteViewController alloc] init];
    inputVC.delegate = self;
    
    [self presentViewController:inputVC animated:YES completion:nil];
}

- (NSInteger)tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;

}

-(void)inputController:(ARLNoteViewController *)controller didFinishWithNote:(ARLNoteData *)note
{
    [self.notes addObject:note];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)inputController: (ARLNoteViewController *)controller didFinishEditingNote:(ARLNoteData *)note
{
    [self.notes replaceObjectAtIndex:self.editIndex withObject: note];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseID"];
    }
    
    cell.textLabel.text = ((ARLNoteData *)self.notes[indexPath.row]).titleText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    ARLNoteViewController *noteVC = [[ARLNoteViewController alloc] initWithNote: self.notes[indexPath.row]];

    self.editIndex = indexPath.row;
    
    noteVC.delegate = self;
    
    [self presentViewController:noteVC animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
