//  TXSearchBar.h
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/15.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.


#import <UIKit/UIKit.h>

/*
 SearchBar有三种状态：
 1、输入框未输入任何字符，此时=>显示历史记录；
 2、正在输入字符，此时=>显示正在搜索页面；
 3、输入搜索关键字完毕，点击搜索按钮，此时=>显示搜索结果页面。
 */
typedef NS_ENUM(NSInteger, TXSearchBarState) {
    TXSearchBarStateHistory = 0,//显示历史记录
    TXSearchBarStateSearching = 1,//显示正在搜索页面
    TXSearchBarStateSearchResult = 2,//显示搜索结果页面
};

//输入框三种状态的回调
typedef void(^SearchStateChangeBlock)(TXSearchBarState state,NSString *searchText);

//点击搜索按钮的回调
typedef void(^ClickSearchButtonBlock)(NSString *searchText);



//TXSearchBar class
@interface TXSearchBar : UIView

- (instancetype)initWithFrame:(CGRect)frame;
//添加搜索状态block、添加搜索点击事件block
- (void)addEventBlock:(SearchStateChangeBlock)stateBlock clickBlock:(ClickSearchButtonBlock)clickBlock;

- (void)resignFirstResponder;



@property(nonatomic, copy) NSString *placeholder;
@property(nonatomic, copy) NSString *searchText;

@end
