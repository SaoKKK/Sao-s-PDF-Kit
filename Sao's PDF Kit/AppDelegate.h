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
    IBOutlet NSTableView *errTable;
}

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *sheetWin;
@property (weak) IBOutlet NSImageView *tabImage;
@property (weak) IBOutlet NSTextField *tabButton1;
@property (weak) IBOutlet NSTextField *tabButton2;
@property (weak) IBOutlet NSTextField *tabButton3;
@property (readonly,nonatomic)NSViewController *currentViewController;
@property (readwrite,nonatomic)NSArray *tabList;
@property (readwrite,retain,nonatomic)NSMutableArray* PDFLst;
@property (readwrite,retain,nonatomic)NSMutableArray* errLst;

- (void)loadView:(NSString *)viewName;
- (void)showErrLst;

@end

