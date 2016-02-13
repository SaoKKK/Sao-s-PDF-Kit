//
//  mergePDFView.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "mergePDFView.h"
#import "AppDelegate.h"
#import <Quartz/Quartz.h>

#define MyTVDragNDropPboardType @"MyTVDragNDropPboardType"

@interface mergePDFView ()

@end

@implementation mergePDFView

//ドラッグを受け付けるファイルタイプを設定
- (void)awakeFromNib{
    [mergePDFtable registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,MyTVDragNDropPboardType,nil]];
    //他アプリケーションからのドラッグアンドドロップを許可
    [mergePDFtable setDraggingSourceOperationMask:NSDragOperationEvery forLocal:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
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
    cellView.objectValue = [data objectForKey:identifier];
    return cellView;
}

//行の選択状態の変化
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    if ([[mergePDFtable selectedRowIndexes]count] != 0) {
        [btnRemove setEnabled:YES];
        if ([[mergePDFtable selectedRowIndexes]count] == 1){
            //PDFViewにPDFドキュメントを設定
            AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
            NSDictionary *data = [appD.PDFLst objectAtIndex:[mergePDFtable selectedRow]];
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *fPath = [data objectForKey:@"fPath"];
            if ([fileMgr fileExistsAtPath:fPath]) {
                NSURL *url = [NSURL fileURLWithPath:fPath];
                PDFDocument *document = [[PDFDocument alloc]initWithURL:url];
                [_pdfView setDocument:document];
            } else {
                //テーブルのデータが実在しない場合
                [_pdfView setDocument:nil];
                
            }
        } else {
            [_pdfView setDocument:nil];
        }
    } else {
        [btnRemove setEnabled:NO];
        [_pdfView setDocument:nil];
    }
}

#pragma mark - Button Action

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

//行追加
- (IBAction)btnAdd:(id)sender{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    NSArray *fileTypes = [NSArray arrayWithObjects:@"pdf", nil];
    [openPanel setAllowedFileTypes:fileTypes];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:YES];
    [openPanel beginSheetModalForWindow:appD.window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            for (NSURL *url in [openPanel URLs]) {
                [self addToPDFLst:url atIndex:appD.PDFLst.count];
            }
            [mergePDFtable reloadData];
            [btnRemove setEnabled:NO];
        }
    }];
}

//行削除
- (IBAction)btnRemove:(id)sender{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSIndexSet *selectedRows = [mergePDFtable selectedRowIndexes];
    [appD.PDFLst removeObjectsAtIndexes:selectedRows];
    [mergePDFtable reloadData];
    [btnRemove setEnabled:NO];
}

//テーブル・クリア
- (IBAction)btnClear:(id)sender {
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    [appD.PDFLst removeAllObjects];
    [mergePDFtable reloadData];
    [btnRemove setEnabled:NO];
}


- (IBAction)btnOpenData:(id)sender {
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    appD.PDFLst = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"PDFLst" ofType:@"array"]];
    [mergePDFtable reloadData];
}

- (IBAction)btnSaveData:(id)sender {
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    [appD.PDFLst writeToFile:[[NSBundle mainBundle] pathForResource:@"PDFLst" ofType: @"array"] atomically:YES];
}

#pragma mark - Drag Operation Method

//ドラッグを開始（ペーストボードに書き込む）
- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard {
    dragRows = rowIndexes;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:[NSArray arrayWithObject:MyTVDragNDropPboardType] owner:self];
    [pboard setData:data forType:MyTVDragNDropPboardType];
    return YES;
}

//ドロップを確認
- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op {
    //間へのドロップのみ認証
    [tv setDropRow:row dropOperation:NSTableViewDropAbove];
    if ([info draggingSource] == tv) {
        return NSDragOperationMove;
    }
    return NSDragOperationEvery;
}

//ドロップ受付開始
- (BOOL)tableView:(NSTableView*)tv acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)op {
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    if (dragRows) {
        //テーブル内の行の移動
        NSUInteger index = [dragRows firstIndex];
        while(index != NSNotFound) {
            //ドロップ先にドラッグ元のオブジェクトを挿入する
            if (row > appD.PDFLst.count) {
                [appD.PDFLst addObject:[appD.PDFLst objectAtIndex:index]];
            }else{
                [appD.PDFLst insertObject:[appD.PDFLst objectAtIndex:index] atIndex:row];
            }
            //ドラッグ元のオブジェクトを削除する
            if (index > row) {
                //indexを後ろにずらす
                [appD.PDFLst removeObjectAtIndex:index + 1];
            }else{
                [appD.PDFLst removeObjectAtIndex:index];
            }
            index = [dragRows indexGreaterThanIndex:index];
            row ++;
        }
        dragRows = nil;
    } else {
        //ファインダからのドロップオブジェクトからPDFファイル情報を取得
        NSPasteboard *pasteboard = [info draggingPasteboard];
        NSArray *dropDataList = [pasteboard propertyListForType:NSFilenamesPboardType];
        NSWorkspace *workSpc = [NSWorkspace sharedWorkspace];
        [appD.errLst removeAllObjects];
        for (id path in dropDataList) {
            NSString *uti = [workSpc typeOfFile:path error:nil];
            NSString *fName = [path lastPathComponent];
            if ([uti isEqualToString:@"com.adobe.pdf"]) {
                [self addToPDFLst:[NSURL fileURLWithPath:path] atIndex:row];
                row ++;
            } else {
                [appD.errLst addObject:fName];
            }
        }
    }
    [tv reloadData];
    if (appD.errLst.count > 0) {
        [appD showErrLst];
    }
    return YES;
}

//PDFファイル情報を配列に追加
- (void)addToPDFLst:(NSURL*)url atIndex:(NSInteger)row{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSDictionary *fInfo = [NSDictionary dictionaryWithDictionary:[fileMgr attributesOfItemAtPath:[url path] error:nil]];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:[url path] forKey:@"fPath"];
    [data setObject:[[url path]lastPathComponent] forKey:@"fName"];
    [data setObject:[fInfo objectForKey:NSFileSize] forKey:@"fSize"];
    [data setObject:@"All Pages" forKey:@"pageRange"];
    //PDF情報を取得
    PDFDocument *document = [[PDFDocument alloc]initWithURL:url];
    NSUInteger totalPage = [document pageCount];
    [data setObject:[NSNumber numberWithUnsignedInteger:totalPage] forKey:@"totalPage"];
    [appD.PDFLst insertObject:data atIndex:row];
}
@end
