//
//  WBStatus.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatus.h"
#import "MJExtension.h"
#import "WBThumbnailPic.h"
#import "WBVideoUrlAnalysisTool.h"

@implementation WBStatus

//- (void)setPic_urls:(NSArray *)pic_urls
//{
//    _pic_urls = pic_urls;
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSDictionary *dict in pic_urls) {
//        WBThumbnailPic *pic = [WBThumbnailPic thumbnailPicWithDictionary:dict];
//        [array addObject:pic];
//
//    }
//    _pic_urls = array;
//}

/**
 *  MJ的扩展方法,只要指定array里面的字典需要转成的对象参数,
 就可自动转换,效果同上诉注释的重写setting
 *
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [WBThumbnailPic class]};
}

- (NSString *)createdTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat       = @"EEE MMMM dd HH:mm:ss Z yyyy";
    // 在系统为中文系统时,需要用下列设置为英文才有办法解析,否则为空
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [formatter dateFromString:_created_at];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit             = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    if (createdDate) {
        // 获得self的时分秒
        NSDateComponents *selfCmps = [calendar components:unit fromDate:createdDate];
        // 获得当前时间的时分秒
        NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
        
        
        if ([calendar isDateInToday:createdDate]) {
            /**
             *  是今天:
             如果1分钟内 >显示刚刚
             如果一个小时前 >显示xx分钟前
             其他  >显示xx小时前
             */
            float result = (nowCmps.hour - selfCmps.hour) * 60.0 + (nowCmps.minute - selfCmps.minute);
            if (result < 1) {
                return @"刚刚";
            }else if (result < 60.0){
                return [NSString stringWithFormat:@"%d分钟前", (int)result];
            }else{
                return [NSString stringWithFormat:@"%ld小时前", nowCmps.hour - selfCmps.hour];
            }
        }else if ([calendar isDateInYesterday:createdDate]){
            return [NSString stringWithFormat:@"昨天 %ld:%02ld", selfCmps.hour, selfCmps.minute];
        }else if (selfCmps.year != nowCmps.year){
            return [NSString stringWithFormat:@"%ld-%ld-%ld", selfCmps.year - 2000, selfCmps.month, selfCmps.day];
        }else{
            return [NSString stringWithFormat:@"%ld-%ld", selfCmps.month, selfCmps.day];
        }
    }
    return _created_at;
}

- (void)setSource:(NSString *)source
{
    _source            = [source copy];
    NSInteger location = [source rangeOfString:@">"].location;
    if (location != NSNotFound) {
        location           += 1;
        NSInteger length   = [source rangeOfString:@"</"].location - location;
        if (location - 1 != NSNotFound) {
            source             = [source substringWithRange:NSMakeRange(location, length)];
        }
        _source = [NSString stringWithFormat:@"来自%@",source];
    }
}

- (void)setText:(NSString *)text
{
    _text              = text;
    NSInteger location = [text rangeOfString:@"http://t.cn/"].location;
    if (location != NSNotFound) {
        NSString *videoUrl = [text substringWithRange:NSMakeRange(location, 19)];
        _videoStr = videoUrl;
        _text = [text stringByReplacingOccurrencesOfString:videoUrl withString:@""];
    }else {
        _videoStr = nil;
    }
}

MJCodingImplementation
@end
