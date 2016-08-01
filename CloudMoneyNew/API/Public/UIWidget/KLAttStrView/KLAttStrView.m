//
//  KLAttStrView.m
//  CloudMoneyNew
//
//  Created by nice on 16/7/29.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "KLAttStrView.h"
#import <CoreText/CoreText.h>
@interface KLAttStrView ()

/**
 * @brief <#Description#>
 */
@property (nonatomic, assign) CTFrameRef textFrame;

@end

@implementation KLAttStrView

- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr{
    self = [super init];
    if (self) {
        self.attributedString = attrStr;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置每个字形都不做图形变换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //x，y轴方向移动
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 绘制尺寸
    CGPathAddRect(path, NULL, self.bounds);
    
    // 生成文字区域frame
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(self.attributedString));
    
    // 根据绘制区域及富文本，设置_textFrame，该_textFrame只是富文本的frame
    _textFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);

    // 根据_textFrame绘制文字
    CTFrameDraw(_textFrame, context);
    
    CFRelease(path);
    CFRelease(frameSetter);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint location = [self systemPointFromScreenPoint:[touch locationInView:self]];
    [self ClickStrAtPoint:location];
}

- (void)ClickStrAtPoint:(CGPoint)location {
    NSArray * lines = (NSArray *)CTFrameGetLines(_textFrame);
    //获取每行原点坐标
    CFRange ranges[lines.count];
    CGPoint origins[lines.count];
    CTFrameGetLineOrigins(_textFrame, CFRangeMake(0, 0), origins);
    
    for (int i = 0; i < lines.count; i ++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        CFRange range = CTLineGetStringRange(line);
        ranges[i] = range;
    }
    
    for (NSUInteger i = 0; i < self.attributedString.length; i ++) {
        long maxLoc;
        int lineNum;
        for (int j = 0; j < lines.count; j ++) {
            CFRange range = ranges[j];
            maxLoc = range.location + range.length - 1;
            if (i <= maxLoc) {
                lineNum = j;
                break;
            }
        }
        CTLineRef line = (__bridge CTLineRef)lines[lineNum];
        CGPoint origin = origins[lineNum];
        CGRect CTRunFrame = [self frameForCTRunWithIndex:i CTLine:line origin:origin];
        if ([self isFrame:CTRunFrame containsPoint:location]) {
            // 点击到了文字
            if (_clickAction) {
                _clickAction(i);
            }
            return;
        }
    }
}



- (BOOL)isIndex:(NSInteger)index inRange:(NSRange)range {
    if ((index <= range.location + range.length - 1) && (index >= range.location)) {
        return YES;
    }
    return NO;
}

- (CGPoint)systemPointFromScreenPoint:(CGPoint)origin {
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}

- (BOOL)isFrame:(CGRect)frame containsPoint:(CGPoint)point {
    return CGRectContainsPoint(frame, point);
}

- (CGRect)frameForCTRunWithIndex:(NSInteger)index CTLine:(CTLineRef)line origin:(CGPoint)origin {
    
    CGFloat offsetX = CTLineGetOffsetForStringIndex(line, index, NULL);
    CGFloat offsexX2 = CTLineGetOffsetForStringIndex(line, index + 1, NULL);
    offsetX += origin.x;
    offsexX2 += origin.x;
    CGFloat offsetY = origin.y;
    CGFloat lineAscent;
    CGFloat lineDescent;
    NSArray * runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
    CTRunRef runCurrent;
    for (int k = 0; k < runs.count; k ++) {
        CTRunRef run = (__bridge CTRunRef)runs[k];
        CFRange range = CTRunGetStringRange(run);
        NSRange rangeOC = NSMakeRange(range.location, range.length);
        if ([self isIndex:index inRange:rangeOC]) {
            runCurrent = run;
            break;
        }
    }
    CTRunGetTypographicBounds(runCurrent, CFRangeMake(0, 0), &lineAscent, &lineDescent, NULL);
    CGFloat height = lineAscent + lineDescent;
    return CGRectMake(offsetX, offsetY, offsexX2 - offsetX, height);
}


@end
