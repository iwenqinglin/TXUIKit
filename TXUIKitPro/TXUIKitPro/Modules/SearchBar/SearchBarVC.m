//
//  SearchBarVC.m
//  TXUIKitPro
//
//  Created by lm69 on 5/18/20.
//  Copyright © 2020 wenqinglin. All rights reserved.
//

#import "SearchBarVC.h"
#import "UISearchBar+TXEvent.h"

@interface SearchBarVC ()<UISearchBarDelegate>
@property(nonatomic, strong) UILabel *label;

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
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
        make.top.equalTo(searchBar.mas_bottom).offset(40);
    }];
    
    [self addSearchBarEvent:searchBar];
}

- (void)addSearchBarEvent:(UISearchBar *)searchBar {
    __weak typeof(self) weakSelf = self;
    [searchBar addEventBlock:^(id control, NSString *searchText, TXSearchBarState state) {
        if (state == TXSearchBarStateHistory) {
            weakSelf.label.text = [NSString stringWithFormat:@"%@\n%@",@"历史记录页面",searchText];
        } else if (state == TXSearchBarStateSearching) {
            weakSelf.label.text = [NSString stringWithFormat:@"%@\n%@",@"正在搜索页面",searchText];
        } else if (state == TXSearchBarStateSearchResult) {
            weakSelf.label.text = [NSString stringWithFormat:@"%@\n%@",@"搜索结果页面",searchText];
        }
    } searchClickBlock:^(id control, NSString *searchText) {
        
    }];
}


#pragma mark - Set/Get
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
