//  UISearchBar+TXEvent.m
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/19.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.

#import "UISearchBar+TXEvent.h"

@interface UISearchBar()<UISearchBarDelegate>


@end

static SearchStateChangeBlock g_searchStateBlock;
static SearchButtonClickedBlock g_searchClickBlock;
static CancelButtonClickedBlock g_cancelBlock;

static NSString *g_lastText;//最后一次变更的文本

@implementation UISearchBar(TXEvent)

#pragma mark - Public
- (void)addEventBlock:(SearchStateChangeBlock)stateBlock searchClickBlock:(SearchButtonClickedBlock)searchClickBlock {
    g_searchStateBlock = stateBlock;
    g_searchClickBlock = searchClickBlock;
    self.delegate = self;
}

- (void)addCancelButtonClicked:(CancelButtonClickedBlock)cancelBlock {
    g_cancelBlock = cancelBlock;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    if (g_searchStateBlock) {
        if (self.text.length > 0) {
            g_searchStateBlock(searchBar,searchText,TXSearchBarStateSearching);
        } else {
            g_searchStateBlock(searchBar,searchText,TXSearchBarStateHistory);
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![g_lastText isEqualToString:searchText]) {
        if (g_searchStateBlock) {
            if (searchText.length > 0) {
                g_searchStateBlock(searchBar,searchText,TXSearchBarStateSearching);
            } else {
                g_searchStateBlock(searchBar,searchText,TXSearchBarStateHistory);
            }
        }
    }
    g_lastText = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    if (g_searchStateBlock) {
        if (searchText.length > 0) {
            g_searchStateBlock(searchBar,searchText,TXSearchBarStateSearchResult);
        } else {
            g_searchStateBlock(searchBar,searchText,TXSearchBarStateHistory);
        }
    }

    if (g_searchClickBlock) {
        g_searchClickBlock(searchBar,searchText);
    }
    [self resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if (g_cancelBlock) {
        g_cancelBlock(searchBar,searchBar.text);
    }
}
@end
