//
//  mergePDFView.h
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface mergePDFView : NSViewController <NSTableViewDataSource,NSTableViewDelegate>{
    IBOutlet NSTableView *mergePDFtable;
}

@end
