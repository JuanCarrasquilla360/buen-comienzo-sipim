using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Administracion
{
    public class Seguridad
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

        public DataTable ConsultarTablaSeguridad()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_PERMISOS", null).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarSeguridad(int idPermiso, string nombrePerfil, bool quitar)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@idPermiso", Valor = idPermiso, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@NombrePerfil", Valor = nombrePerfil, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Quitar", Valor = quitar, Tipo = typeof(bool) });

                objBd.ejecutarProcedimiento("dbop_GuardarPermiso", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool TienePermiso(int idPerfil, string objeto)
        {
            parametros = new List<Parametro>();
            parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(int) });
            parametros.Add(new Parametro { NombreParametro = "@Objeto", Valor = objeto, Tipo = typeof(string) });

            if (objBd.ejecutarProcedimientoDS("dbop_TienePermiso", parametros).Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
    }
}
