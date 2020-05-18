//  UISearchBar+TXEvent.h
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/19.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.


#import <Foundation/Foundation.h>
#import "TXSearchBarDefines.h"

@interface UISearchBar(TXEvent)

//添加搜索状态block、添加搜索点击事件block
- (void)addEventBlock:(SearchStateChangeBlock)stateBlock searchClickBlock:(SearchButtonClickedBlock)searchClickBlock;

//添加点击取消的回调
- (void)addCancelButtonClicked:(CancelButtonClickedBlock)cancelBlock;

@end
