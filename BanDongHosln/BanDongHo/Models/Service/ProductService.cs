﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BanDongHo.Domain.DataContext;

namespace BanDongHo.Models.Service
{
    public class ProductService
    {
        public static IEnumerable<SANPHAM> GetListProductsSelling()
        {
            IEnumerable<SANPHAM> ListProductsSelling = null;

            // nghiệp vụ
            // * Nếu ngày lấy danh sách trước ngày 15 hàng tháng thì sẽ lấy danh sách tháng trước
            // * Lấy ra danh sách sản phẩm bán chạy trong tháng đó
            // * Nếu danh sách lấy ra là null thì trả về danh sách 3 sản phẩm mới nhất

            int Month = DateTime.Today.Month;
            int Year = DateTime.Today.Year;
            if (DateTime.Today.Day < 15)
            {
                if (Month - 1 == 0)
                {
                    Year -= 1;
                    Month = 12;
                }
                else
                {
                    Month -= 1;
                }
            }

            BANDONGHOEntities db = new BANDONGHOEntities();
            try
            {
                ListProductsSelling = (from sp in db.SANPHAMs
                                       let totalQuantity = (from ct in db.CHITIETDONHANGs
                                                            join dh in db.DONHANGs on ct.MADH equals dh.MADH
                                                            where sp.MASP == ct.MASP && dh.NGAYDAT.Month == Month && dh.NGAYDAT.Year == Year
                                                            select ct.SOLUONG).Sum()
                                       where totalQuantity > 0
                                       orderby totalQuantity descending
                                       select sp).Take(3);
            }
            catch (Exception e) { }
            
            if(ListProductsSelling==null || ListProductsSelling.ToList().Count<3)
            {
                return GetListNewProducts().Take(3);
            }

            List<SANPHAM> lsp = ListProductsSelling.ToList();

            return ListProductsSelling;
        }
        public static IEnumerable<SANPHAM> GetListNewProducts()
        {
            IEnumerable<SANPHAM> ListNewProducts = null;
            BANDONGHOEntities db = new BANDONGHOEntities();
            ListNewProducts = from sp in db.SANPHAMs
                              orderby sp.MASP descending
                              select sp;
            return ListNewProducts;
        }
    }
}