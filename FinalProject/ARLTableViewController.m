//
//  ARLTableViewController.m
//  FinalProject
//
//  Created by Andrew Langdon on 5/1/14.
//  Copyright (c) 2014 Andrew Langdon. All rights reserved.
//

#import "ARLTableViewController.h"

@interface ARLTableViewController () <UITableViewDataSource, UITableViewDelegate>

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
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.strings.count;
    return 1;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseID"];
    }
    
    cell.textLabel.text = @"temp";
    return cell;
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
