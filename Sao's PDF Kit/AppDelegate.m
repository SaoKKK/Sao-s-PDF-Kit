//
//  AppDelegate.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/01/27.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self loadView:@"mergePDFView"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)loadView:(NSString *)viewName{
    if(_currentViewController){
        [[_currentViewController view] removeFromSuperview];
    }
    _currentViewController = [[NSViewController alloc]initWithNibName:viewName bundle:nil];
    NSView *view = [_currentViewController view];
    [_contentView addSubview:view];
}

- (IBAction)pshLoadMergePDFView:(id)sender {
    [self loadView:@"mergePDFView"];
}

- (IBAction)pshLoadSplitPDFView:(id)sender {
    [self loadView:@"splitPDFView"];
}
@end
