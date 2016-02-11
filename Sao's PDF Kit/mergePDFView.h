//
//  mergePDFView.h
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface mergePDFView : NSViewController <NSTableViewDataSource,NSTableViewDelegate>{
    @private
    IBOutlet NSTableView *mergePDFtable;
    IBOutlet NSButton *btnRemove;
    NSIndexSet *dragRows; //ドラッグ中の行インデクスを保持
}

@end
