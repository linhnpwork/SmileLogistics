using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eJob_Good
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public int JobID { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string JobCODE { get; set; }
    }

    public class eJob_GoodFilter
    {
        public string Code { get; set; }
        public string Name { get; set; }
    }
}
