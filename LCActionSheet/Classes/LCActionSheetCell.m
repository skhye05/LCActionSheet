//
//  LCActionSheetCell.m
//  LCActionSheet
//
//  Created by Leo on 2016/7/15.
//
//  Copyright (c) 2015-2019 Leo <leodaxia@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


#import "LCActionSheetCell.h"
#import "Masonry.h"
#import "LCActionSheetConfig.h"

#define LCImage(fileName)   [UIImage imageNamed:[@"LCActionSheet.bundle" stringByAppendingPathComponent:fileName]] ? : [UIImage imageNamed:[@"Frameworks/LCActionSheet.framework/LCActionSheet.bundle" stringByAppendingPathComponent:fileName]]



@interface LCActionSheetCell ()

/**
 *  Highlighted View.
 */
@property (nonatomic, weak) UIView *highlightedView;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation LCActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
//        UIView *selBgView = [[UIView alloc] init];
//        selBgView.backgroundColor = LC_ACTION_SHEET_BG_COLOR_HIGHLIGHTED;
//        self.selectedBackgroundView = selBgView;
        
        
        UIView *highlightedView = [[UIView alloc] init];
        highlightedView.backgroundColor = self.cellSeparatorColor;
        highlightedView.clipsToBounds   = YES;
        highlightedView.hidden          = YES;
        [self.contentView addSubview:highlightedView];
        self.highlightedView = highlightedView;
        [highlightedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
       
        
        // make.edges.equalTo(self.contentView).insets(self.buttonEdgeInsets);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentLeft; 
        // titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.equalTo(self.contentView);
        }];   
        
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(self.buttonEdgeInsets);
            make.centerY.equalTo(self.contentView);
        }];
            
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = self.cellSeparatorColor;
        lineView.contentMode   = UIViewContentModeBottom;
        lineView.hidden = true;
        lineView.clipsToBounds = YES;
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.offset(1 / 3.0);
        }];
    }
    return self;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = LCImage(@"AAicon_check.png");
    }
    return _iconImageView;
}

- (void)setButtonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets {
    _buttonEdgeInsets = buttonEdgeInsets;

    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(self.buttonEdgeInsets);
        make.left.equalTo(self.contentView).offset(80);
    }];
}


- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor {
    _cellSeparatorColor = cellSeparatorColor;
    
    self.highlightedView.backgroundColor = cellSeparatorColor;
    self.lineView.backgroundColor = cellSeparatorColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (self.tag == LC_ACTION_SHEET_CELL_HIDDE_LINE_TAG) {
        self.lineView.hidden = YES;
    } else {
        self.lineView.hidden = highlighted;
    }
    
    self.highlightedView.hidden = !highlighted;
}

- (void)setIconImage:(UIImage *)iconImage {
    if (_iconImage != iconImage) {
        _iconImage               = iconImage;
        self.iconImageView.image = iconImage;
    }
}

@end
