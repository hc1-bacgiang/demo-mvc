﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BanDongHo.Domain.DataContext;

namespace BanDongHo.Models.Models
{
    public class Cart
    {
        private List<CartItem> Products = new List<CartItem>();

        // phương thức thêm sản phẩm
        public void AddProduct(int id, int soluong)
        {
            BANDONGHOEntities db = new BANDONGHOEntities();

            var sanpham = db.SANPHAMs.Find(id);
            var item = (from i in Products
                        where i.Product.MASP == sanpham.MASP
                        select i).SingleOrDefault();
            // nếu sp có trong cart rồi thì cập nhật số lượng
            if (item != null)
            {
                item.Quantity += soluong;
            }
            // nếu sản phẩm chưa có thì thêm mới
            else
            {
                Products.Add(new CartItem { Product = sanpham, Quantity = soluong });
            }
        }
        // phương thức xóa sản phẩm
        public void RemoveProduct(int id)
        {
            BANDONGHOEntities db = new BANDONGHOEntities();

            var sanpham = db.SANPHAMs.Find(id);
            var item = (from i in Products
                        where i.Product.MASP == sanpham.MASP
                        select i).SingleOrDefault();
            // linq
            // Products.Where(i=>i.Product.MASP==sanpham.MASP).SingleOrDefault();
            if (item != null)
            {
                Products.Remove(item);
            }
        }
        // phương thức cập nhật
        public void UpdateProduct(int id, int soluong)
        {
            BANDONGHOEntities db = new BANDONGHOEntities();

            var sanpham = db.SANPHAMs.Find(id);
            var item = (from i in Products
                        where i.Product.MASP == sanpham.MASP
                        select i).SingleOrDefault();
            // linq
            // Products.Where(i=>i.Product.MASP==sanpham.MASP).SingleOrDefault();
            if (item != null)
            {
                item.Quantity = soluong;
            }
        }
        // Phương thức lấy ra danh sách
        public List<CartItem> GetList()
        {
            return Products;
        }
        // phương thức tính tổng tiền
        public double TotalMoney()
        {
            if(Products.Count==0)
            {
                return 0;
            }
            return Products.Sum(pi => pi.Quantity * pi.Product.DONGIA.Value);
        }
    }
}