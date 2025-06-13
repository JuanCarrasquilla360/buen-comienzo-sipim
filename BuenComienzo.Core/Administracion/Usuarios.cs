using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;

namespace BuenComienzo.Core.Administracion
{
    public class Usuarios
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                return strError;
            }
        }

        public bool InsertarUsuario(string idDocumento, string tipoDocumento, byte? idPerfil, string password, 
                                    bool? cambioPassword, string primerNombre, string segundoNombre, 
                                    string primerApellido, string segundoApellido, DateTime? fechaNacimiento, string telefono, 
                                    string celular, string correoElectronico, string correoElectronicoLaboral,
                                    string idCoordinador, string idUsuarioCreacion, string idUsuarioModificacion, string estado)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoDocumento", Valor = tipoDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(byte?) });
                parametros.Add(new Parametro { NombreParametro = "@Password", Valor = Utilidades.Encriptar(password), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CambioPassword", Valor = cambioPassword, Tipo = typeof(bool) });                
                parametros.Add(new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CorreoElectronico", Valor = correoElectronico, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CorreoElectronicoLaboral", Valor = correoElectronicoLaboral, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Estado", Valor = estado, Tipo = typeof(string) });

                objBd.ejecutarProcedimiento("dbop_AddTBL_USUARIOS", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }


        public bool ActualizarUsuario(string idDocumento, string tipoDocumento, byte? idPerfil, string password,
                                    bool? cambioPassword, string primerNombre, string segundoNombre,
                                    string primerApellido, string segundoApellido, DateTime? fechaNacimiento, string telefono,
                                    string celular, string correoElectronico, string correoElectronicoLaboral,
                                    string idCoordinador, string idUsuarioModificacion, string estado)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoDocumento", Valor = tipoDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(byte?) });
                parametros.Add(new Parametro { NombreParametro = "@Password", Valor = Utilidades.Encriptar(password), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CambioPassword", Valor = cambioPassword, Tipo = typeof(bool) });                
                parametros.Add(new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CorreoElectronico", Valor = correoElectronico, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@correoElectronicoLaboral", Valor = correoElectronicoLaboral, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Estado", Valor = estado, Tipo = typeof(string) });

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_USUARIOS", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        

        public DataTable ObtenerUsuario(string idUsuario)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idUsuario, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_USUARIOS", parametros).Tables[0];

                //Si retorna datos la consulta, se procede con la desencripción del password
                //if (dtDatos.Rows.Count > 0)
                //    dtDatos.Rows[0]["Password"] = Utilidades.DesEncriptar(dtDatos.Rows[0]["Password"].ToString());

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUsuarios(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                //parametros.Add(new Parametro { NombreParametro = "@IdNitOperador", Valor = idNitOperador, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_USUARIOS", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUsuarios()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_USUARIOS", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool CambioClave(string idUsuario, string password)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@Idusuario", Valor = idUsuario, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Password", Valor = Utilidades.Encriptar(password), Tipo = typeof(string) });

                objBd.ejecutarProcedimiento("dbop_CAMBIOCLAVE", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public UsuarioTO RegistrarIngreso(string usuario, string password)
        {
            UsuarioTO objUsuario;

            DataTable dtUsuario = ObtenerUsuario(usuario);
            if (dtUsuario.Rows.Count > 0)
            {
                if (password == Utilidades.DesEncriptar(dtUsuario.Rows[0]["Password"].ToString()))
                {
                    objUsuario = Utilidades.ToList<UsuarioTO>(dtUsuario)[0];
                    return objUsuario;
                }
                else
                    return null;
            }
            else
                return null;
        }

        public DataTable ConsultarUsuariosPsicologos()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_PSICOLOGOS", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUsuariosSociales()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_SOCIALES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUsuariosDDL()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_USUARIOSDDL", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarCoordinadores()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarCoordinadoresTransversales()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADOREST", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUsuariosEnfermeria()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_USUARIOS_ENFERMERIA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarAgentes()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_AGENTES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarCoordinadoresU()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORESU", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

    }
}

