using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eCustomsProcess_Quotation
    {
        public int ID { get; set; }
        public bool IsUSD { get; set; }
        public DateTime ExpireFrom { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sExpireFrom { get; set; }
        public List<eCustomsProcess_QuotationDetail> FeeDetails { get; set; }
    }

    public class eCustomsProcess_QuotationDetail
    {
        public int ID { get; set; }
        public int QuotationID { get; set; }
        public int CustomsFeeVehicleLoadID { get; set; }
        public double Price { get; set; }
        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public eCustomsProcess_Quotation Quotation { get; set; }
        public eCustomsProcess_FeeType_VehicleLoad CustomsProcess_FeeType_VehicleLoads { get; set; }
        public int FeeTypeID { get; set; }
        public string FeeTypeName { get; set; }
        public int VehicleTypeID { get; set; }
        public string VehicleTypeName { get; set; }
        public int VehicleLoadID { get; set; }
        public string VehicleLoadName { get; set; }
    }

    public class eCustomerQuotation_Custom_Filter
    {
        public int CustomerID { get; set; }
    }

    public class eCustomerQuotation_Custom
    {
        public int ID { get; set; }
        public int CustomerID { get; set; }
        public bool IsUSD { get; set; }
        public DateTime Expire_Start { get; set; }
        public DateTime Expire_End { get; set; }
        public double USDRate { get; set; }
        public double Total_In { get; set; }
        public double Total_Out { get; set; }
        public string Description { get; set; }
        public double DecreasePercentForSecondCont { get; set; }

        public bool IsDeleted { get; set; }
        public int UpdatedByID { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sExpireStart { get; set; }
        public string sExpireEnd { get; set; }
        public List<eCustomerQuotation_Customs_ByType> FeeTypes { get; set; }
        public List<aCustomerQuotation_Customs_ByType> aFeeTypes { get; set; }
        public int JobID { get; set; }
    }

    public class eCustomerQuotation_Customs_ByType
    {
        public int ID { get; set; }
        public int QuotationID { get; set; }
        public int FeeTypeID { get; set; }
        public int Order { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sFeeTypeName { get; set; }
        public List<eCustomerQuotation_CustomsDetail> Details { get; set; }
    }

    public class eCustomerQuotation_CustomsDetail
    {
        public int ID { get; set; }
        public int QuotationID { get; set; }
        public int FeeDetailID { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public double Total { get; set; }


        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sLoadName { get; set; }
        public int VehicleLoadID { get; set; }
    }

    public class aCustomerQuotation_Customs_ByType
    {
        public int FeeTypeID { get; set; }
        public int Order { get; set; }
        public List<aCustomerQuotation_CustomsDetail> Details { get; set; }
    }

    public class aCustomerQuotation_CustomsDetail
    {
        public int FeeDetailID { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
    }
}
