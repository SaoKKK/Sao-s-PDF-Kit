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

@end
