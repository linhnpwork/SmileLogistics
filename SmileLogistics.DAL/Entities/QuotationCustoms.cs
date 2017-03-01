using System;
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
        public string sFeeTypeName { get; set; }
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
        public int QuotationID { get; set; }
        public double Total_In { get; set; }
        public double Total_Out { get; set; }
        public double DecreasePercentFromSecondCont { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sExpireStart { get; set; }
        public string sExpireEnd { get; set; }
        public List<eCustomerQuotation_CustomsDetail> FeeDetails { get; set; }

    }

    public class eCustomerQuotation_CustomsDetail
    {
        public int ID { get; set; }
        public int QuotationID { get; set; }
        public int FeeDetailID { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }
        public int Order { get; set; }
        public double Total_In { get; set; }
        public double Total_Out { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sFeeTypeName { get; set; }
        public int FeeTypeID { get; set; }
    }
}
