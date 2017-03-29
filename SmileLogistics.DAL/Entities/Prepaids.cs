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

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sPrepaidDate { get; set; }
    }

    public class eCustomer_Prepaid
    {
        public int ID { get; set; }
        public int CustomerID { get; set; }
        public double Money { get; set; }
        public string Description { get; set; }
        public DateTime PrepaidDate { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sPrepaidDate { get; set; }
        public string CustomerName { get; set; }
    }

    public class eAgent_Prepaid
    {
        public int ID { get; set; }
        public int JobID { get; set; }
        public int AgentID { get; set; }
        public DateTime RequestedDate { get; set; }
        public string Description { get; set; }
        public int Status { get; set; }
        public double TotalRequest { get; set; }
        public double TotalPaid { get; set; }        

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sRequestedDate { get; set; }
        public string AgentName { get; set; }
        public string sStatus { get; set; }
    }
}
