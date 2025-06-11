using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BuenComienzo.Core;
using BuenComienzo.Core.Administracion.To;
using BuenComienzo.Core.Administracion;
using BuenComienzo.Core.Maestros;

namespace BuenComienzo.Paginas.Administracion.Popups
{
    public partial class EditarUsuarios : System.Web.UI.Page
    {
        BuenComienzo.Core.Administracion.Usuarios objUsuarios = new BuenComienzo.Core.Administracion.Usuarios();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarListas();
                if (Request.QueryString["idUsuario"] != null)
                {
                    string idUsuario = Request.QueryString["idUsuario"].ToString();
                    DataTable dtUsuario = objUsuarios.ObtenerUsuario(idUsuario);

                    if (dtUsuario != null && dtUsuario.Rows.Count == 1)
                    {
                        UsuarioTO usuario = Utilidades.ToList<UsuarioTO>(dtUsuario)[0];
                        Utilidades.SeleccionarItem(usuario.TipoDocumento, ddlTipoDocumento);
                        txtPrimerNombre.Value = usuario.PrimerNombre;
                        txtPrimerApellido.Value = usuario.PrimerApellido;
                        txtSegundoNombre.Value = usuario.SegundoNombre;
                        txtSegundoApellido.Value = usuario.SegundoApellido;
                        txtNumeroDocumento.Value = usuario.IdDocumento;
                        txtFechaNacimiento.Value = usuario.FechaNacimiento.ToString("dd/MM/yyyy");
                        txtTelefono.Value = usuario.Telefono;
                        txtCelular.Value = usuario.Celular;
                        txtCorreoElectronico.Value = usuario.CorreoElectronico;

                        txtCorreoElectronicoLaboral.Value = usuario.CorreoElectronicoLaboral;
                        Utilidades.SeleccionarItem(dtUsuario.Rows[0]["IdCoordinador"].ToString(), ddlCoordinador);
                        //txtUsuarioPyms.Value = usuario.UsuarioPyms;
                        //txtNumeroContrato.Value = usuario.NumeroContrato;
                        //txtFechaInicioContrato.Value = usuario.FechaInicioContrato.ToString("dd/MM/yyyy");




                        if (usuario.Password != null)
                        {
                            txtClave.Value = Utilidades.DesEncriptar(usuario.Password);
                            txtClave_confirmation.Value = Utilidades.DesEncriptar(usuario.Password.ToString());
                        }

                        Utilidades.SeleccionarItem(usuario.IdPerfil.ToString(), ddlPerfil);


                        chkActivo.Checked = (usuario.Estado != null && usuario.Estado == "ACTIVO") ? true : false;
                        chkCambioClave.Checked = (usuario.CambioPassword != null && usuario.CambioPassword == true) ? true : false;
                    }
                }
                else
                {

                }

                txtClave.Attributes["type"] = "password";
                txtClave_confirmation.Attributes["type"] = "password";
            }

        }

        private void cargarListas()
        {
            Perfiles objPerfiles = new Perfiles();
            DataTable dtPerfiles = objPerfiles.ConsultarPerfiles();
            Utilidades.CargarLista(ddlPerfil, dtPerfiles, "IdPerfil", "NombrePerfil", true);

            //CoordinadorAgentes objCoordinadores = new CoordinadorAgentes();
            //DataTable dtCoordinadores = objCoordinadores.ObtenerCoordinadores();
            //Utilidades.CargarLista(ddlCoordinador, dtCoordinadores, "IdDocumento", "Nombre", true);

            //Usuarios objCoordinadores = new CoordinadorAgentes();
            DataTable dtCoordinadores = objUsuarios.ConsultarCoordinadoresU();
            Utilidades.CargarLista(ddlCoordinador, dtCoordinadores, "IdCoordinador", "Nombre", true);

            //Se carga la lista de Comunas
            //Comunas objComunas = new Comunas();
            //DataTable dtComunas = objComunas.ConsultarComunas();
            //Utilidades.CargarLista(ddlComuna, dtComunas, "IdComuna", "NombreComuna", true);



        }
    }
}