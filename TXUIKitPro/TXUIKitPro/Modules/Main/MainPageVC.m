//
//  MainPageVC.m
//  TXUIKitPro
//
//  Created by lm69 on 5/18/20.
//  Copyright © 2020 wenqinglin. All rights reserved.
//

#import "MainPageVC.h"
#import "SearchBarVC.h"


@interface MainPageVC ()

@property (nonatomic, strong) NSArray *sourceArrays;

@end


@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"maincell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArrays.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"maincell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.sourceArrays objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self.sourceArrays objectAtIndex:indexPath.row];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.title = className;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)sourceArrays {
    if (!_sourceArrays) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MainItems" ofType:@"plist"];
        _sourceArrays = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return _sourceArrays;
}



@end
