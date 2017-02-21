using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eRoute
    {
        public int ID { get; set; }
        public int TransCompID { get; set; }
        public int StartPoint { get; set; }
        public int EndPoint { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public eTransportCompany TransportCompany { get; set; }
        public eTransportPlace PointStart { get; set; }
        public eTransportPlace PointEnd { get; set; }
    }
}
