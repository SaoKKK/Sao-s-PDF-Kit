//
//  mergePDFView.h
//  Sao's PDF Kit
//
//  Created by 河野 さおり on 2016/02/06.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface mergePDFView : NSViewController<NSTableViewDelegate,NSTableViewDataSource>{
    @private
    IBOutlet NSTableView *_tableView;
}

@end
