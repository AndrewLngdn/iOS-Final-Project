//
//  ARLTableViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/1/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLTableViewController.h"
#import "ARLInputViewController.h"
#import "ARLStringViewController.h"

@interface ARLTableViewController () <UITableViewDataSource, UITableViewDelegate, ARLInputViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *strings;

@end

@implementation ARLTableViewController

- (instancetype) init
{
    if (self = [self initWithNibName:nil bundle:nil]){
        self.strings = [NSMutableArray array];
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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) addButtonPressed:(UIBarButtonItem *) sender
{
    ARLInputViewController *inputVC = [[ARLInputViewController alloc] init];
    inputVC.delegate = self;
    
    [self presentViewController:inputVC animated:YES completion:nil];
}

- (NSInteger)tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.strings.count;

}

- (void)inputController: (ARLInputViewController *)controller didFinishWithText:(NSString *)text
{
    [self.strings addObject:text];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseID"];
    }
    
    cell.textLabel.text = self.strings[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ARLStringViewController *detailVC = [[ARLStringViewController alloc] initWithRow:indexPath.row
                                                                string:self.strings[indexPath.row]];
    NSLog(@"STUFFFF!!!!");
    NSLog(@"string : %@", self.strings[indexPath.row]);

    
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
