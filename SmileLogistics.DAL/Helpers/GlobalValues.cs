using SmileLogistics.DAL.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmileLogistics.DAL.Helpers
{
    public class GlobalValues
    {
        #region Defines

        public static int DefaultPagingSize = 10;

        public static string DateFormat_VN = "dd/MM/yyyy";
        /// <summary>
        /// Class chứa kết quả Response
        /// </summary>
        public class ResponseData
        {
            /// <summary>
            /// Mã lỗi.
            /// </summary>
            public int ErrorCode { get; set; }
            /// <summary>
            /// Thông báo/Mô tả tương ứng với ErrorCode.
            /// </summary>
            public string Message { get; set; }
            /// <summary>
            /// Data của Response, có thể NULL.
            /// </summary>
            public object Data { get; set; }
        }

        public static string[] Countries = {
            "Afghanistan",
            "Albania",
            "Algeria",
            "American Samoa",
            "Andorra",
            "Angola",
            "Anguilla",
            "Antarctica",
            "Antigua and Barbuda",
            "Argentina",
            "Armenia",
            "Aruba",
            "Australia",
            "Austria",
            "Azerbaijan",
            "Bahamas",
            "Bahrain",
            "Bangladesh",
            "Barbados",
            "Belarus",
            "Belgium",
            "Belize",
            "Benin",
            "Bermuda",
            "Bhutan",
            "Bolivia, Plurinational State of",
            "Bonaire, Sint Eustatius and Saba",
            "Bosnia and Herzegovina",
            "Botswana",
            "Bouvet Island",
            "Brazil",
            "British Indian Ocean Territory",
            "Brunei Darussalam",
            "Bulgaria",
            "Burkina Faso",
            "Burundi",
            "Cambodia",
            "Cameroon",
            "Canada",
            "Cape Verde",
            "Cayman Islands",
            "Central African Republic",
            "Chad",
            "Chile",
            "China",
            "Christmas Island",
            "Cocos (Keeling) Islands",
            "Colombia",
            "Comoros",
            "Congo",
            "Congo, The Democratic Republic of the",
            "Cook Islands",
            "Costa Rica",
            "Croatia",
            "Cuba",
            "Curaçao",
            "Cyprus",
            "Czech Republic",
            "Côte d'Ivoire",
            "Denmark",
            "Djibouti",
            "Dominica",
            "Dominican Republic",
            "Ecuador",
            "Egypt",
            "El Salvador",
            "Equatorial Guinea",
            "Eritrea",
            "Estonia",
            "Ethiopia",
            "Falkland Islands (Malvinas)",
            "Faroe Islands",
            "Fiji",
            "Finland",
            "France",
            "French Guiana",
            "French Polynesia",
            "French Southern Territories",
            "Gabon",
            "Gambia",
            "Georgia",
            "Germany",
            "Ghana",
            "Gibraltar",
            "Greece",
            "Greenland",
            "Grenada",
            "Guadeloupe",
            "Guam",
            "Guatemala",
            "Guernsey",
            "Guinea",
            "Guinea-Bissau",
            "Guyana",
            "Haiti",
            "Heard Island and McDonald Islands",
            "Holy See (Vatican City State)",
            "Honduras",
            "Hong Kong",
            "Hungary",
            "Iceland",
            "India",
            "Indonesia",
            "Iran, Islamic Republic of",
            "Iraq",
            "Ireland",
            "Isle of Man",
            "Israel",
            "Italy",
            "Jamaica",
            "Japan",
            "Jersey",
            "Jordan",
            "Kazakhstan",
            "Kenya",
            "Kiribati",
            "Korea, Democratic People's Republic of",
            "Korea, Republic of",
            "Kuwait",
            "Kyrgyzstan",
            "Lao People's Democratic Republic",
            "Latvia",
            "Lebanon",
            "Lesotho",
            "Liberia",
            "Libya",
            "Liechtenstein",
            "Lithuania",
            "Luxembourg",
            "Macao",
            "Macedonia, Republic of",
            "Madagascar",
            "Malawi",
            "Malaysia",
            "Maldives",
            "Mali",
            "Malta",
            "Marshall Islands",
            "Martinique",
            "Mauritania",
            "Mauritius",
            "Mayotte",
            "Mexico",
            "Micronesia, Federated States of",
            "Moldova, Republic of",
            "Monaco",
            "Mongolia",
            "Montenegro",
            "Montserrat",
            "Morocco",
            "Mozambique",
            "Myanmar",
            "Namibia",
            "Nauru",
            "Nepal",
            "Netherlands",
            "New Caledonia",
            "New Zealand",
            "Nicaragua",
            "Niger",
            "Nigeria",
            "Niue",
            "Norfolk Island",
            "Northern Mariana Islands",
            "Norway",
            "Oman",
            "Pakistan",
            "Palau",
            "Palestinian Territory, Occupied",
            "Panama",
            "Papua New Guinea",
            "Paraguay",
            "Peru",
            "Philippines",
            "Pitcairn",
            "Poland",
            "Portugal",
            "Qatar",
            "Romania",
            "Russian Federation",
            "Rwanda",
            "Réunion",
            "Saint Barthélemy",
            "Saint Helena, Ascension and Tristan da Cunha",
            "Saint Kitts and Nevis",
            "Saint Lucia",
            "Saint Martin (French part)",
            "Saint Pierre and Miquelon",
            "Saint Vincent and the Grenadines",
            "Samoa",
            "San Marino",
            "Sao Tome and Principe",
            "Saudi Arabia",
            "Senegal",
            "Serbia",
            "Seychelles",
            "Sierra Leone",
            "Singapore",
            "Sint Maarten (Dutch part)",
            "Slovakia",
            "Slovenia",
            "Solomon Islands",
            "Somalia",
            "South Africa",
            "South Georgia and the South Sandwich Islands",
            "South Sudan",
            "Spain",
            "Sri Lanka",
            "Sudan",
            "Suriname",
            "Svalbard and Jan Mayen",
            "Swaziland",
            "Sweden",
            "Switzerland",
            "Syrian Arab Republic",
            "Taiwan",
            "Tajikistan",
            "Tanzania, United Republic of",
            "Thailand",
            "Timor-Leste",
            "Togo",
            "Tokelau",
            "Tonga",
            "Trinidad and Tobago",
            "Tunisia",
            "Turkey",
            "Turkmenistan",
            "Turks and Caicos Islands",
            "Tuvalu",
            "Uganda",
            "Ukraine",
            "United Arab Emirates",
            "United Kingdom",
            "United States",//"United States",
            "United States Minor Outlying Islands",
            "Uruguay",
            "Uzbekistan",
            "Vanuatu",
            "Venezuela, Bolivarian Republic of",
            "Viet Nam",
            "Virgin Islands, British",
            "Virgin Islands, U.S.",
            "Wallis and Futuna",
            "Western Sahara",
            "Yemen",
            "Zambia",
            "Zimbabwe",
            "Åland Islands"};

        #endregion

        #region DAL defines

        private static List<Commons.eStatus> _Job_AgentPrepaid_Status = null;
        public static List<Commons.eStatus> Job_AgentPrepaid_Status
        {
            get
            {
                if (_Job_AgentPrepaid_Status == null)
                {
                    _Job_AgentPrepaid_Status = new List<Commons.eStatus>()
                    {
                        new Commons.eStatus() { ID = 0, Name = "Yêu cầu từ nhân viên"},
                        new Commons.eStatus() { ID = 1, Name = "Kết toán đã duyệt chi"},
                        new Commons.eStatus() { ID = 2, Name = "Đã hoàn tất xử lý"},
                    };
                }

                return _Job_AgentPrepaid_Status;
            }
            set { _Job_AgentPrepaid_Status = value; }
        }

        private static List<Commons.eStatus> _Job_QuotationRoute_Status = null;
        public static List<Commons.eStatus> Job_QuotationRoute_Status
        {
            get
            {
                if (_Job_QuotationRoute_Status == null)
                {
                    _Job_QuotationRoute_Status = new List<Commons.eStatus>()
                    {
                        new Commons.eStatus() { ID = 0, Name = "Đang báo giá"},
                        new Commons.eStatus() { ID = 1, Name = "Chờ nhận hàng"},
                        new Commons.eStatus() { ID = 2, Name = "Đang vận chuyển"},
                        new Commons.eStatus() { ID = 10, Name = "Đã giao hàng"},
                    };
                }

                return _Job_QuotationRoute_Status;
            }
            set { _Job_QuotationRoute_Status = value; }
        }

        private static List<Commons.eStatus> _JobStatus = null;
        public static List<Commons.eStatus> JobStatus
        {
            get
            {
                if (_JobStatus == null)
                {
                    _JobStatus = new List<Commons.eStatus>()
                    {
                        new Commons.eStatus() { ID = 0, Name = "Đang xử lý"},
                        new Commons.eStatus() { ID = 1, Name = "Chờ Kế toán duyệt"},
                        new Commons.eStatus() { ID = 2, Name = "Chờ Giám đốc duyệt"},
                        new Commons.eStatus() { ID = 3, Name = "Chuyển Kế toán bổ sung"},
                        new Commons.eStatus() { ID = 4, Name = "Chuyển nhân viên bổ sung"},
                        new Commons.eStatus() { ID = 10, Name = "Hoàn tất"},
                    };
                }

                return _JobStatus;
            }
            set { _JobStatus = value; }
        }

        private static List<Commons.eStatus> _JobTypes = null;
        public static List<Commons.eStatus> JobTypes
        {
            get
            {
                if (_JobTypes == null)
                {
                    _JobTypes = new List<Commons.eStatus>()
                    {
                        new Commons.eStatus() { ID = 0, Name = "Nhập"},
                        new Commons.eStatus() { ID = 1, Name = "Xuất"},
                    };
                }

                return _JobTypes;
            }
            set { _JobTypes = value; }
        }

        private static List<Commons.eStatus> _Sys_UserStatuses = null;
        public static List<Commons.eStatus> Sys_UserStatuses
        {
            get
            {
                if (_Sys_UserStatuses == null)
                {
                    _Sys_UserStatuses = new List<Commons.eStatus>()
                    {
                        new Commons.eStatus(){ ID = 0, Name="Pending"},
                        new Commons.eStatus(){ ID = 1, Name="Active"},
                        new Commons.eStatus(){ ID = 2, Name="Blocked"},
                    };
                }

                return _Sys_UserStatuses;
            }
            set { _Sys_UserStatuses = value; }
        }

        private static List<Commons.eStatus> _TransportCompanyStatuses = null;
        public static List<Commons.eStatus> TransportCompanyStatuses
        {
            get
            {
                if (_TransportCompanyStatuses == null)
                {
                    _TransportCompanyStatuses = new List<Commons.eStatus>()
                    {
                        new Commons.eStatus(){ ID = 0, Name="Active"},
                        new Commons.eStatus(){ ID = 1, Name="NotRecommended"},
                        new Commons.eStatus(){ ID = 2, Name="StopWorking"},
                    };
                }

                return _TransportCompanyStatuses;
            }
            set { _TransportCompanyStatuses = value; }
        }

        #endregion
    }
}
