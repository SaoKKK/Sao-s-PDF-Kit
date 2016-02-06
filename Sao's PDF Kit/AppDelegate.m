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

@implementation AppDelegate{
    
}

@synthesize tabList,tabButton1,tabButton2,tabButton3,PDFLst,errLst;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
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

- (IBAction)comboPageRange:(id)sender {
    if ([sender indexOfSelectedItem] == 0) {
        [sender setStringValue:@"All Pages"];
        [_window makeFirstResponder:nil];
        [sender setEditable:NO];
    } else if ([sender indexOfSelectedItem] == 1){
        [sender setStringValue:@""];
        [sender setEditable:YES];
        [_window makeFirstResponder:sender];
    }
}

@end
