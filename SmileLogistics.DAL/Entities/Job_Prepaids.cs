using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eJob_Prepaid
    {
        public int ID { get; set; }
        public int JobID { get; set; }
        public double Money { get; set; }
        public string Description { get; set; }
        public DateTime PrepaidDate { get; set; }
        public int EmployID { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sPrepaidDate { get; set; }
        public string EmployName { get; set; }
    }
}
