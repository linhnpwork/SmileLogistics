using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    #region Defines

    public class eSys_Module
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public string Path { get; set; }
        public string IconClass { get; set; }
        public int ParentID { get; set; }
        public int Level { get; set; }
        public string Description { get; set; }
        public string Actions { get; set; }
        public bool ShowInMenu { get; set; }


        public bool IsDeleted { get; set; }
        public string ParentName { get; set; }
        public List<eSys_Module> Children { get; set; }
    }

    public enum Sys_Module_Actions
    {
        Access = 0,
        Create = 1,
        Edit = 2,
        Delete = 3,
        SetPermission = 4,
        Block = 5,
        Unblock = 6,
        ViewHistories = 7,

        Job_Trangthai_Capnhat = 8,

        Job_TamungKH_Them = 9,
        Job_TamungKH_Sua = 10,
        Job_TamungKH_Xoa = 11,
        Job_TamungKH_Capnhat = 12,

        Job_DMHanghoa_Them = 13,
        Job_DMHanghoa_Sua = 14,
        Job_DMHanghoa_Xoa = 15,
        Job_DMHanghoa_Capnhat = 16,

        Job_TTHQ_Them = 17,
        Job_TTHQ_Sua = 18,
        Job_TTHQ_Xoa = 19,
        Job_TTHQ_Capnhat = 20,

        Job_Vanchuyen_Them = 21,
        Job_Vanchuyen_Sua = 22,
        Job_Vanchuyen_Xoa = 23,

        Job_Thuchi_Them = 24,
        Job_Thuchi_Sua = 25,
        Job_Thuchi_Xoa = 26,

        Job_TamungNV_Them_Yeucau = 27,
        Job_TamungNV_Sua_Yecau = 28,
        Job_TamungNV_Xoa_Yeucau = 29,
        Job_TamungNV_Duyetchi = 30,
        Job_TamungNV_Capnhat = 31,

        Job_Nghiepvu_KetoanDuyet = 32,
        Job_Nghiepvu_GiamdocDuyet = 33,
        Job_Nghiepvu_ChuyenKetoan = 34,
        Job_Nghiepvu_ChuyenNhanvien = 35,
        Job_Nghiepvu_XacnhanHoantat = 36,
    };

    public class eSys_ModuleAction
    {
        /// <summary>
        /// Tên Action
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// ID Action
        /// </summary>
        public int ID { get; set; }
    }

    #endregion
}
