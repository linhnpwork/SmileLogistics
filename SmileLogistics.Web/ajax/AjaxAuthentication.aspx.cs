using Decided.Libs;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Helpers;
using SmileLogistics.DAL.Entities;

namespace SmileLogistics.Web.ajax
{
    public partial class AjaxAuthentication : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string mod = Request.Form["mod"];
            if (string.IsNullOrEmpty(mod))
                return;
            switch (mod.ToLower())
            {
                case "login":
                    Login();
                    break;
            }
        }

        void Login()
        {
            string email = Request.Form["email"];
            string password = Request.Form["password"];

            if (string.IsNullOrEmpty(email))
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = 1,
                    Message = "Please provide the email!",
                }));

                return;
            }

            if (string.IsNullOrEmpty(password))
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = 2,
                    Message = "Please provide the password!",
                }));

                return;
            }

            if (password.Length < 5)
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = 3,
                    Message = "Password must be at least 5 characters long!",
                }));

                return;
            }

            PrivateEncryptor encryptor = new PrivateEncryptor();

            //if (email.Trim().ToLower() == SiteValues.GodeSys_User_Username.ToLower())
            //{
            //    if (password == SiteValues.GodeSys_User_Password)
            //    {
            //        DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
            //        {
            //            Data = encryptor.Encrypt("0"),
            //            ErrorCode = 0,
            //            Message = "Login successfull!",
            //        }));
            //        return;
            //    }
            //}

            if (!RegexUtils.IsMatchRegex(RegexUtils.Regex_Email, email))
            {
                DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                {
                    Data = null,
                    ErrorCode = 4,
                    Message = "Email is invalid!",
                }));

                return;
            }

            using (DALTools dalTools = new DALTools())
            {
                Sys_User eSys_User = dalTools.Sys_User_Get(email, password);
                if (eSys_User == null)
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = null,
                        ErrorCode = 5,
                        Message = "Authentication fail!",
                    }));
                else
                {
                    DoResponse(JsonConvert.SerializeObject(new GlobalValues.ResponseData()
                    {
                        Data = encryptor.Encrypt(eSys_User.ID.ToString()),
                        ErrorCode = 0,
                        Message = "Login successfull!",
                    }));
                }
            }
        }
    }
}