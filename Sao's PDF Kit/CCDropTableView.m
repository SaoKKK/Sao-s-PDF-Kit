//
//  CCDropTableView.m
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "CCDropTableView.h"
#import "AppDelegate.h"
#import <Quartz/Quartz.h>

#define BasicTableViewDragAndDropDataType @"BasicTableViewDragAndDropDataType"

@implementation CCDropTableView{
    BOOL bHighLight;
}

- (id)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

//ドラッグを受け付けるファイルタイプを設定
- (void)awakeFromNib{
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,BasicTableViewDragAndDropDataType,nil]];
}

//ハイライトの描画
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if (bHighLight) {
        [[NSColor selectedControlColor]set];
        NSFrameRectWithWidth(dirtyRect, 2.0);
    }
}

//ハイライトの描画を判定
- (void)setInDragging:(BOOL)flg{
    bHighLight = flg;
    [self setNeedsDisplay:YES];
}

// ドロップ可能領域にドラッグ中のマウスポインタが入った
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    [self setInDragging:YES];
    return NSDragOperationGeneric;
}

// ドロップ可能領域内でドラッグ中のマウスポインタが移動中
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender{
    return NSDragOperationGeneric;
}

// ドロップ可能領域からドラッグ中のマウスポインタが外れた
- (void)draggingExited:(id <NSDraggingInfo>)sender{
    [self setInDragging:NO];
}

// ドロップ処理の実行
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    NSArray *dropDataList = [pasteboard propertyListForType:NSFilenamesPboardType];
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    [appD.errLst removeAllObjects];
    for (id path in dropDataList) {
        NSString *uti = [workspace typeOfFile:path error:nil];
        if ([uti isEqualToString:@"com.adobe.pdf"]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            NSDictionary *fInfo;
            NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
            fInfo = [filemgr attributesOfItemAtPath:path error:nil];
            [data setObject:[path lastPathComponent] forKey:@"fName"];
            [data setObject:url forKey:@"fPath"];
            [data setObject:[fInfo objectForKey:NSFileSize] forKey:@"fSize"];
            [data setObject:@"All Pages" forKey:@"pageRange"];
            //PDF情報を取得
            PDFDocument *document;
            document = [[PDFDocument alloc]initWithURL:url];
            NSUInteger totalPage = [document pageCount];
            [data setObject:[NSNumber numberWithUnsignedInteger:totalPage] forKey:@"totalPage"];
            [appD.PDFLst addObject:data];
        }else{
            [appD.errLst addObject:path];
        }
    }
    [self reloadData];
    return YES;
}

// ドロップ処理の完了
- (void)concludeDragOperation:(id <NSDraggingInfo>)sender{
    [self setInDragging:NO];
}

@end
