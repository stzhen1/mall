package com.mall.module.product.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.mall.common.Result;
import com.mall.module.product.entity.Category;
import com.mall.module.product.entity.Product;
import com.mall.module.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/list")
    public Result<IPage<Product>> list(@RequestParam(defaultValue = "1") int page,
                                        @RequestParam(defaultValue = "10") int size,
                                        @RequestParam(required = false) Long categoryId,
                                        @RequestParam(required = false) String keyword) {
        return Result.ok(productService.pageList(page, size, categoryId, keyword));
    }

    @GetMapping("/{id}")
    public Result<Product> detail(@PathVariable Long id) {
        return Result.ok(productService.getDetail(id));
    }

    @PostMapping
    @PreAuthorize("hasRole('SELLER')")
    public Result<Product> create(Authentication auth, @RequestBody Product product) {
        return Result.ok(productService.create(Long.valueOf(auth.getName()), product));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('SELLER')")
    public Result<Product> update(Authentication auth, @PathVariable Long id, @RequestBody Product product) {
        return Result.ok(productService.updateProduct(Long.valueOf(auth.getName()), id, product));
    }

    @PutMapping("/{id}/status")
    @PreAuthorize("hasAnyRole('SELLER', 'ADMIN')")
    public Result<?> updateStatus(Authentication auth, @PathVariable Long id,
                                   @RequestBody(required = false) Product product) {
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
        String status = (product != null && product.getStatus() != null) ? product.getStatus() : null;
        if (isAdmin) {
            productService.forceUpdateStatus(id, status);
        } else {
            productService.updateStatus(Long.valueOf(auth.getName()), id, status);
        }
        return Result.ok();
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('SELLER')")
    public Result<?> delete(Authentication auth, @PathVariable Long id) {
        productService.deleteProduct(Long.valueOf(auth.getName()), id);
        return Result.ok();
    }

    @GetMapping("/categories")
    public Result<List<Category>> categories() {
        return Result.ok(productService.getCategoryTree());
    }
}
