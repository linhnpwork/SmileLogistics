﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eVehicleLoad
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public double FullLoad { get; set; }
        public string Description { get; set; }
        public int VehicleTypeID { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public eVehicleType VehicleType { get; set; }
    }
}