package com.mall.module.product.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mall.module.product.entity.Category;
import com.mall.module.product.entity.Product;
import java.util.List;

public interface ProductService extends IService<Product> {
    IPage<Product> pageList(int page, int size, Long categoryId, String keyword);
    Product getDetail(Long id);
    Product create(Long sellerId, Product product);
    Product updateProduct(Long sellerId, Long productId, Product product);
    void updateStatus(Long sellerId, Long productId, String status);
    void forceUpdateStatus(Long productId, String status);
    void deleteProduct(Long sellerId, Long productId);
    List<Category> getCategoryTree();
}
