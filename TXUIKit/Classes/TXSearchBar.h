//  TXSearchBar.h
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/15.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.


#import <UIKit/UIKit.h>

/*
 SearchBar有三种状态：
 1、输入框未输入任何字符，此时搜索结果显示历史记录；
 2、正在输入字符，此时搜索结果显示已输入字符作为key的搜索结果；
 3、输入完毕，点击搜索按钮，此时应该显示文本框的字符作为key的搜索结果。
 */
typedef NS_ENUM(NSInteger, TXSearchBarState) {
    TXSearchBarStateNormal = 0,//输入框未输入任何字符
    TXSearchBarStateEditing = 1,//正在输入字符
    TXSearchBarStateEnd = 2,//输入完毕，点击搜索按钮
};

//输入框三种状态的回调
typedef void(^SearchStateChangeBlock)(TXSearchBarState state,NSString *searchText);

//点击搜索按钮的回调
typedef void(^ClickSearchButtonBlock)(NSString *searchText);

@interface TXSearchBar : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)addEventBlock:(SearchStateChangeBlock)stateBlock clickBlock:(ClickSearchButtonBlock)clickBlock;

- (void)resignFirstResponder;

@property(nonatomic, strong) NSString *placeholder;

@end
