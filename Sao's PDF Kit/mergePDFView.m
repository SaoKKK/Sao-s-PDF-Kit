//
//  mergePDFView.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "mergePDFView.h"
#import "AppDelegate.h"

#define BasicTableViewDragAndDropDataType @"BasicTableViewDragAndDropDataType"

@interface mergePDFView ()

@end

@implementation mergePDFView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)pshAddPDF:(id)sender {
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSLog(@"%@",appD.PDFLst);
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
    if ([identifier isEqualToString:@"fSize"] || [identifier isEqualToString:@"pageRange"]) {
        cellView.objectValue = [data objectForKey:identifier];
    } else {
        cellView.textField.stringValue = [data objectForKey:identifier];
    }
    return cellView;
}

//コンボボックス・アクション/データ更新
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
    NSInteger row = [mergePDFtable rowForView:sender];
    NSDictionary *data = [appD.PDFLst objectAtIndex:row];
    [data setValue:[sender stringValue] forKey:@"pageRange"];
    [appD.PDFLst replaceObjectAtIndex:row withObject:data];
}

#pragma mark - MergePDFLst／Drag Operation

//ドラッグを受け付けるファイルタイプを設定
- (void)awakeFromNib{
    [mergePDFtable registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,BasicTableViewDragAndDropDataType,nil]];
}

//ドラッグ開始（ペーストボードに書き込む）
 - (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(nonnull NSIndexSet *)rowIndexes toPasteboard:(nonnull NSPasteboard *)pboard{
     dragRows = rowIndexes;
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
     [pboard declareTypes:[NSArray arrayWithObject:BasicTableViewDragAndDropDataType] owner:self];
     [pboard setData:data forType:BasicTableViewDragAndDropDataType];
     return YES;
 }
 
//ドロップを確認
- (NSDragOperation)tableview:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op{
    //間へのドロップのみ認証
    NSLog (@"validate");
    [tv setDropRow:row dropOperation:NSTableViewDropAbove];
    if ([info draggingSource] == mergePDFtable) {
        return NSDragOperationMove;
    }
    return NSDragOperationEvery;
}

//ドロップ受付開始
- (BOOL)tableView:(NSTableView *)tv acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation{
    NSLog (@"accept");
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSUInteger index = [dragRows firstIndex];
    while (index != NSNotFound) {
        //ドロップ先にドラッグ元のオブジェクトを挿入する
        if (row > appD.PDFLst.count) {
            [appD.PDFLst addObject:[appD.PDFLst objectAtIndex:index]];
        } else {
            [appD.PDFLst insertObject:[appD.PDFLst objectAtIndex:index] atIndex:row];
        }
        //ドラッグ元のオブジェクトを削除する
        if (index > row) {
            //挿入した分だけインデクスを後ろにずらす
            [appD.PDFLst removeObjectAtIndex:index + 1];
        } else {
            [appD.PDFLst removeObjectAtIndex:index];
        }
        row ++;
    }
    [mergePDFtable reloadData];
    return YES;
}

@end
