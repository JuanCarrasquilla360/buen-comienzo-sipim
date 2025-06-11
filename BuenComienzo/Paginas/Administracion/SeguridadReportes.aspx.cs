using BuenComienzo.Core;
using BuenComienzo.Core.Administracion.To;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas.Administracion
{
    public partial class SeguridadReportes : System.Web.UI.Page
    {

        Core.Administracion.SeguridadReportes objSeguridad = new Core.Administracion.SeguridadReportes();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    CargarGrid();
                }
                catch (Exception ex)
                {
                    string idUsuario = ((UsuarioTO)Session[Core.VariablesSession.DatosUsuario]).IdDocumento;
                    Logging.log(idUsuario, ex.Message);
                    Utilidades.MostrarMensaje("Ha ocurrido un error en el sistema. Por favor contacte al administrador del sistema", TipoMensaje.Error, false);
                }
            }

        }

        private void CargarGrid()
        {
            //this.Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "EstiloGrid", "LoadDataTablesScripts(ConfigurarGrid('" + gvPerfiles.ClientID + "'));", true);
            DataTable dtPerfiles = objSeguridad.ConsultarTablaSeguridad();
            gvSeguridad.DataSource = dtPerfiles;
            gvSeguridad.DataBind();
            gvSeguridad.PreRender += gvSeguridad_PreRender;
        }
        protected void gvSeguridad_PreRender(object sender, EventArgs e)
        {
            gvSeguridad.UseAccessibleHeader = true;
            gvSeguridad.HeaderRow.TableSection = TableRowSection.TableHeader;
            foreach (TableCell celda in gvSeguridad.HeaderRow.Cells)
            {
                celda.Style.Add("vertical-align", "middle");
                celda.Style.Add("text-align", "center");
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dtSeguridad = new DataTable();

                dtSeguridad.Columns.Add(new DataColumn { ColumnName = "IdReporte", DataType = typeof(int) });
                dtSeguridad.Columns.Add(new DataColumn { ColumnName = "NombrePerfil", DataType = typeof(string) });

                if (!string.IsNullOrEmpty(hidSeguridad.Value))
                {
                    foreach (string opcion in hidSeguridad.Value.ToString().Split(','))
                    {
                        string[] prop = opcion.Split('_');
                        DataRow nuevaFila = dtSeguridad.NewRow();

                        nuevaFila[0] = int.Parse(prop[0]);
                        nuevaFila[1] = prop[1];

                        dtSeguridad.Rows.Add(nuevaFila);
                    }
                }

                if (objSeguridad.ActualizarSeguridad(dtSeguridad))
                {
                    CargarGrid();
                    Utilidades.MostrarMensaje("Se ha guardado exitosamente los permisos", Core.TipoMensaje.Exito, false);
                }
                else
                {
                    Utilidades.MostrarMensaje(objSeguridad.Error, Core.TipoMensaje.Error, false);
                }
            }
            catch (Exception ex)
            {
                string idUsuario = ((UsuarioTO)Session[Core.VariablesSession.DatosUsuario]).IdDocumento;
                Logging.log(idUsuario, ex.Message);
                Utilidades.MostrarMensaje("Ha ocurrido un error en el sistema. Por favor contacte al administrador del sistema", Core.TipoMensaje.Error, false);
            }
        }
        protected void gvSeguridad_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LiteralControl checkBox;
                for (int i = 2; i < e.Row.Cells.Count; i++)
                {
                    string activado = (e.Row.Cells[i].Text == "1") ? "checked='checked'" : "";
                    string id = gvSeguridad.DataKeys[e.Row.RowIndex]["IdReporte"].ToString() + "_" + gvSeguridad.HeaderRow.Cells[i].Text;
                    checkBox = new LiteralControl("<div class='toggle-switch toggle-switch-success'><label><input id='" + id + "' runat='server' type='checkbox' " + activado + "/><div class='toggle-switch-inner' style='text-align:left'></div><div class='toggle-switch-switch'><i class='fa fa-check'></i></div></label></div>");
                    e.Row.Cells[i].Controls.Clear();
                    e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
                    e.Row.Cells[i].Controls.Add(checkBox);
                }
            }

            if (e.Row.RowType == DataControlRowType.Header)
                e.Row.Cells[1].Text = "";

            //Se oculta la columna que contiene el código
            e.Row.Cells[0].Visible = false;
            e.Row.Cells[1].Font.Bold = true;
        }
    }
}