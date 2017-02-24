﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eQuotation_CustomsProcess
    {
        public int ID { get; set; }
        public bool IsUSD { get; set; }
        public DateTime ExpireFrom { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sExpireFrom { get; set; }
        public List<eCustomsProcess_FeeDetail> FeeDetails { get; set; }
    }

    public class eCustomsProcess_FeeDetail
    {
        public int ID { get; set; }
        public int QuotationID { get; set; }
        public int FeeTypeID { get; set; }
        public double Price { get; set; }
        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public eQuotation_CustomsProcess Quotation { get; set; }
        public eCustomsProcess_FeeType FeeType { get; set; }
    }

    //public class eTransportCompany_VehicleType_Load
    //{
    //    public int ID { get; set; }
    //    public int TransComp_VehicleTypeID { get; set; }
    //    public int VehicleLoadID { get; set; }
    //    public bool IsDeleted { get; set; }
    //    public eSys_User UpdatedBy { get; set; }
    //    public DateTime LastestUpdate { get; set; }
    //    public string sLastestUpdate { get; set; }
    //    public eVehicleType VehicleType { get; set; }
    //    public eVehicleLoad VehicleLoad { get; set; }
    //}

    //public class aTransportCompany_VehicleType
    //{
    //    public int ID { get; set; }
    //    public List<aTransportCompany_VehicleType_Load> Loads { get; set; }
    //}
    //public class aTransportCompany_VehicleType_Load
    //{
    //    public int ID { get; set; }
    //}
}