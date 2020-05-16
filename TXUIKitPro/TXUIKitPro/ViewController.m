//
//  ViewController.m
//  TXUIKitPro
//
//  Created by wenqinglin on 2020/5/15.
//  Copyright © 2020年 wenqinglin. All rights reserved.
//

#import "ViewController.h"
#import "TXSearchBar.h"
#import <Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) TXSearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[TXSearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.backgroundColor = [UIColor grayColor];
    
    self.searchBar.placeholder = @"input name";
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@40);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.searchBar addEventBlock:^(TXSearchBarState state, NSString *searchText) {
        NSLog(@"state :%ld   string:%@",state,searchText);
        if (state == TXSearchBarStateHistory) {
            weakSelf.label.text = @"历史记录";
        } else if (state == TXSearchBarStateSearching) {
            weakSelf.label.text = @"正在搜索页面";
        } else if (state == TXSearchBarStateSearchResult) {
            weakSelf.label.text = @"搜索结果页面";
        }
        
    } clickBlock:^(NSString *searchText) {
        NSLog(@"搜索%@",searchText);
        //weakSelf.label.text = @"点击搜索按钮";
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)close:(id)sender {
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
