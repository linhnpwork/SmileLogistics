using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eTransportCompany
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public int Status { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string StatusName { get; set; }
        public List<eTransportCompany_VehicleType> VehicleTypes { get; set; }
        public List<eRoute> Routes { get; set; }
    }

    public class eTransportCompany_VehicleType
    {
        public int ID { get; set; }
        public int TransCompID { get; set; }
        public int VehicleTypeID { get; set; }
        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public List<eTransportCompany_VehicleType_Load> Loads { get; set; }

        public string sVehicleTypeName { get; set; }
    }

    public class eTransportCompany_VehicleType_Load
    {
        public int ID { get; set; }
        public int TransComp_VehicleTypeID { get; set; }
        public int VehicleLoadID { get; set; }
        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public eVehicleType VehicleType { get; set; }
        public eVehicleLoad VehicleLoad { get; set; }
    }

    public class aTransportCompany_VehicleType
    {
        public int ID { get; set; }
        public List<aTransportCompany_VehicleType_Load> Loads { get; set; }
    }
    public class aTransportCompany_VehicleType_Load
    {
        public int ID { get; set; }
    }
}
