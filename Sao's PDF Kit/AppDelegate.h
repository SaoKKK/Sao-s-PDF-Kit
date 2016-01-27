//
//  AppDelegate.h
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/01/27.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    IBOutlet NSView *_contentView;
}

@property (nonatomic,readonly) NSViewController *currentViewController;

@end

