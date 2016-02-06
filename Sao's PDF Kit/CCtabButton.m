//
//  CCtabButton.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/01/29.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "CCtabButton.h"
#import "AppDelegate.h"

@implementation CCtabButton


static NSColor*	_activeColor = nil;

- (id)init{
    if(self){
    _activeColor =[NSColor colorWithCalibratedRed:60 green:70 blue:70 alpha:1.0];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

//タブの切り替え
- (void)mouseDown:(NSEvent *)theEvent{
    AppDelegate* appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    [appD.tabImage setImage:[NSImage imageNamed:self.identifier]];
    for (NSTextField *tab in appD.tabList){
        if ([tab.identifier isEqualTo: self.identifier]) {
            [self setTextColor:_activeColor];
        }else{
            [tab setTextColor:[NSColor whiteColor]];
        }
    }
    [appD.tabView selectTabViewItemWithIdentifier:[NSString stringWithFormat:@"%@View",self.identifier]];
}

@end
