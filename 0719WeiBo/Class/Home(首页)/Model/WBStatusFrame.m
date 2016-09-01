//
//  WBStatusFrame.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/28.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBPicturesView.h"

@implementation WBStatusFrame

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    /**
     *  1.计算原创微博topView及所有子控件的Frame
     */
    /** 顶部的view */
    CGFloat topW = [UIScreen mainScreen].bounds.size.width;

    /** 头像 */
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    CGFloat iconX = WBStatusCellBorder;
    CGFloat iconY = WBStatusCellBorder;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    /** 昵称 */
    NSDictionary *nameAttribute = @{NSFontAttributeName: WBFontOfName};
    CGSize nameS = [status.user.name sizeWithAttributes:nameAttribute];
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + WBStatusCellBorder;
    CGFloat nameY = iconY;
    _nameLabelF =(CGRect){nameX, nameY, nameS};
    
    /** 会员图标 */
    CGFloat vipH = nameS.height;
    CGFloat vipW = vipH;
    CGFloat vipX = CGRectGetMaxX(_nameLabelF) + WBStatusCellBorder;
    CGFloat vipY = nameY;
    _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    
    /** 时间 */
    NSDictionary *timeAttribute = @{NSFontAttributeName: WBFontOfTime};
    CGSize timeS = [status.createdTime sizeWithAttributes:timeAttribute];
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + WBStatusCellBorder * 0.5;
    _timeLabelF = (CGRect){timeX, timeY, timeS};
    
    /** 来源 */
    CGSize sourceS = [status.source sizeWithAttributes:timeAttribute];
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + WBStatusCellBorder;
    CGFloat sourceY = timeY;
    _sourceLabelF = (CGRect){sourceX, sourceY, sourceS};

    /** 正文 */
    NSDictionary *contentAttribute = @{NSFontAttributeName: WBFontOfName};
    CGFloat contentMaxW = topW - 2 * WBStatusCellBorder;
    CGFloat contentH = [status.text boundingRectWithSize:CGSizeMake(contentMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttribute context:nil].size.height;
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + WBStatusCellBorder * 0.5;
    _contentLabelF = CGRectMake(contentX, contentY, contentMaxW, contentH);
    
    CGFloat topH = CGRectGetMaxY(_contentLabelF);
    
    /** 配图 */
    if (status.pic_urls.count) {
        
        CGFloat pictureX = contentX;
        CGFloat pictureY = CGRectGetMaxY(_contentLabelF) + WBStatusCellBorder;
        CGSize pictureS = [WBPicturesView sizeOfPicturesViewWithCount:(int)status.pic_urls.count];
        _pictureViewF = (CGRect){pictureX, pictureY, pictureS};
        
        topH = CGRectGetMaxY(_pictureViewF);
    }else if ([_status.videoStr length] > 0){
        CGFloat videoW = contentMaxW;
        CGFloat videoH = 160;
        CGFloat videoX = WBStatusCellBorder;
        CGFloat videoY = CGRectGetMaxY(_contentLabelF) + WBStatusCellBorder;
        _videoViewF = CGRectMake(videoX, videoY, videoW, videoH);
        
        topH = CGRectGetMaxY(_videoViewF);
    }
    
    /**
     *  2.计算被转发微博及所有子控件的Frame
     */
    if (self.status.retweeted_status) {
        
        /** 昵称 */
        NSString *retweetName = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameS = [retweetName sizeWithAttributes:nameAttribute];
        CGFloat retweetNameX = WBStatusCellBorder;
        CGFloat retweetNameY = WBStatusCellBorder;
        _retweetNameLabelF = (CGRect){retweetNameX, retweetNameY, retweetNameS};
        
        /** 正文 */
        CGFloat retweetContentMaxW = contentMaxW - 2 * WBStatusCellBorder;
        NSDictionary *retweetcontentAttr = @{NSFontAttributeName: WBFontOfContent};
        CGFloat retweetContentH = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:retweetcontentAttr context:nil].size.height;
        CGFloat retweetContentX = retweetNameX;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetNameLabelF) + WBStatusCellBorder * 0.5;
        _retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentMaxW, retweetContentH);
        
        CGFloat retweetViewH = CGRectGetMaxY(_retweetContentLabelF) + WBStatusCellBorder;

        /** 配图 */
        int imageNumber = (int)status.retweeted_status.pic_urls.count;
        if (imageNumber) {
            CGSize pictureS = [WBPicturesView sizeOfPicturesViewWithCount:imageNumber];
            CGFloat pictureX = retweetContentX;
            CGFloat pictureY = CGRectGetMaxY(_retweetContentLabelF) + WBStatusCellBorder;
            _retweetPictureViewF = (CGRect){pictureX, pictureY, pictureS};
            
            retweetViewH = CGRectGetMaxY(_retweetPictureViewF) + WBStatusCellBorder;
        }
        
        CGFloat retweetViewW = contentMaxW;
        CGFloat retweetViewX = contentX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + WBStatusCellBorder * 0.5;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        topH = CGRectGetMaxY(_retweetViewF);
    }
    topH += WBStatusCellBorder;
    _topViewF = CGRectMake(0, 0, topW, topH);
    
    /**
     *  计算工具栏的Frame
     */
    CGFloat toolBarW = topW;
    CGFloat toolBarH = 30;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(_topViewF);
    _statusToolbarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + WBStatusMargin;
}


@end
