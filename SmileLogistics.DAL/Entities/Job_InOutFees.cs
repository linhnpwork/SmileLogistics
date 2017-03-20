using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eJob_InOutFee
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Company { get; set; }
        public string InvoiceNO { get; set; }
        public DateTime InvoiceDate { get; set; }
        public double Money { get; set; }
        public bool IsUSD { get; set; }
        public string AttachedFiles { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sInvoiceDate { get; set; }
    }
}
