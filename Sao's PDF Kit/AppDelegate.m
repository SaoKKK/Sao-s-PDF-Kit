//
//  AppDelegate.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/01/27.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize tabList,tabButton1,tabButton2,tabButton3,PDFLst,errLst;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self loadView:@"mergePDFView"];
    tabList = [NSArray arrayWithObjects:tabButton1,tabButton2,tabButton3,nil];
}

- (id)init{
    self = [super init];
    if (self) {
        PDFLst = [NSMutableArray array];
        errLst = [NSMutableArray array];
    }
    return self;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

- (void)loadView:(NSString *)viewName{
    if(_currentViewController){
        [[_currentViewController view] removeFromSuperview];
    }
    _currentViewController = [[NSViewController alloc]initWithNibName:viewName bundle:nil];
    NSView *view = [_currentViewController view];
    [_contentView addSubview:view];
}

@end
