//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BanDongHo.Domain.DataContext
{
    using System;
    using System.Collections.Generic;
    
    public partial class LOAISANPHAM
    {
        public LOAISANPHAM()
        {
            this.CHITIETSANPHAMs = new HashSet<CHITIETSANPHAM>();
        }
    
        public string MALOAISP { get; set; }
        public string TENLOAISP { get; set; }
    
        public virtual ICollection<CHITIETSANPHAM> CHITIETSANPHAMs { get; set; }
    }
}
