using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eCustomer
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public double Prepaids { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
    }

    public class eCustomerQuotation_Route
    {
        public int ID { get; set; }
        public int CustomerID { get; set; }
        public int QuotationID { get; set; }
        public double Price{ get; set; }
        public DateTime Expire_Start{ get; set; }
        public DateTime Expire_End { get; set; }
        public bool IsUSD { get; set; }
        public double Total { get; set; }
        public int PlaceStart { get; set; }
        public int PlaceEnd { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sExpireStart { get; set; }
        public string sExpireEnd { get; set; }
    }
}
