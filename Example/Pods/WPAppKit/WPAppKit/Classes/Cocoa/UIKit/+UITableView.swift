//
//  +UITableView.swift
//  WPAppKit
//
//  Created by 王鹏 on 2019/11/7.
//

import UIKit

public extension UITableView {
    
    // 最后一行的 IndexPath
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return getIndexPathForLastRow(inSection: lastSection)
    }
    
    // 最后一组
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
    
    /// 多少行
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    /// 获取最后一行的 IndexPath
    func getIndexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// 刷新数据
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// 新增一行数据后刷新页面
    func insertRows(_ indexPath: IndexPath,
                    animation: RowAnimation? = UITableView.RowAnimation.none) {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.insertRows(at: [indexPath], with: animation ?? UITableView.RowAnimation.none)
            }
        }
    }
    
    /// 移除一行数据后刷新页面
    func deleteRows(_ indexPath: IndexPath,
                    animation: RowAnimation? = UITableView.RowAnimation.none) {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.deleteRows(at: [indexPath], with: animation ?? UITableView.RowAnimation.none)
            }
        }
    }
    
    /// 检测 IndexPath 是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.row >= 0 &&
            indexPath.section < numberOfSections &&
            indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    /// 滚动到指定位置
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
}

public extension UITableView {
    
    /// 使用类名注册UITableViewHeaderFooterView
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// 使用类名注册UITableViewHeaderFooterView
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// 使用类名注册UITableViewCell
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    /// 使用类名注册UITableViewCell
    func register<T: UITableViewCell>(nib: UINib?,
                                      withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
    
    /// 使用类名注册UITableViewCell
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type,
                                      at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
}
