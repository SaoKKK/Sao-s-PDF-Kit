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

@synthesize tabList,mergePDFTable,tabButton1,tabButton2,tabButton3,PDFLst,errLst;

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

#pragma mark - MergePDFLst／Drag Operation

//ドラッグ（ペーストボードに書き込む）を開始
- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(nonnull NSIndexSet *)rowIndexes toPasteboard:(nonnull NSPasteboard *)pboard{
    NSLog(@"dragging");
    return YES;
}

//ドロップを確認
- (NSDragOperation)tableview:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op{
    //間へのドロップのみ認証
    [tv setDropRow:row dropOperation:NSTableViewDropAbove];
    if ([info draggingSource] == mergePDFTable) {
        return NSDragOperationMove;
    }
    return NSDragOperationEvery;
}

//ドロップ受付開始
- (BOOL)tableView:(NSTableView *)tv acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation{
    return YES;
}
@end
