using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmileLogistics.Web.bases;
using SmileLogistics.DAL;
using SmileLogistics.DAL.Entities;
using SmileLogistics.DAL.Helpers;

namespace SmileLogistics.Web.modules.systems
{
    public partial class Modules : BaseControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadActions();
                LoadParents();
            }
        }

        private void LoadParents()
        {
            string html = "<select id=\"info-parent\" class=\"form-control\">";

            html += "<option value=\"" + int.MinValue.ToString() + "\"> --- ROOT --- </option>";

            List<eSys_Module> treeeSys_Modules = BindListModules(int.MinValue);

            if (treeeSys_Modules != null)
            {
                foreach (eSys_Module obj in treeeSys_Modules)
                {
                    var levelSep = "";
                    for (int i = 0; i < obj.Level; i++)
                        levelSep += "---";

                    html += "<option value=\"" + obj.ID.ToString() + "\">" + levelSep + " " + obj.Name + "</option>";
                }
            }

            html += "</select>";

            divModuleParent.InnerHtml = html;
        }

        private List<eSys_Module> BindListModules(int parentId)
        {
            using (DALTools dalTools = new DALTools())
            {
                List<eSys_Module> result = new List<eSys_Module>();
                List<eSys_Module> all = dalTools.Sys_Module_GetEs(parentId);
                if (all != null)
                {
                    foreach (eSys_Module eSys_Module in all)
                    {
                        result.Add(eSys_Module);
                        if (dalTools.Sys_Module_HasChildren(eSys_Module.ID))
                        {
                            result.AddRange(BindListModules(eSys_Module.ID));
                        }
                    }
                }

                return result;
            }
        }

        private void LoadActions()
        {
            string html = "<select id=\"dllActions\" name = \"dllActions\" class=\"select-chosen form-control\" data-placeholder=\"Các tính năng trong Chức năng...\" multiple>";

            List<eSys_ModuleAction> sActions = ((IEnumerable<Sys_Module_Actions>)Enum.GetValues(typeof(Sys_Module_Actions))).Select(o => new eSys_ModuleAction() { ID = (int)o, Name = o.ToString() }).ToList();

            for (int i = 0; i < sActions.Count; i++)
                html += "<option value = \"" + sActions[i].ID.ToString() + "\">" + sActions[i].Name + "</option>";

            html += "</select>";

            divModuleActions.InnerHtml = html;
        }
    }
}