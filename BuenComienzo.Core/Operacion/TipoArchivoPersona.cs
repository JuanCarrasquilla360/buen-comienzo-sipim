using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using BuenComienzo.Core;
using System.Data;

namespace BuenComienzo.Core.Operacion
{
    public class TipoArchivoPersona
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

        public DataTable ConsultarTipoArchivoPersona()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_TIPOARCHIVOPERSONA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public enum TiposDeArchivoPersona
        {
            DocumentoIdentidad = 1
        }

    }
}
