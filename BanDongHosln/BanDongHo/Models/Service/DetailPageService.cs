﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BanDongHo.Domain.DataContext;

namespace BanDongHo.Models.Service
{
    public class DetailPageService
    {
        public static SANPHAM LoadDetailProduct(int Id)
        {
            SANPHAM res = null;
            BANDONGHOEntities db = new BANDONGHOEntities();
            res = db.SANPHAMs.Find(Id);
            return res;
        }
        public static IEnumerable<SANPHAM> LoadListProductRelative(int Id)
        {
            SANPHAM product = LoadDetailProduct(Id);
            if (product == null)
            {
                return ProductService.GetListNewProducts().Take(3);
            }
            // nếu ID là có
            IEnumerable<SANPHAM> res = null;
            BANDONGHOEntities db = new BANDONGHOEntities();
            res = (from sp in db.SANPHAMs
                   where sp.MATH == product.MATH
                   select sp);
            if (res != null && res.ToList().Count < 3)
            {
                // lấy những sản phẩm cùng thương hiệu 
                int amount = res.ToList().Count;
                List<SANPHAM> lsp = new List<SANPHAM>();
                foreach (var item in res)
                {
                    lsp.Add(item);
                }
                // lấy những sản phẩm mới
                IEnumerable<SANPHAM> NewProducts = ProductService.GetListNewProducts().Take(3 - amount);
                foreach (var item in NewProducts)
                {
                    lsp.Add(item);
                }
                return lsp;
            }
            return res;
        }
        public static string GetTag(int Id)
        {
            string res = "";
            BANDONGHOEntities db = new BANDONGHOEntities();
            // lấy ra mã thương hiệu
            int trademark = db.SANPHAMs.Find(Id).MATH.Value;
            // lấy ra tên thương hiệu
            res = db.THUONGHIEUx.Find(trademark).TENTH;
            return res;
        }
    }
}