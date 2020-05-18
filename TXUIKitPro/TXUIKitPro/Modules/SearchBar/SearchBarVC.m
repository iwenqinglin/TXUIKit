//
//  SearchBarVC.m
//  TXUIKitPro
//
//  Created by lm69 on 5/18/20.
//  Copyright © 2020 wenqinglin. All rights reserved.
//

#import "SearchBarVC.h"

@interface SearchBarVC ()

@end

@implementation SearchBarVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.showsCancelButton = YES;
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    searchBar.tintColor = [UIColor colorWithRed:86/255.0 green:179/255.0 blue:11/255.0 alpha:1];
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(80);
        make.height.equalTo(@42);
    }];
}



@end
