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
@property (nonatomic,readwrite)NSArray *tabList;
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *tabImage;
@property (weak) IBOutlet NSTextField *tabButton1;
@property (weak) IBOutlet NSTextField *tabButton2;
@property (weak) IBOutlet NSTextField *tabButton3;
@property (weak) IBOutlet NSTableView *mergePDFTable;
@property (weak) IBOutlet NSView *mergePDFView;
@property (weak) IBOutlet NSArrayController *PDFLstController;
@property (readwrite,nonatomic)NSMutableArray* PDFLst;
@property (readwrite,nonatomic)NSMutableArray* errLst;

- (void)loadView:(NSString *)viewName;

@end

