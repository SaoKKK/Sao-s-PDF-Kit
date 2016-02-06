//
//  mergePDFView.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "mergePDFView.h"
#import "AppDelegate.h"

@interface mergePDFView ()

@end

@implementation mergePDFView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)comboPageRange:(id)sender {
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    if ([sender indexOfSelectedItem] == 0) {
        [sender setStringValue:@"All Pages"];
        [appD.window makeFirstResponder:nil];
        [sender setEditable:NO];
    } else if ([sender indexOfSelectedItem] == 1){
        [sender setStringValue:@""];
        [sender setEditable:YES];
        [appD.window makeFirstResponder:sender];
    }
}

# pragma mark - NSTableView data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    return appD.PDFLst.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSString *identifier = [tableColumn identifier];
    NSDictionary *data = [appD.PDFLst objectAtIndex:row];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.stringValue = [data objectForKey:identifier];
    return cellView;
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
    if ([info draggingSource] == mergePDFtable) {
        return NSDragOperationMove;
    }
    return NSDragOperationEvery;
}

//ドロップ受付開始
- (BOOL)tableView:(NSTableView *)tv acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation{
    return YES;
}

@end
