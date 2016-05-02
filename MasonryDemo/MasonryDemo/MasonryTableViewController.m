//
//  MasonryTableViewController.m
//  MasonryDemo
//
//  Created by ZeluLi on 16/5/2.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import "MasonryTableViewController.h"
#import "SubViewController.h"
#import "BaicView.h"

static NSString * const CellReuseIdentifier = @"kCellReuseIdentifier";

@interface MasonryTableViewController ()

@property (nonatomic, strong) NSArray *viewClasses;
@property (nonatomic, strong) NSDictionary *cellTitles;

@end

@implementation MasonryTableViewController

-(instancetype)init {
    if (self == nil) {
        self = [super init];
    }
    self.title = @"示例";
    self.viewClasses = @[BaicView.class];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:CellReuseIdentifier];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewClasses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.viewClasses[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class viewClass = self.viewClasses[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@", viewClass];
    SubViewController *subViewController = [[SubViewController alloc] initWithTitle:title viewClass:viewClass];
    [self.navigationController pushViewController:subViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
