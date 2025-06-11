using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion
{
    public class Varios
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

        public DataTable ObtenerContadoresBaseDatos(string idUsuario, byte ? idPerfil)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdUsuario", Valor = idUsuario, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(byte) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetContadores", parametros).Tables[0];

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
