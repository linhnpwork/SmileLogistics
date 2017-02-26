using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Entities
{
    public class eJob
    {
        public int ID { get; set; }
        public int Type { get; set; }
        public string InvoiceNO { get; set; }
        public string BillLadingNO { get; set; }
        public string TKHQNO { get; set; }
        public string JobID { get; set; }
        public int CustomerID { get; set; }
        public int Quotation_CustomProcID { get; set; }
        public DateTime ProcessedDate { get; set; }
        public DateTime ConsignedDate { get; set; }
        public bool IsConsigned { get; set; }
        public bool IsInformTransportComp { get; set; }
        public bool IsPayedForTransportComp { get; set; }
        public int Status { get; set; }
        public bool IsUrgent { get; set; }
        public string AttachedFiles { get; set; }
        public bool IsPaidFromCustomer { get; set; }
        public double CustomerPrepaids { get; set; }

        public bool IsDeleted { get; set; }
        public eSys_User UpdatedBy { get; set; }
        public DateTime LastestUpdate { get; set; }
        public string sLastestUpdate { get; set; }
        public string sProcessedDate { get; set; }
        public string sConsignedTime { get; set; }
        public string sConsignedDate { get; set; }
        public string sStatus { get; set; }
        public eCustomer Customer { get; set; }
    }
}
