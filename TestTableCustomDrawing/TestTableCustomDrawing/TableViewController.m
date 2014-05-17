//
//  TableViewController.m
//  TestTableCustomDrawing
//
//  Created by Alexander on 15.05.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
{
    void(^actionPressed)();
}
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    actionPressed = ^(){
        NSLog(@"%@", [self.tableView.indexPathsForVisibleRows firstObject]);
    };
}

- (IBAction)actionPressed:(id)sender
{
    actionPressed();
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    for(UIView *v in cell.contentView.subviews) {
        v.layer.masksToBounds = NO;
        v.layer.cornerRadius = 10;
        v.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        v.layer.shadowRadius = 2.0;
        v.layer.shadowOpacity = 1.0;
        v.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
    return cell;
}

- (void)dealloc
{
    NSLog(@"%@", @"213124124142134321");
}

@end
