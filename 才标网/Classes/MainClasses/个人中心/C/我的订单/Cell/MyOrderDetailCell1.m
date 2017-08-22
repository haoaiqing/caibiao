//
//  MyOrderDetailCell1.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderDetailCell1.h"
@interface MyOrderDetailCell1()
@property (nonatomic, strong) UILabel *statusLabel, *payWayLabel, *dateLabel, *nameLabel, *addressLabel;
@property (nonatomic, strong) UIImageView *proImageView;
@end

@implementation MyOrderDetailCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

- (void)drawView{

    _statusLabel = [self creatLabelWithTitle:@""];
    _payWayLabel = [self creatLabelWithTitle:@"付款方式："];
    _dateLabel = [self creatLabelWithTitle:@"订单日期："];
    _nameLabel = [self creatLabelWithTitle:@""];
    _nameLabel.textColor = COLOR_Black;
    
    _addressLabel = [self creatLabelWithTitle:@"江苏省无锡市xx大厦"];
    _addressLabel.numberOfLines = 0;
    _addressLabel.textColor = COLOR_Black;
    
    _proImageView = [[UIImageView alloc] init];
    _proImageView.image = [UIImage imageNamed:@"uc_order_default_70x75"];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    
    UIImageView *addressImageView = [[UIImageView alloc] init];
    addressImageView.image = [UIImage imageNamed:@"m_order_address_12x15"];
    
    
    [self.contentView sd_addSubviews:@[_statusLabel, _payWayLabel, _dateLabel, _proImageView, dividerLine1, _nameLabel]];//addressImageView, _addressLabel

    _statusLabel.sd_layout
    .leftSpaceToView(self.contentView, 10*UIRate)
    .topSpaceToView(self.contentView, 25*UIRate)
    .widthIs(200*UIRate)
    .heightIs(15*UIRate);
    
    _payWayLabel.sd_layout
    .leftEqualToView(_statusLabel)
    .topSpaceToView(_statusLabel, 10*UIRate)
    .widthIs(200*UIRate)
    .heightIs(15*UIRate);
    
    _dateLabel.sd_layout
    .leftEqualToView(_statusLabel)
    .topSpaceToView(_payWayLabel, 10*UIRate)
    .widthIs(200*UIRate)
    .heightIs(15*UIRate);

    _proImageView.sd_layout
    .rightSpaceToView(self.contentView,30*UIRate)
    .centerYEqualToView(_payWayLabel)
    .widthIs(100*UIRate)
    .heightIs(100*UIRate);
    
    dividerLine1.sd_layout
    .leftSpaceToView(self.contentView, 10*UIRate)
    .topSpaceToView(self.contentView, 115*UIRate)
    .widthIs(ScreenWidth - 10*UIRate)
    .heightIs(1);
    
    _nameLabel.sd_layout
    .leftEqualToView(_statusLabel)
    .topSpaceToView(dividerLine1, 15*UIRate)
    .widthIs(200*UIRate)
    .heightIs(15*UIRate);
    
    addressImageView.sd_layout
    .leftEqualToView(_statusLabel)
    .topSpaceToView(_nameLabel, 8*UIRate)
    .widthIs(12*UIRate)
    .heightIs(15*UIRate);
    
    _addressLabel.sd_layout
    .leftSpaceToView(addressImageView,3*UIRate)
    .centerYEqualToView(addressImageView)
    .widthIs(ScreenWidth - 40*UIRate)
    .autoHeightRatio(0);
}

- (UILabel *)creatLabelWithTitle:(NSString *)title{
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = title;
    textlabel.font = SYSTEM_FONT_(15*UIRate);
    textlabel.textColor = COLOR_Gray;

    return textlabel;
}

- (void)setModel:(OrderModel *)model{
    
    _model = model;
    
    _statusLabel.text = model.order_status;
    
    _payWayLabel.text = [NSString stringWithFormat:@"付款方式：%@",model.payment_method?:@""];
    
    _dateLabel.text = [NSString stringWithFormat:@"订单日期：%@",model.date_added?:@""];
    
    _nameLabel.text = model.payment_customer_name;
}

@end
