using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eCustomsProcess_FeeType
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsDeleted { get; set; }
        public int UpdatedByID { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }

        public List<eCustomsProcess_FeeType_VehicleLoad> VehicleLoads { get; set; }
    }

    public class eCustomsProcess_FeeType_VehicleLoad
    {
        public int ID { get; set; }
        public int CustomsFeeTypeID { get; set; }
        public int VehicleLoadID { get; set; }
        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }

        public eVehicleType VehicleType { get; set; }
        public int VehicleTypeID { get; set; }
        public string VehicleLoadName { get; set; }
    }

    //public class aCustomsProcess_FeeType
    //{
    //    public int ID { get; set; }
    //    public double Value { get; set; }
    //}

    public class aCustomsProcess_FeeType_VehicleLoad
    {
        public int ID { get; set; }
        public int TypeID { get; set; }
        public double Price { get; set; }
    }
}
