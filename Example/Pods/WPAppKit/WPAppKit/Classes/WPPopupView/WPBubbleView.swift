//
//  WPBubbleView.swift
//  PopViewDemo
//
//  Created by 王鹏 on 2019/3/26.
//  Copyright © 2019年 wangpeng. All rights reserved.
//

import UIKit

open class WPBubbleView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    private var clickBlock: PopupClickButtonBlock?
    private var style: WPPopupStyle!
    private var cellHeight: CGFloat = 50
    private var sourceArray = ItemArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 通过触发显示的view 初始化BubbleView
    public convenience init(fromReact: CGRect, style: WPPopupStyle, viewSize: CGSize, imageNameAndTitle dataArray: ItemArray, clickBlock: @escaping PopupClickButtonBlock) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        self.style = style
        self.cellHeight = viewSize.height / CGFloat(dataArray.count)
        self.sourceArray = dataArray
        self.clickBlock = clickBlock
        self.addSubview(self.tableView)
        
        self.settingFrame(fromReact: fromReact, size: viewSize)
        self.addTriangleView(size: viewSize)
        self.settingCorner()
    }
    
    /// 通过自定义位置 初始化BubbleView
    public convenience init(startPoint: CGPoint, style: WPPopupStyle, viewSize: CGSize, imageNameAndTitle dataArray: ItemArray, clickBlock: @escaping PopupClickButtonBlock) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        self.style = style
        self.cellHeight = viewSize.height / CGFloat(dataArray.count)
        self.sourceArray = dataArray
        self.clickBlock = clickBlock
        self.addSubview(self.tableView)
        
        self.settingFrameFromPoint(startPoint: startPoint, size: viewSize)
        self.addTriangleView(size: viewSize)
        self.settingCorner()
    }
    
    // 使用frame设置位置
    private func settingFrameFromPoint(startPoint: CGPoint,size: CGSize) {
        switch self.style.triangleOrientation {
        case .top:
            let selfX = startPoint.x - size.width/2 - 5
            let selfY = startPoint.y
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width, height: size.height + 5)
            self.tableView.frame = CGRect.init(x: 0, y: 5, width: size.width, height: size.height)
            break
        case .left:
            let selfX = startPoint.x
            let selfY = startPoint.y - size.height/2
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width + 5, height: size.height)
            self.tableView.frame = CGRect.init(x: 5, y: 0, width: size.width, height: size.height)
            break
        case .buttom:
            let selfX = startPoint.x - size.width/2 - 5
            let selfY = startPoint.y - size.height - 5
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width, height: size.height + 5)
            self.tableView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            break
        case .right:
            let selfX = startPoint.x - size.width - 5
            let selfY = startPoint.y - size.height/2
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width + 5, height: size.height)
            self.tableView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            break
        }
    }
    
    private func settingFrame(fromReact: CGRect, size: CGSize) {
        switch self.style.triangleOrientation {
        case .top:
            let selfX = fromReact.origin.x + fromReact.width/2 - size.width/2
            let selfY = fromReact.origin.y + fromReact.height
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width, height: size.height + 5)
            self.tableView.frame = CGRect.init(x: 0, y: 5, width: size.width, height: size.height)
            break
        case .left:
            let selfX = fromReact.origin.x + fromReact.width
            let selfY = fromReact.origin.y + fromReact.height/2 - size.height/2
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width + 5, height: size.height)
            self.tableView.frame = CGRect.init(x: 5, y: 0, width: size.width, height: size.height)
            break
        case .buttom:
            let selfX = fromReact.origin.x + fromReact.width/2 - size.width/2
            let selfY = fromReact.origin.y - size.height - 5
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width, height: size.height + 5)
            self.tableView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            break
        case .right:
            let selfX = fromReact.origin.x - size.width - 5
            let selfY = fromReact.origin.y + fromReact.height/2 - size.height/2
            self.frame = CGRect.init(x: selfX, y: selfY, width: size.width + 5, height: size.height)
            self.tableView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            break
        }
    }
    
    // 设置圆角
    private func settingCorner() {
        if self.style.cornerRadius <= 0 {return}
        self.layer.masksToBounds = true
        if self.style.cornerRadius > 10 {
            self.tableView.layer.cornerRadius = 10
        }else {
            self.tableView.layer.cornerRadius = self.style.cornerRadius
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = self.style.popupBgColor
        tableView.rowHeight = self.cellHeight
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomCell.cellWithTableView(tableView: tableView)
        if self.sourceArray.count > 0 {
            let item = self.sourceArray[indexPath.row]
            let isLast = indexPath.row == self.sourceArray.count - 1 ? true : false
            cell.model = (imgName: item.0, title: item.1, cellSize: CGSize.init(width: self.tableView.popup_width, height: self.cellHeight), style: self.style, isLast: isLast)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.sourceArray[indexPath.row]
        self.clickBlock?(item.1, indexPath.row)
        self.hideBubbleView()
    }
    
    /// show
    public func showBubbleView() {
        let supView: WPPopupView = self.superview as! WPPopupView
        kWindowView.addSubview(supView)
        if self.style.touchHide {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideBubbleView))
            supView.effectView.addGestureRecognizer(tap)
        }
        
        switch self.style.animationOptions {
        case .none:
            self.alpha = 0.0
            UIView.animate(withDuration: 0.33) {
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                self.alpha = 1.0
            }
            
        case .zoom:
            self.layer.setValue(0, forKeyPath: "transform.scale")
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
                self.layer.setValue(1.0, forKeyPath: "transform.scale")
            })
            
        case .smallToBig:
            self.layer.setAffineTransform(CGAffineTransform(scaleX: 0.01,y: 0.01))
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
                self.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0,y: 1.0))
                if self.style.openEffect {
                    supView.effectView.effect = UIBlurEffect(style: .dark)
                }
            })
            
        case .topToCenter,
             .sheetBottomPop: // 无效
            supView.removeFromSuperview()
        case .sheetLeftPop:
            break
        case .sheetRightPop:
            break
        }
    }
    
    /// hide
    @objc private func hideBubbleView() {
        let supView: WPPopupView = self.superview as! WPPopupView
        kWindowView.addSubview(supView)
        
        switch style.animationOptions {
        case .none:
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 0.0
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                supView.removeFromSuperview()
            })
            
        case .zoom:
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 0.0
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
                supView.removeFromSuperview()
            })
            
        case .smallToBig:
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
                self.layer.setAffineTransform(CGAffineTransform(scaleX: 0.01,y: 0.01))
                if self.style.openEffect {
                    supView.effectView.effect = nil
                }
            }, completion: { (_) in
                supView.removeFromSuperview()
            })
            
        case .topToCenter,
             .sheetBottomPop:
            break
        case .sheetLeftPop:
            break
        case .sheetRightPop:
            break
        }
    }
    
    // 画三角尖
    private func addTriangleView(size: CGSize) {
        
        // 防止矫正过多 超出屏幕
        switch self.style.triangleOrientation {
        case .top,
             .buttom:
            if style.adjustDistance + size.width/2 < 0 {
                style.adjustDistance = -size.width/2 + 10
            }else if style.adjustDistance > size.width/2 {
                style.adjustDistance = size.width/2 - 10
            }
        default:
            if style.adjustDistance + size.height/2 < 0 {
                style.adjustDistance = -size.height/2 + 10
            }else if style.adjustDistance > size.height/2 {
                style.adjustDistance = size.height/2 - 10
            }
        }
        
        //创建路径
        let linePath = UIBezierPath()
        switch self.style.triangleOrientation {
        case .top:
            let firstX = size.width/2 + style.adjustDistance
            linePath.move(to: CGPoint.init(x: firstX, y: 0))
            linePath.addLine(to: CGPoint.init(x: firstX - 5, y: 5))
            linePath.addLine(to: CGPoint.init(x: firstX + 5, y: 5))
            break
        case .left:
            let firstY = size.height/2 + style.adjustDistance
            linePath.move(to: CGPoint.init(x: 0, y: firstY))
            linePath.addLine(to: CGPoint.init(x: 5, y: firstY - 5))
            linePath.addLine(to: CGPoint.init(x: 5, y: firstY + 5))
            break
        case .buttom:
            let firstX = size.width/2 + style.adjustDistance
            linePath.move(to: CGPoint.init(x: firstX, y: size.height + 5))
            linePath.addLine(to: CGPoint.init(x: firstX - 5, y: size.height))
            linePath.addLine(to: CGPoint.init(x: firstX + 5, y: size.height))
            break
        case .right:
            let firstY = size.height/2 + style.adjustDistance
            linePath.move(to: CGPoint.init(x: size.width + 5, y: firstY))
            linePath.addLine(to: CGPoint.init(x: size.width, y: firstY - 5))
            linePath.addLine(to: CGPoint.init(x: size.width, y: firstY + 5))
            break
        }
        linePath.close()
        //设施路径画布
        let lineShape = CAShapeLayer()
        lineShape.frame = self.bounds
        lineShape.lineWidth = 1
        lineShape.lineJoin = CAShapeLayerLineJoin.miter
        lineShape.lineCap = CAShapeLayerLineCap.square
        lineShape.strokeColor = self.style.popupBgColor.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = self.style.popupBgColor.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 自定义Cell
class CustomCell: UITableViewCell {
    private var iconImgView: UIImageView?
    private var titleLabel: UILabel?
    private var lineLabel: UILabel?
    
    var model: (imgName: String?, title: String, cellSize: CGSize, style: WPPopupStyle, isLast: Bool?)? {
        didSet {
            self.contentView.backgroundColor = model?.style.popupBgColor
            
            let style: WPPopupStyle = (model?.style)!
            let cellW: CGFloat = (model?.cellSize.width)!
            let cellH: CGFloat = (model?.cellSize.height)!
            
            if model?.imgName == nil ||
                (model?.imgName?.isEmpty)! { // 没有图片
                self.titleLabel?.frame = CGRect.init(x: 15, y: 0, width: cellW - 30, height: cellH)
                self.titleLabel?.text = model?.title
            }else {
                guard let img = UIImage.init(named: (model?.imgName)!) else {return}
                self.iconImgView?.frame = CGRect.init(x: 15, y: 0, width: img.size.width, height: img.size.height)
                iconImgView?.popup_centerY = cellH / 2
                iconImgView?.image = img
                
                self.titleLabel?.frame = CGRect.init(x: img.size.width + 25, y: 0, width: cellW - img.size.width - 40, height: cellH)
                self.titleLabel?.text = model?.title
            }
            
            self.titleLabel?.textColor = model?.style.labelColor
            self.titleLabel?.font = model?.style.labelFont
            self.titleLabel?.textAlignment = (model?.style.labelAlignment)!
            
            if !(model?.isLast)! { // 最后的分割线不显示
                self.lineLabel?.frame = CGRect.init(x: style.lineSpace.leftSpace, y: cellH - lineHeight, width: cellW - style.lineSpace.leftSpace - style.lineSpace.rightSpace, height: lineHeight)
                self.lineLabel?.backgroundColor = model?.style.lineColor
            }
        }
    }
    
    static func cellWithTableView(tableView: UITableView) -> CustomCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = CustomCell(style: .default, reuseIdentifier: "cell")
        }
        return cell as! CustomCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.iconImgView = UIImageView.init()
        self.contentView.addSubview(iconImgView!)
        
        self.titleLabel = UILabel.init()
        self.contentView.addSubview(titleLabel!)
        
        self.lineLabel = UILabel.init()
        self.contentView.addSubview(lineLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
