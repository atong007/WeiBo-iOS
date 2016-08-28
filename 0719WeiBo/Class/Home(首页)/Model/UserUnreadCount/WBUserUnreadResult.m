//
//  WBUserUnreadResult.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBUserUnreadResult.h"

@implementation WBUserUnreadResult

- (int)messageCount {
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)count {
	return self.messageCount + self.status + self.follower;
}
@end
