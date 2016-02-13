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

@synthesize tabList,tabButton1,tabButton2,tabButton3,PDFLst,errLst,window,sheetWin,statusWin;

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
    view.frame = _contentView.bounds;
    [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [_contentView addSubview:view];
}

#pragma mark - Sheet window controll
- (void)showErrLst{
    [errTable reloadData];
    [[NSApplication sharedApplication] beginSheet:sheetWin modalForWindow:window modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)sheetDidEnd:(NSWindow*)sheet returnCode:(int)returnCode contextInfo:(void*)contextInfo{
    [sheet orderOut:self];
}

- (IBAction)pshOK:(id)sender {
    [[NSApplication sharedApplication] endSheet:sheetWin returnCode:0];
}

@end
