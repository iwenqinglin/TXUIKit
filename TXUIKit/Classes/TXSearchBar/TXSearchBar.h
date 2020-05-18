//  TXSearchBar.h
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/15.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.


#import <UIKit/UIKit.h>
#import "TXSearchBarDefines.h"

//TXSearchBar class
@interface TXSearchBar : UIView


- (instancetype)initWithFrame:(CGRect)frame;
//添加搜索状态block、添加搜索点击事件block
- (void)addEventBlock:(SearchStateChangeBlock)stateBlock clickBlock:(SearchButtonClickedBlock)clickBlock;

- (void)resignFirstResponder;



@property(nonatomic, copy) NSString *placeholder;
@property(nonatomic, copy) NSString *searchText;

@end
