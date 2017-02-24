using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eQuotationRoute
    {
        public int ID { get; set; }
        public int RouteID { get; set; }
        public int VehicleLoadID { get; set; }
        public double Price { get; set; }
        public bool IsSamePrice { get; set; }
        public double Price_RoundedTrip { get; set; }
        public DateTime Expire_Start { get; set; }
        public DateTime Expire_End { get; set; }
        public bool IsUSD { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public eRoute Route { get; set; }
        public eTransportCompany_VehicleType_Load Load { get; set; }
        public string sExpireStart { get; set; }
        public string sExpireEnd { get; set; }
    }
}
