package com.mall.module.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mall.common.BusinessException;
import com.mall.module.product.entity.Category;
import com.mall.module.product.entity.Product;
import com.mall.module.product.entity.ProductImage;
import com.mall.module.product.mapper.CategoryMapper;
import com.mall.module.product.mapper.ProductImageMapper;
import com.mall.module.product.mapper.ProductMapper;
import com.mall.module.product.service.ProductService;
import com.mall.module.user.entity.User;
import com.mall.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {
    private final ProductMapper productMapper;
    private final CategoryMapper categoryMapper;
    private final ProductImageMapper imageMapper;
    private final UserService userService;

    @Override
    public IPage<Product> pageList(int page, int size, Long categoryId, String keyword) {
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<Product>()
                .eq(Product::getStatus, "ON");
        if (categoryId != null) wrapper.eq(Product::getCategoryId, categoryId);
        if (StringUtils.hasText(keyword)) wrapper.like(Product::getName, keyword);
        wrapper.orderByDesc(Product::getCreatedAt);
        return productMapper.selectPage(new Page<>(page, size), wrapper);
    }

    @Override
    public Product getDetail(Long id) {
        Product product = productMapper.selectById(id);
        if (product == null) throw new BusinessException("Product not found");
        product.setImages(imageMapper.selectList(
                new LambdaQueryWrapper<ProductImage>().eq(ProductImage::getProductId, id)
                        .orderByAsc(ProductImage::getSortOrder)));
        User seller = userService.getById(product.getSellerId());
        if (seller != null) product.setSellerName(seller.getUsername());
        return product;
    }

    @Override
    @Transactional
    public Product create(Long sellerId, Product product) {
        product.setSellerId(sellerId);
        product.setStatus("ON");
        productMapper.insert(product);
        saveImages(product);
        return product;
    }

    @Override
    @Transactional
    public Product updateProduct(Long sellerId, Long productId, Product product) {
        Product existing = productMapper.selectById(productId);
        if (existing == null || !existing.getSellerId().equals(sellerId))
            throw new BusinessException("Not your product");
        product.setId(productId);
        product.setSellerId(sellerId);
        productMapper.updateById(product);
        if (product.getImages() != null) {
            imageMapper.delete(new LambdaQueryWrapper<ProductImage>().eq(ProductImage::getProductId, productId));
            saveImages(product);
        }
        return getDetail(productId);
    }

    @Override
    public void updateStatus(Long sellerId, Long productId, String status) {
        Product existing = productMapper.selectById(productId);
        if (existing == null || !existing.getSellerId().equals(sellerId))
            throw new BusinessException("Not your product");
        if (status == null) status = "ON".equals(existing.getStatus()) ? "OFF" : "ON";
        Product update = new Product();
        update.setId(productId);
        update.setStatus(status);
        productMapper.updateById(update);
    }

    @Override
    public void forceUpdateStatus(Long productId, String status) {
        Product existing = productMapper.selectById(productId);
        if (existing == null) throw new BusinessException("Product not found");
        if (status == null) status = "ON".equals(existing.getStatus()) ? "OFF" : "ON";
        Product update = new Product();
        update.setId(productId);
        update.setStatus(status);
        productMapper.updateById(update);
    }

    @Override
    public void deleteProduct(Long sellerId, Long productId) {
        Product existing = productMapper.selectById(productId);
        if (existing == null || !existing.getSellerId().equals(sellerId))
            throw new BusinessException("Not your product");
        productMapper.deleteById(productId);
    }

    @Override
    public List<Category> getCategoryTree() {
        List<Category> all = categoryMapper.selectList(null);
        Map<Long, List<Category>> byParent = all.stream()
                .collect(Collectors.groupingBy(c -> c.getParentId() == null ? 0L : c.getParentId()));
        List<Category> roots = byParent.getOrDefault(0L, new ArrayList<>());
        for (Category root : roots)
            root.setChildren(byParent.getOrDefault(root.getId(), new ArrayList<>()));
        return roots;
    }

    private void saveImages(Product product) {
        if (product.getImages() != null) {
            for (ProductImage img : product.getImages()) {
                img.setProductId(product.getId());
                imageMapper.insert(img);
            }
        }
    }
}
